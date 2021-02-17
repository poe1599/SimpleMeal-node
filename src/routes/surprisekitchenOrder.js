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

// 預約資訊
// http://localhost:4000/surprisekitchenOrder/addreservation
router.post("/addreservation", upload.none(), async (req, res) => {
  const member_sid = "1";
  const order_sid = (+new Date()).toString().slice(4);
  const [
    row,
  ] = await db.query(
    "INSERT INTO `surprisekitchen_order`(`sid`, `member_number`, `order_sid`, `reservation_date`, `reservation_time`, `num_adult`, `num_child`, `adult_price`, `child_price`, `num_meal`, `remark`, `reservation_price`, `reservation_name`, `reservation_tel`, `reservation_email`, `payment_method`, `check_date`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
    [
      order_sid,
      member_sid,
      req.body.reservation_date,
      req.body.reservation_time,
      req.body.num_adult,
      req.body.num_child,
      req.body.adult_price,
      req.body.child_price,
      req.body.num_meal,
      req.body.remark,
      req.body.reservation_price,
      req.body.reservation_name,
      req.body.reservation_tel,
      req.body.reservation_email,
      req.body.payment_method,
    ]
  );
  res.json(result);
});

// // 用query string拿資料
// // http://localhost:4000/test/getmealbyquery?sid=1
// router.get("/getmealbyquery", async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.query.sid,
//   ]);
//   res.json(result);
// });

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
