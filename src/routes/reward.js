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


router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
