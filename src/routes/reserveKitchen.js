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
// http://localhost:4000/reservekitchen/getorder
router.get("/getorder", async (req, res) => {
  const member_number = "20210001";
  const [
    row,
  ] = await db.query(
    "SELECT * FROM `surprisekitchen_order` WHERE `member_number` = ? and `check_date` is null ",
    [member_number]
  );
  // console.log(row);
  if (row.length !== 1) {
    res.json([{ sid: 0 }]);
  } else {
    // 處理日期格式
    row[0].reservation_date = moment(row[0].reservation_date).format(
      "YYYY-MM-DD"
    );

    res.json(row);
  }
});

// 用query string拿資料
// http://localhost:4000/test/getmealbyquery?sid=1
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
