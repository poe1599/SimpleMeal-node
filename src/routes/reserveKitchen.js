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

// 拿訂單資料
// http://localhost:4000/reservekitchen/getorder
router.get("/getorder", async (req, res) => {
  const member_number = "20210001";
  const [
    row,
  ] = await db.query(
    "SELECT * FROM `surprisekitchen_order` WHERE `member_number` = ? and `check_date` is null ",
    [member_number]
  );
  // console.log(row);

  // 當資料庫沒有預約資料時
  if (row.length === 0) {
    res.json([{ sid: 0 }]);
    return
  } 

  // 當資料庫有1筆預約資料時
  if(row.length === 1) {
    // 處理日期格式
    row[0].reservation_date = moment(row[0].reservation_date).format(
      "YYYY-MM-DD"
    );
    res.json(row);
    return    
  }

  // 當資料庫有多筆預約資料時 (不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約)
  if(row.length >= 1) {
    res.json([{ sid: 0 ,msg:'不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約'}]);
    return 
  }

});

// 訂單結帳
router.post("/ordercheck", upload.none(), async (req, res) => {
  const member_number = "20210001";
  const order_sid = (+new Date()).toString().slice(4);
  const [
    row,
  ] = await db.query(
    "UPDATE `surprisekitchen_order` SET `order_sid` = ?, `reservation_name` = ?, `reservation_tel` = ?, `reservation_email` = ?, `payment_method` = ?, `check_date` = NOW()  WHERE`member_number` = ? and`check_date` is null",
    [
      order_sid,
      req.body.reservation_name,
      req.body.reservation_tel,
      req.body.reservation_email,
      req.body.payment_method,
      member_number,
    ]
  );
  const result = { order_sid: order_sid };
  res.json(result);
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
