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
      return res.redirect('/');
  }
  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  next();
});

// 拿訂單資料
// http://localhost:4000/surpriseKitchenHistory/getoverlist
router.get("/getoverlist", async (req, res) => {
    const member_number = req.session.admin.member_number;
    const [
      row,
    ] = await db.query(
      "SELECT * FROM `surprisekitchen_order` WHERE `member_number` = ? and `check_date` is null ",
      [member_number]
    );
    // console.log(row);
  
    // 當資料庫沒有預約資料時
    if (row.length === 0) {
      res.json([{ sid: 0 }]);
      return;
    }
  
    // 當資料庫有1筆預約資料時
    if (row.length === 1) {
      // 處理日期格式
      row[0].reservation_date = moment(row[0].reservation_date).format(
        "YYYY-MM-DD"
      );
      res.json(row);
      return;
    }
  
    // 當資料庫有多筆預約資料時 (不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約)
    if (row.length >= 1) {
      res.json([
        {
          sid: 0,
          msg: "不應該出現此情況, 由當初寫入訂單時控制1個會員只會有1筆未結帳預約",
        },
      ]);
      return;
    }
  });

//單純拿全部
// http://localhost:4000/surprisekitchenOrder/getReservationInfo
// router.get("/getReservationInfo", async (req, res) => {
//   const [result] = await db.query("SELECT `reservation_date`, `reservation_time`FROM `surprisekitchen_order` WHERE 1");
//   res.json(result);
// });

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
