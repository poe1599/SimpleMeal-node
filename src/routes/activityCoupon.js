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

// 增加100元購物金到coupon_user
// http://localhost:4000/activityCoupon/getlemoncoupon
router.get("/getlemoncoupon", async (req, res) => {
  const member_number = req.session.admin.id;
  const discount_code = 123;

  // 取得優惠券項目資料表
  // const [exChangeData] = await db.query("select * from `exchange_good` where `good_ID` = 9");
  // res.json(exChangeData);

  // 檢查coupon_user, 該會員是否有sid 9兌換商品編號
  const [
    milestoneUserData,
  ] = await db.query(
    "SELECT * FROM `coupon_user` WHERE `member_number`=? and `exchange_sid`= 9",
    [member_number]
  );

  if (milestoneUserData.length === 0) {
    const [
      result,
    ] = await db.query(
      "INSERT INTO `coupon_user`(`exchange_sid`, `good_type`, `event_time`, `member_number`, `discount`, `discount_code`, `used_date`) VALUES (9, 3, NOW(), ?, 100, ?, null)",
      [member_number, discount_code]
    );
    res.json({ msg: "拿到優惠券", success: true });
    return;
  }

  res.json({ msg: "拿過了", success: false });
});

// 單純拿全部
// http://localhost:4000/test/getallmeal
// router.get("/getallmeal", async (req, res) => {
//   const [result] = await db.query("SELECT * FROM `meal`");
//   res.json(result);
// });

// 用query string拿資料
// http://localhost:4000/activityCoupon/getlemoncoupon?good_ID=9
// router.get("/getlemoncoupon", async (req, res) => {
//   const [result] = await db.query("select * from `exchange_good` where `good_ID` = 9");
//   res.json(result);
// });

// 用params拿資料
// http://localhost:4000/test/getmealbyparams/1
// router.get("/getmealbyparams/:sid?", async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.params.sid,
//   ]);
//   res.json(result);
// });

// 用post提供資料庫訊息
// http://localhost:4000/test/postmealsid (用POSTMAN測試 或 用Live server打開根目錄的testpost.html)
// router.post("/postmealsid", upload.none(), async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.body.sid,
//   ]);
//   res.json(result);
// });

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
