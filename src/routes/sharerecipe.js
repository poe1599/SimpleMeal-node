const express = require("express");

const moment = require("moment-timezone");
const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");
// const User = require("../../domain/sharerecipe");

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

// 顯示全部食譜
// http://localhost:4000/sharerecipe/getallmeal
router.get("/getallmeal", async (req, res) => {
  const [result] = await db.query(
    "SELECT * FROM `share_recipe` ORDER BY `share_recipe`.`id` DESC"
  );
  res.json(result);
});


// 新增食譜
// http://localhost:4000/sharerecipe/add
router.post("/add", upload.none(), async (req, res) => {
  const [
    result,
  ] = await db.query(
    "INSERT INTO `share_recipe`(`name`, `cooktime`, `introduction`, `step1`, `step2`, `step3`, `step4`, `step5`,`pic`) VALUES (?,?,?,?,?,?,?,?,?)",
    [
      req.body.name,
      req.body.cooktime,
      req.body.introduction,
      req.body.step1,
      req.body.step2,
      req.body.step3,
      req.body.step4,
      req.body.step5,
      req.body.newpic,
    ]
  );
  // console.log(result);
  // 回傳
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
// router.post("/postrecipe", upload.none(), async (req, res) => {
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
