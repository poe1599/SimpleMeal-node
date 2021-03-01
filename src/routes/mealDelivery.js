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

// 增加配送商品進購物車
router.get("/getmealtodelivery", async (req, res) => {
  const member_sid = req.session.admin.id;

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
    res.json({ result, msg: `增加 ${mealData[0].product_name} 到配送清單` });
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
    res.json({
      result,
      cartDeliveryData,
      msg: `配送清單中的 ${mealData[0].product_name} 現在有 ${cartDeliveryData[0].quantity + 1
        } 份`,
    });
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
  const member_sid = req.session.admin.id;

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

  const [
    memberInfoArray,
  ] = await db.query("select * from `membercenter` where `id` = ?", [
    member_sid,
  ]);

  const memberInfoObj = { ...memberInfoArray[0] };
  // console.log(memberInfoObj);

  res.json({ thisTime, nextTime, simpleMealCoupon, member_sid, memberInfoObj });
});

// 改變數量
// http://localhost:4000/mealdelivery/setmealquantity?sid=${sid}&quantity=${quantity}
router.get("/setmealquantity", async (req, res) => {
  const member_sid = req.session.admin.id;

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
  const member_sid = req.session.admin.id;
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
  const member_sid = req.session.admin.id;
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
  const member_sid = req.session.admin.id;
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
      meal_sid += v.meal_sid;
    } else {
      meal_sid += `,${v.meal_sid}`;
    }

    if (meal_name == "") {
      meal_name += v.meal_name;
    } else {
      meal_name += `,${v.meal_name}`;
    }

    if (quantity == "") {
      quantity += v.quantity;
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

  //寫進度到成就系統 餐點配送
  //先確認餐點種類(meal_sid,分隔 陣列處理) 1美式 2中式 3法式 4義式

  //分隔逗號 取得每筆的餐點分類 以及數量 轉入成就系統
  const mealArray = meal_sid.split(',')//餐點sid
  const quantityArray = quantity.split(',')//餐點數量

  for (let i = 0; i < mealArray.length; i++) {
    const [categoryArray] = await db.query('select category_id from meal where sid  = ? ',[mealArray[i]])//取得餐點種類
    switch(parseInt(categoryArray[0].category_id)){
      case 1://美式餐點
        await db.query('INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,6 ,? )',[member_sid,quantityArray[i]])
        break;
      case 2://中式餐點
      await db.query('INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,7 ,? )',[member_sid,quantityArray[i]])
        break;
      case 3://法式餐點
      await db.query('INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,9 ,? )',[member_sid,quantityArray[i]])
        break;
      case 4://義式餐點
      await db.query('INSERT INTO `event_record`(`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES (? ,now() ,8 ,? )',[member_sid,quantityArray[i]])
        
    }
    
  }

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
