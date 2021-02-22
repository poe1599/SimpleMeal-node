const express = require("express");

const moment = require("moment-timezone");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");
// multer處理上傳檔案
const multer = require("multer");
// 自訂上傳js
const upload = require(__dirname + "/../modules/upload-imgs");
// const upload = require(__dirname + "/modules/upload-imgs");

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

// 顯示個人食譜
// http://localhost:4000/sharerecipe/getusermeal
router.get("/getusermeal", async (req, res) => {
  const [result] = await db.query(
    "SELECT `creator`,`id`,`pic`,`name` FROM `share_recipe` WHERE `creator`=1 ORDER BY `share_recipe`.`id` DESC"
  );
  res.json(result);
});



// 上傳檔案
// localhost:4000/sharerecipe/try-upload
router.post("/try-upload", upload.single("pic"), async (req, res) => {
  console.log(req.body.name);
  const [
    result,
  ] = await db.query(
    "INSERT INTO `share_recipe`(`name`,`creator`, `cooktime`, `introduction`, `step1`, `step2`, `step3`, `step4`, `step5`,`pic`) VALUES (?,?,?,?,?,?,?,?,?,?)",
    [
      req.body.name,
      1,
      req.body.cooktime,
      req.body.introduction,
      req.body.step1,
      req.body.step2,
      req.body.step3,
      req.body.step4,
      req.body.step5,
      "http://localhost:4000/img/" + req.file.filename,
    ]
  );
  res.json({
    file: req.file,
    // 其他欄位放這裡
    body: req.body,
  });
});

// 刪除食譜
// http://localhost:4000/sharerecipe/:id
router.delete("/:id", async (req, res) => {
  const [
    result,
  ] = await db.query(
    "DELETE FROM `share_recipe` WHERE `share_recipe`.`id` = ?",
    [req.params.id]
  );
  res.json({
    success: result.affectedRows === 1,
  });
});


// 顯示食譜內容頁
// http://localhost:4000/sharerecipe/21

router.get("/:id", async (req, res) => {
  const [
    result,
  ] = await db.query(
    "SELECT * FROM `share_recipe` WHERE `share_recipe`.`id`=?",
    [req.params.id]
  );
  res.json(result);
});

// 修改食譜前的顯示食譜
// http://localhost:4000/sharerecipe/edit/21

router.get("/edit/:id", async (req, res) => {
  const [
    result,
  ] = await db.query(
    "SELECT * FROM `share_recipe` WHERE `share_recipe`.`id`=?",
    [req.params.id]
  );
  res.json(result);
});


// 修改食譜
// http://localhost:4000/sharerecipe/edit/31
router.put("/edit/:id", upload.single("pic"), async (req, res) => {
  console.log(req.params.id);
  const [
    result,
  ] = await db.query(
    "UPDATE `share_recipe` SET `name`=?,`cooktime`=?,`introduction`=?,`pic`=?,`step1`=?,`step2`=?,`step3`=?,`step4`=?,`step5`=? WHERE `id`=?",
    [
      req.body.name,
      req.body.cooktime,
      req.body.introduction,
      "http://localhost:4000/img/" + req.file.filename,
      req.body.step1,
      req.body.step2,
      req.body.step3,
      req.body.step4,
      req.body.step5,
      req.params.id,
    ]
  );
  res.json({
    file: req.file,
    // 其他欄位放這裡
    body: req.body,
  });
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
