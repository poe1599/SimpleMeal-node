const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

// middle well
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

// 拿資料
// http://localhost:4000/mealdelivery/getdeliverycart
router.get("/getdeliverycart", async (req, res) => {
  const member_sid = "1";
  const [
    thisTime,
  ] = await db.query(
    "select * from `cart_mealdelivery` where `member_sid` = ? and `next_time` = 0",
    [member_sid]
  );
  const [
    nextTime,
  ] = await db.query(
    "select * from `cart_mealdelivery` where `member_sid` = ? and `next_time` = 1",
    [member_sid]
  );
  res.json({ thisTime, nextTime });
});

// 改變數量
// http://localhost:4000/mealdelivery/setmealquantity?sid=${sid}&quantity=${quantity}
router.get("/setmealquantity", async (req, res) => {
  const member_sid = "1";

  if (req.query.quantity < 1 || req.query.quantity > 10) {
    res.json({
      success: false,
      msg: "wrong quantity",
    });
  } else {
    const [
      result,
    ] = await db.query(
      "UPDATE `cart_mealdelivery` SET `quantity`= ? WHERE  `sid`= ? ",
      [req.query.quantity, req.query.sid]
    );
    res.json({ success: true, msg: "change quantity" });
  }
});

// 改這次
router.get("/tothistime", async (req, res) => {
  const member_sid = "1";
  const sidArray = req.query.str.split(",");
  sidArray.map(async(v, i) => {
    const [result] = await db.query(
      "UPDATE `cart_mealdelivery` SET `next_time`= 0 WHERE `member_sid`= ? and `sid`= ?",
     [member_sid,v]
    );
  });
  res.json({ success: true, msg: "set this time", sidArray: sidArray });
});

// 改下次
router.get("/tonexttime", async (req, res) => {
  const member_sid = "1";
  const sidArray = req.query.str.split(",");
  sidArray.map(async(v, i) => {
    const [result] = await db.query(
      "UPDATE `cart_mealdelivery` SET `next_time`= 1 WHERE `member_sid`= ? and `sid`= ?",
     [member_sid,v]
    );
  });
  res.json({ success: true, msg: "set next time", sidArray: sidArray });
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
