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

// 單純拿全部
// http://localhost:4000/simplemealcoupon/addcheck
// router.post("/addcheck", upload.none(), async (req, res) => {
//   const member_sid = "1";
//   const order_sid = (+new Date()).toString().slice(4);
//   const [
//     row,
//   ] = await db.query(
//     "INSERT INTO `cart_simplemealcoupon`(`order_sid`,`member_sid`, `combination_sid`, `combination_name`, `description`, `quantity`, `total_coupon_num`, `total_price`, payment_method ,`check_date`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
//     [
//       order_sid,
//       member_sid,
//       req.body.combination_sid,
//       req.body.combination_name,
//       req.body.description,
//       req.body.quantity,
//       req.body.total_coupon_num,
//       req.body.total_price,
//       req.body.payment_method,
//     ]
//   );
//   const result = { order_sid: order_sid };
//   res.json(result);
// });

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

router.get("/setallthistime", async (req, res) => {
  const member_sid = "1";
  const [
    result,
  ] = await db.query(
    "UPDATE `cart_mealdelivery` SET `next_time`= 0 WHERE `member_sid`= ? and `next_time`= 1",
    [member_sid]
  );
  res.json({ success: true, msg: "set all this time" });
});

router.get("/setallnexttime", async (req, res) => {
  const member_sid = "1";
  const [
    result,
  ] = await db.query(
    "UPDATE `cart_mealdelivery` SET `next_time`= 1 WHERE `member_sid`= ? and `next_time`= 0",
    [member_sid]
  );
  res.json({ success: true, msg: "set all next time" });
});

// // 用params拿資料
// // http://localhost:4000/test/getmealbyparams/1
// router.get("/getmealbyparams/:sid?", async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.params.sid,
//   ]);
//   res.json(result);
// });

// // 用post提供資料庫訊息
// // http://localhost:4000/test/postmealsid (用POSTMAN測試 或 用Live server打開根目錄的testpost.html)
// router.post("/postmealsid", upload.none(), async (req, res) => {
//   const [result] = await db.query("select * from `meal` where `sid` = ?", [
//     req.body.sid,
//   ]);
//   res.json(result);
// });

// router.use((req, res) => {
//   res.type("text/plain");
//   res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
// });

module.exports = router;
