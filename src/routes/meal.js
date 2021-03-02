const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

// router.use((req, res, next) => {
//   // 沒登入? 出去! 現在!
//   if (!req.session.admin) {
//     return res.redirect("/");
//   }

//   res.locals.baseUrl = req.baseUrl;
//   res.locals.url = req.url;
//   next();
// });

router.get("/all", async (req, res) => {
  const [result] = await db.query("SELECT * FROM `meal`");
  res.json(result);
});

router.get("/typeA", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `meal` WHERE `category_id` LIKE '1' ORDER BY `sid`"
  );
  res.json(result);
});

router.get("/typeB", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `meal` WHERE `category_id` LIKE '2' ORDER BY `sid`"
  );
  res.json(result);
});

router.get("/typeC", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `meal` WHERE `category_id` LIKE '3' ORDER BY `sid`"
  );
  res.json(result);
});

router.get("/typeD", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `meal` WHERE `category_id` LIKE '4' ORDER BY `sid`"
  );
  res.json(result);
});

router.get("/typeE", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `meal` WHERE `vegetarian_food` LIKE '1' ORDER BY `sid`"
  );
  res.json(result);
});

router.get("/selectMeal", upload.none(), async (req, res) => {
  const [result] = await db.query("select * from `meal` where `sid` = ?", [
    req.query.sid,
  ]);
  res.json(result[0]);
});

router.get("/getmealtodelivery", async (req, res) => {
  const [mealData] = await db.query("select * from `meal` where `sid` = ?", [
    req.query.sid,
  ]);
  const [recipeData] = await db.query(
    "select * from `recipe` where `sid` = ?",
    [req.query.sid]
  );
  // const a  = `(${req.query.ingredient_id})`
  console.log(req.query.ingredient_id);
  const [ingredientsData] = await db.query(
    `SELECT * FROM ingredients WHERE sid in (${req.query.ingredient_id})`
  );

  res.json({ mealData, recipeData, ingredientsData });
});

router.get("/getlove", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }

  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);
  const thisMealSid = req.query.sid.toString();
  if (memberData[0].love === null) {
    const [
      result,
    ] = await db.query("UPDATE `membercenter` SET `love`=? where `id`= ?", [
      thisMealSid,
      member_sid,
    ]);
    res.json({ result, msg: "加入到我的專屬菜單!" });
    return;
  }
  const thisMemberLoveId = memberData[0].love.split(",");
  const inLove = thisMemberLoveId.includes(thisMealSid);
  if (inLove !== true) {
    const [
      result,
    ] = await db.query("UPDATE `membercenter` SET `love`=? where `id`= ?", [
      memberData[0].love + "," + thisMealSid,
      member_sid,
    ]);
    res.json({ result, msg: "加入到我的專屬菜單!" });
    return;
  }
  if (inLove === true) {
    const [
      result,
    ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
      member_sid,
    ]);
    res.json({ result, msg: "之前已加過專屬菜單摟!" });
    return;
  }
  // console.log( member_sid);
  // console.log(inLove);
  // console.log({ memberData, member_sid, });
});

router.get("/loveall", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);
  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love})`
  );
  res.json(result);
});

router.get("/loveTypeA", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);

  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love}) AND vegetarian_food =1`
  );

  res.json(result);
});

router.get("/loveTypeB", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);

  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love}) AND category_id =1`
  );

  res.json(result);
});

router.get("/loveTypeC", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);

  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love}) AND category_id =2`
  );

  res.json(result);
});

router.get("/loveTypeD", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);

  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love}) AND category_id =3`
  );

  res.json(result);
});

router.get("/loveTypeE", async (req, res) => {
  // 沒登入? 出去! 現在!
  if (!req.session.admin) {
    return res.redirect("/");
  }
  
  const member_sid = req.session.admin.id;
  const [
    memberData,
  ] = await db.query("SELECT * FROM `membercenter` WHERE `id`= ?", [
    member_sid,
  ]);

  const [result] = await db.query(
    `SELECT * FROM meal WHERE sid in (${memberData[0].love}) AND category_id =4`
  );

  res.json(result);
});

module.exports = router;
