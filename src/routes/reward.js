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
// http://localhost:4000/reward/getExchangeRecord?sid=1
router.get("/getExchangeRecord", async (req, res) => {

  //直接在SQL中處理日期格式以及加一個月的日期
  const GooDList = await db.query("SELECT m.exchange_sid, m.spend_point, DATE_FORMAT(m.event_time, '%Y/%m/%d') event_time, DATE_FORMAT(DATE_ADD(m.event_time,INTERVAL 1 MONTH ), '%Y/%m/%d') end_date, m.used_date, e.good_name, e.good_pic FROM milestone_user m join exchange_good e on m.exchange_sid = e.good_ID and m.memner_number = ? ORDER by m.event_time ASC", [
    req.query.sid,
  ]);
  res.json(GooDList[0]);
});

//http://localhost:4000/reward/setExchange
router.post("/setExchange", upload.none(), async (req, res) => {
  let success = false;
  let msg = "";
  let totalPotint = 0;
  const count = req.body.count;
  const good_ID = req.body.good_ID;
  console.log("count",count,"good_ID",good_ID);
})


router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
