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


// 用query string拿資料 取得點數
// http://localhost:4000/reward/getGooDList?good_type=1
//good_type 1合作廠商優惠 2購物金回饋
router.get("/getGooDList", async (req, res) => {

  //將完成的成就點數加總
  const GooDList = await db.query("SELECT * FROM `exchange_good` where good_type = ? ", [
    req.query.good_type,
  ]);
  res.json(GooDList[0]);
});

// 用query string拿資料 取得兌換紀錄
// http://localhost:4000/reward/getExchangeRecord
router.get("/getExchangeRecord", async (req, res) => {

  //直接在SQL中處理日期格式以及加一個月的日期
  const GooDList = await db.query("SELECT m.exchange_sid, m.spend_point, DATE_FORMAT(m.event_time, '%Y/%m/%d') event_time, DATE_FORMAT(DATE_ADD(m.event_time,INTERVAL 1 MONTH ), '%Y/%m/%d') end_date, m.used_date, e.good_name, e.good_pic FROM milestone_user m join exchange_good e on m.exchange_sid = e.good_ID and m.memner_number = ? ORDER by m.event_time ASC", [
    req.query.sid,
  ]);
  res.json(GooDList[0]);
});

//http://localhost:4000/reward/setExchange
router.post("/setExchange", upload.none(), async (req, res) => {

  //檢查
  let success = true;
  let msg = "";
  let totalPotint = 0;
  let cost = 0;
  let good_type = 0;
  let discount = "null";
  const count = req.body.count;
  const good_ID = req.body.good_ID;
  const id = req.session.admin.id;
  //將完成的成就點數加總
  const totalGetPoiont = await db.query(
    "select sum(reward_point) Sum from (select m.milestone_sid, m.stone_name, m.progress_goal, m.reward_point, sum(e.add_progress) AddProgress from milestone_manager m left join event_record e on e.event_time > m.event_startime and (m.event_endtime> e.event_time or m.event_endtime is null) and e.member_number = ? and m.event_trigger = e.event_trigger GROUP by m.milestone_sid) temp where temp.progress_goal <= temp.AddProgress",
    [id]
  );
  //將所有花費過的點數加總
  const totalSpendPoint = await db.query(
    "select sum(spend_point) Sum from `milestone_user` where memner_number = ? ",
    [id]
  );
  totalPotint = totalGetPoiont[0][0].Sum - totalSpendPoint[0][0].Sum;
  if (totalPotint <= 0) {
    msg = "點數不足";
    success = false;
  }
  if(success){
    const GooDList = await db.query("SELECT * FROM `exchange_good` where good_ID = ? ", [
      good_ID,
    ]);
    if(GooDList[0].length != 1)
    {
      msg = "商品資訊錯誤";
      success = false;
    }
    else{
      if(GooDList[0][0].need_point * count > totalPotint)
      {
        msg = "剩餘點數不足";
        success = false;
      }
      else{
        cost = GooDList[0][0].need_point * count;
        good_type = GooDList[0][0].good_type;
        if(GooDList[0][0].good_discount != NaN)
          discount = GooDList[0][0].good_discount;
      }
    }
  }
  if(success)
  {
    const [
      newExchange
    ] = await db.query(
      "INSERT INTO `milestone_user`"+
      "(`exchange_sid`, "+
      "`good_type`, "+
      "`spend_point`, "+
      "`event_time`, "+
      "`memner_number`, "+
      "`discount` ) VALUES ( ?,?,?,now(),?,?)",
      [
        good_ID,
        good_type,
        cost,
        id,
        discount,
      ]
    );
      msg= "新增";
  }

  res.json({ success: success, msg: msg});
})


router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
