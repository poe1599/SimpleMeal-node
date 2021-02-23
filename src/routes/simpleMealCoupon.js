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

// 買餐券
// http://localhost:4000/simplemealcoupon/addcheck
router.post("/addcheck", upload.none(), async (req, res) => {
  const member_sid = req.session.admin.id;
  const order_sid = (+new Date()).toString().slice(4);

  // 資料庫增加新的餐券訂單
  const [
    row,
  ] = await db.query(
    "INSERT INTO `cart_simplemealcoupon`(`order_sid`,`member_sid`, `combination_sid`, `combination_name`, `description`, `quantity`, `total_coupon_num`, `total_price`, payment_method ,`check_date`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
    [
      order_sid,
      member_sid,
      req.body.combination_sid,
      req.body.combination_name,
      req.body.description,
      req.body.quantity,
      req.body.total_coupon_num,
      req.body.total_price,
      req.body.payment_method,
    ]
  );

  // 註銷已使用的優惠券(需先判斷優惠碼, 避免更動到)
  if (req.body.couponString !== null && req.body.couponString !== "") {
    const [
      couponData,
    ] = await db.query(
      "UPDATE `milestone_user` SET `used_date`= now() where `good_type` = 2 and `discount_code` = ? ",
      [req.body.couponString]
    );
  }

  // 會員中心增加購買的餐券數量
  const [
    newMemberCenter,
  ] = await db.query(
    "UPDATE `membercenter` SET `simplemeal_coupon`=`simplemeal_coupon` + ? where `id`= ?",
    [req.body.total_coupon_num, member_sid]
  );

  const result = { order_sid: order_sid };
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
