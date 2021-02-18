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

// 增加配送商品進購物車
router.get("/getmealtodelivery", async (req, res) => {
  const member_sid = "1";

  // 用sid去meal資料庫撈餐點資料
  const [mealData] = await db.query("SELECT * FROM `meal` WHERE `sid`= ?", [
    req.query.sid,
  ]);

  // 檢查購物車是否該會員已經有該餐點
  const [
    cartDeliveryData,
  ] = await db.query(
    "SELECT * FROM `cart_mealdelivery` WHERE `member_sid`=? and `meal_sid`= ?",
    [member_sid, req.query.sid]
  );

  // 如果沒有, 則寫入一筆
  if (cartDeliveryData.length === 0) {
    const [
      result,
    ] = await db.query(
      "INSERT INTO `cart_mealdelivery`(`sid`, `member_sid`, `meal_sid`, `product_id`, `meal_name`, `description`, `quantity`, `next_time`) VALUES (null, ?, ?, ?, ?, ?, 1, 0)",
      [
        member_sid,
        mealData[0].sid,
        mealData[0].product_id,
        mealData[0].product_name,
        mealData[0].introduction,
      ]
    );
    res.json({ result, msg: "增加一筆新的" });
    return;
  }

  // 如果有該餐點且數量少於10份
  if (cartDeliveryData[0].quantity < 10) {
    const [
      result,
    ] = await db.query(
      "UPDATE `cart_mealdelivery` SET `quantity`=`quantity`+1 WHERE `member_sid`= ? and `meal_sid`= ?",
      [member_sid, mealData[0].sid]
    );
    res.json({ result, cartDeliveryData, msg: `現在數量加1` });
    return;
  }

  //  如果有該餐點且數量等於10份
  if (cartDeliveryData[0].quantity === 10) {
    res.json({ msg: "已經有這項商品, 且滿10筆" });
    return;
  }
});

// 拿該會員的配送資料
// http://localhost:4000/mealdelivery/getdeliverycart
router.get("/getdeliverycart", async (req, res) => {
  const member_sid = "1";

  // 這次
  const [
    thisTime,
  ] = await db.query(
    "select * from `cart_mealdelivery` where `member_sid` = ? and `next_time` = 0",
    [member_sid]
  );

  // 下次
  const [
    nextTime,
  ] = await db.query(
    "select * from `cart_mealdelivery` where `member_sid` = ? and `next_time` = 1",
    [member_sid]
  );

  // 會員現有餐券數
  const [
    myCoupon,
  ] = await db.query(
    "select `simplemeal_coupon` from `membercenter` where `id` = ?",
    [member_sid]
  );

  // 計算這次消耗餐券
  let cost = 0;
  thisTime.forEach((el) => {
    cost += el.quantity;
  });

  // 提供總計
  const simpleMealCoupon = {
    now: myCoupon[0].simplemeal_coupon,
    cost: cost,
    remain: myCoupon[0].simplemeal_coupon - cost,
  };

  res.json({ thisTime, nextTime, simpleMealCoupon });
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

// 刪除勾選
router.get("/deletecheckbox", async (req, res) => {
  const sidArray = req.query.str.split(",");
  sidArray.map(async (v, i) => {
    if (v === "0") return;
    const [
      result,
    ] = await db.query("delete from `cart_mealdelivery` where `sid`= ? ", [v]);
  });
  res.json({ success: true, msg: "delete", sidArray: sidArray });
});

// 勾選的改這次
router.get("/tothistime", async (req, res) => {
  const member_sid = "1";
  const sidArray = req.query.str.split(",");
  sidArray.map(async (v, i) => {
    const [
      result,
    ] = await db.query(
      "UPDATE `cart_mealdelivery` SET `next_time`= 0 WHERE `member_sid`= ? and `sid`= ?",
      [member_sid, v]
    );
  });
  res.json({ success: true, msg: "set this time", sidArray: sidArray });
});

// 勾選的改下次
router.get("/tonexttime", async (req, res) => {
  const member_sid = "1";
  const sidArray = req.query.str.split(",");
  sidArray.map(async (v, i) => {
    const [
      result,
    ] = await db.query(
      "UPDATE `cart_mealdelivery` SET `next_time`= 1 WHERE `member_sid`= ? and `sid`= ?",
      [member_sid, v]
    );
  });
  res.json({ success: true, msg: "set next time", sidArray: sidArray });
});

// 送出訂單
router.post("/ordercheck", upload.none(), async (req, res) => {
  const member_sid = "1";
  const order_sid = (+new Date()).toString().slice(4);

  // 拿到有哪些這次要送的
  const [
    row,
  ] = await db.query(
    "select * from `cart_mealdelivery` where `member_sid`= ? and `next_time`= 0",
    [member_sid]
  );

  // 刪掉配送購物車
  const [
    deleteRow,
  ] = await db.query(
    "delete from `cart_mealdelivery` where `member_sid`= ? and `next_time`= 0",
    [member_sid]
  );

  let meal_sid = "";
  let meal_name = "";
  let quantity = "";
  let costCoupon = 0;
  row.forEach((v, i) => {
    if (meal_sid == "") {
      meal_sid = v.meal_sid;
    } else {
      meal_sid += `,${v.meal_sid}`;
    }

    if (meal_name == "") {
      meal_name = v.meal_name;
    } else {
      meal_name += `,${v.meal_name}`;
    }

    if (quantity == "") {
      quantity = v.quantity;
    } else {
      quantity += `,${v.quantity}`;
    }

    costCoupon += v.quantity;
  });

  // 新的歷史紀錄
  const [
    newOrder,
  ] = await db.query(
    "INSERT INTO `history_mealdelivery`(`sid`, `member_sid`, `meal_sid`, `meal_name`, `quantity`, `member_name`, `mobile`, `address`, `delivery_date`, `delivery_time`, `check_date`) VALUES (? , ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())",
    [
      order_sid,
      member_sid,
      meal_sid,
      meal_name,
      quantity,
      req.body.name,
      req.body.mobile,
      req.body.address,
      req.body.date,
      req.body.time,
    ]
  );

  // 會員中心減去消耗的餐券
  const [
    newMemberCenter,
  ] = await db.query(
    "UPDATE `membercenter` SET `simplemeal_coupon`=`simplemeal_coupon` - ? where `id`= ?",
    [costCoupon, member_sid]
  );

  const result = { order_sid: order_sid };
  res.json(result);
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
