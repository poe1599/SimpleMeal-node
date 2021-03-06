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
  if (!req.session.admin) {
    return res.redirect("/");
  }

  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  next();
});

// 拿訂單資料
// http://localhost:4000/reservekitchen/getorder
router.get("/getorder", async (req, res) => {
  const member_number = req.session.admin.member_number;
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
    return;
  }

  // 當資料庫有1筆預約資料時
  if (row.length === 1) {
    // 處理日期格式
    row[0].reservation_date = moment(row[0].reservation_date).format(
      "YYYY-MM-DD"
    );
    res.json(row);
    return;
  }

  // 當資料庫有多筆預約資料時 (不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約)
  if (row.length >= 1) {
    res.json([
      {
        sid: 0,
        msg: "不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約",
      },
    ]);
    return;
  }
});

// 訂單結帳
router.post("/ordercheck", upload.none(), async (req, res) => {
  const member_number = req.session.admin.member_number;
  const order_sid = (+new Date()).toString().slice(4);

  // 更新現有的預約資訊並填入結帳日期
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
  
  const [apoitment]=
  await db.query('SELECT * FROM `surprisekitchen_order` WHERE `order_sid`=?',[order_sid]);



  //寫進度到成就系統 預約廚房
  //預約廚房的花費
  await db.query(
    "INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,1 ,? )",
    [req.session.admin.id,apoitment[0].reservation_price]
  );
  //記預約一次
  await db.query(
    "INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,5 ,1 )",
    [req.session.admin.id]
  );

  // 註銷已使用的優惠券(需先判斷優惠碼, 避免更動到)
  if (req.body.couponString !== null && req.body.couponString !== "") {
    const [
      couponData,
    ] = await db.query(
      "UPDATE `coupon_user` SET `used_date`= now() where `good_type` in (2, 3) and `discount_code` = ? ",
      [req.body.couponString]
    );
  }

  const result = { order_sid: order_sid };
  res.json(result);
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
