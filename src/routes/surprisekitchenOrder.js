const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

//不需要登入也可以看得到
//沒加[],會包含屬性質都出現
//如果,之後加命名,則是屬性的名稱
//round1是()的命名
//獲取該日期的場次是否有被預約
// http://localhost:4000/surprisekitchenOrder/getReservationTime?reservation_date=0000-00-00
router.get("/getReservationTime", async (req, res) => {
  const [ReservationTime] = await db.query(
    "SELECT (select true FROM surprisekitchen_order WHERE reservation_date = date(?) and reservation_time = '10:00') 'round1', (select true FROM surprisekitchen_order WHERE reservation_date = date(?) and reservation_time = '14:00') 'round2', (select true FROM surprisekitchen_order WHERE reservation_date = date(?) and reservation_time = '18:00') 'round3'"
  ,[req.query.reservation_date, req.query.reservation_date, req.query.reservation_date]);
  res.json(ReservationTime)
})

// middle well
// 如果req.session.admin沒有登入的資料, 就跳回首頁
// 取得baseUrl與url, 將其放在locals
router.use((req, res, next) => {
  // 沒登入? 出去! 現在!
      if (!req.session.admin) {
      return res.redirect('/');
  }
  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  next();
});

// 預約資訊
// http://localhost:4000/surprisekitchenOrder/addreservation
router.post("/addreservation", upload.none(), async (req, res) => {
  const member_number = req.session.admin.member_number;
  const order_sid = (+new Date()).toString().slice(4);

  const [
    databaseOrderNow,
  ] = await db.query(
    "SELECT * FROM `surprisekitchen_order` WHERE `member_number` = ? and `check_date` is null ",
    [member_number]
  );

  // 先確認資料庫有沒有該會員的未結帳預約, 如果已經有了就刪掉舊預約
  if (databaseOrderNow.length === 1){
    [
      deleteDatabaseOrderNow
    ] = await db.query(
      "DELETE FROM `surprisekitchen_order` WHERE `member_number` = ? and `check_date` is null ",
      [member_number]
    );
  }

  // 寫入新預約
  const [
    row,
  ] = await db.query(
    "INSERT INTO `surprisekitchen_order`(`sid`, `member_number`, `order_sid`, `reservation_date`, `reservation_time`, `num_adult`, `num_child`, `adult_price`, `child_price`, `num_meal`, `remark`, `reservation_price`) VALUES (null, ?, ?, ?, ?, ?, ?, 500, 100, ?, ?, ? )",
    [
      member_number,
      order_sid,
      req.body.reservation_date,
      req.body.reservation_time,
      req.body.num_adult,
      req.body.num_child,
      req.body.num_meal,
      req.body.remark,
      req.body.num_adult * 500 + req.body.num_child * 100,
    ]
  );

 

  res.json({ row, order_sid, msg: "" });
});

//單純拿全部
// http://localhost:4000/surprisekitchenOrder/getReservationInfo
// router.get("/getReservationInfo", async (req, res) => {
//   const [result] = await db.query("SELECT `reservation_date`, `reservation_time`FROM `surprisekitchen_order` WHERE 1");
//   res.json(result);
// });

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
