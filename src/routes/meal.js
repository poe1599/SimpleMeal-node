const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

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




router.get("/getmealtodelivery",  async (req, res) => {
  const [mealData] = await db.query("select * from `meal` where `sid` = ?", [
    req.query.sid,
  ]);
  const [recipeData] = await db.query(
    "select * from `recipe` where `sid` = ?",
    [req.query.sid]
  );
// const a  = `(${req.query.ingredient_id})`
console.log(req.query.ingredient_id)
  const [
    ingredientsData,
  ] = await db.query(`SELECT * FROM ingredients WHERE sid in (${req.query.ingredient_id})`);

  res.json({ mealData, recipeData, ingredientsData });
});

// router.get("/selectMealtest",  async (req, res) => {
//   const a=req.query.ingredient_id
//   const [result] = await db.query("SELECT * FROM `ingredients` WHERE `sid` IN (?)", [
//     a,
//   ]);
//   console.log( a)
//   res.json(result[0]);
// });

module.exports = router;
