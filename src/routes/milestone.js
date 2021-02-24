const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

// middleware
// 如果req.session.admin沒有登入的資料, 就跳回首頁
// 取得baseUrl與url, 將其放在locals
router.use((req, res, next) => {
  // 沒登入? 出去! 現在!
  //     if (!req.session.admin) {
  //     return res.redirect('/');
  // }

  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  next();
});

// 單純拿全部
// // http://localhost:4000/test/getallmeal
// router.get("/getallmeal", async (req, res) => {
//   const [result] = await db.query("SELECT * FROM `meal`");
//   res.json(result);
// });

// 用query string拿資料 取得成就列表
// http://localhost:4000/milestone/getMilestoneList?sid=1&filter=finish&page=1&perpage=4
router.get("/getMilestoneList", async (req, res) => {
  let filter = req.query.filter;
  let filterQuery = " ";
  let limit = " limit ";
  switch (filter) {
    case "limit":
      filterQuery = " and event_endtime is not null ";
      break;
    case "finish":
      filterQuery = " and AddProgress >= progress_goal ";
      break;
    case "unfinish":
      filterQuery = " and AddProgress < progress_goal or AddProgress is null ";
      break;
    default:
      filterQuery = " and 1 = 1 ";
  }

  if (req.query.perpage == 0)
    //畫面小於576px 不下limit
    limit = " ";
  else
    limit +=
      req.query.perpage * (req.query.page - 1) + "," + req.query.perpage + " ";
  const result = await db.query(
    "select * from (select m.milestone_sid, m.stone_name, m.progress_goal, m.reward_point, m.subs, m.event_startime, m.event_endtime, m.unfinished_goal_pic, m.finished_goal_pic, sum(e.add_progress) AddProgress, t.Subs TriggerSubs from milestone_manager m join trigger_describe t on t.trigger_ID = m.event_trigger left join event_record e on e.event_time > m.event_startime and (m.event_endtime> e.event_time or m.event_endtime is null) and e.member_number = ? and m.event_trigger = e.event_trigger GROUP by m.Milestone_sid) temp where 1=1 " +
      filterQuery +
      limit,
    [req.query.sid]
  );
  res.json(result[0]);
});

// 用query string拿資料 取得點數
// http://localhost:4000/milestone/getPoint?sid=1
//動態產生點數沒有存放在特定位置 每次都要計算 總共取得的點數 以及總共花費的點數 相減而成
router.get("/getPoint", async (req, res) => {
  //將完成的成就點數加總
  const totalGetPoiont = await db.query(
    "select sum(reward_point) Sum from (select m.milestone_sid, m.stone_name, m.progress_goal, m.reward_point, sum(e.add_progress) AddProgress from milestone_manager m left join event_record e on e.event_time > m.event_startime and (m.event_endtime> e.event_time or m.event_endtime is null) and e.member_number = ? and m.event_trigger = e.event_trigger GROUP by m.milestone_sid) temp where temp.progress_goal <= temp.AddProgress",
    [req.query.sid]
  );
  //將所有花費過的點數加總
  const totalSpendPoint = await db.query(
    "select sum(spend_point) Sum from `milestone_user` where member_number = ? ",
    [req.query.sid]
  );
  res.json({
    totalGetPoiont: totalGetPoiont[0][0].Sum,
    totalSpendPoint: totalSpendPoint[0][0].Sum,
  });
});

// // 用params拿資料
// // http://localhost:4000/test/getmealbyparams/1
// router.get("/getmealbyparams/:sid?", async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.params.sid,
//   ]);
//   res.json(result);
// });

// 用post提供資料庫訊息
// http://localhost:4000/test/postmealsid (用POSTMAN測試 或 用Live server打開根目錄的testpost.html)
// router.post("/postmealsid", upload.none(), async (req, res) => {
//   const result = await db.query("select * from `meal` where `sid` = ?", [
//     req.body.sid,
//   ]);
//   res.json(result);
// });

// 用在購物車取得該會員有什麼優惠券
router.get("/cartForDiscount", async (req, res) => {
  const member_number = req.session.admin.id;
  const [
    result,
  ] = await db.query(
    "SELECT * FROM `milestone_user` WHERE `member_number` = ? and `good_type` in (2, 3) and `used_date` is null ",
    [member_number]
  );

  // console.log(result);
  res.json(result);
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
