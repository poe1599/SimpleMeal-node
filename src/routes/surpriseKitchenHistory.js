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

// 送廚房評論
// http://localhost:4000/surpriseKitchenHistory/getoverlist
router.post("/getoverlist",upload.none(), async (req, res) => {
  const member_number = req.session.admin.member_number;

    const [result,
      ] = await db.query(
        "INSERT INTO `surprise_comment`(`member_number`, `nickname`, `used_date`, `comment`, `builded_date`) VALUES (?, ?, ?, ?, NOW())",
        [
          member_number,
          req.body.nickname,
          req.body.used_date,
          req.body.comment,
        ]
      );
     res.json(result);
    });

//單純拿驚喜廚房訂單全部
// http://localhost:4000/surpriseKitchenHistory/getReservationInfo
// router.get("/getReservationInfo", async (req, res) => {
//   const [result] = await db.query("SELECT * FROM `surprisekitchen_order` WHERE 1");
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
