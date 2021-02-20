// 透過模組導入環境設定檔.env
require("dotenv").config();

const express = require("express");
// session處理
const session = require("express-session");
// 使用express-mysql-session提供的方法
// https://www.npmjs.com/package/express-mysql-session
const MysqlStore = require("express-mysql-session")(session);
// cors模組, 處理不同server的請求 https://www.npmjs.com/package/cors
const cors = require("cors");

// 擷取內容
// https://www.npmjs.com/package/axios
const axios = require("axios");

// 類似JQ
const cheerio = require("cheerio");

// jsonwebtoken
const jwt = require("jsonwebtoken");

// 引用moment-timezone來處理時間格式
const moment = require("moment-timezone");

// multer處理上傳檔案
const multer = require("multer");

// 自訂上傳js
const upload = require(__dirname + "/modules/upload-imgs");

// 導入資料庫連線的js檔
const db = require(__dirname + "/modules/db_connect2");
// 使用SQL的資料庫做sessionStore
const sessionStore = new MysqlStore({}, db);

const app = express();

// 註冊樣版引擎, 記得在根目錄建立views資料夾, 除了安裝npm ejs套件, vscode也要裝EJS language support
app.set("view engine", "ejs");

// 將public資料夾的內容當作根目錄一樣讓外部讀取, 通常裡面放html, css, js, img等不需要再經過資料庫處理的靜態資料
app.use(express.static("public"));

// 將 body-parser 設定成頂層 middleware，放在所有路由之前。
// 其包含兩種解析功能： urlencoded 和 json 。
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(
  session({
    // secret: "加密用字串",
    secret: "idontwannatellyou",
    // saveUninitialized: 初始化儲存,
    saveUninitialized: false,
    resave: false,
    // 給SQL存session用, 超過設定時間也會自己清除, 但因為要連SQL所以效能略差, 但好處是server重啟不會消失
    store: sessionStore,
    cookie: {
      // maxAge: 1000 為1秒,
      maxAge: 18000000,
    },
  })
);

// 白名單的做法
// const whitelist = ['http://localhost:8080', undefined, 'http://localhost:3000'];
// const corsOptions = {
//   credentials: true,
//   origin: function (origin, cb) {
//     // console.log("origin:", origin);
//     if (whitelist.indexOf(origin) !== -1) {
//       cb(null, true);
//     } else {
//       cb(null, false);
//     }
//   },
// };

// 全部允許
const corsOptions = {
  credentials: true,
  origin: function (origin, cb) {
    // console.log("origin:", origin);
    cb(null, true);
  },
};

// 沒設定直接允許不同server端的請求, 如沒有這段則不同server無法互通資料
app.use(cors(corsOptions));

// middle well
app.use((req, res, next) => {
  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  // 把req.session存到res.locals.sess 方便判斷有沒有登入
  res.locals.sess = req.session;
  next();
});

// 測試模組
app.use("/test", require(__dirname + "/routes/test"));

//會員中心
app.use("/membercenter", require(__dirname + "/routes/membercenter"));
// 共享食譜
app.use("/sharerecipe", require(__dirname + "/routes/sharerecipe"));

// 購物車餐券模組
app.use("/simplemealcoupon", require(__dirname + "/routes/simpleMealCoupon"));

// 餐點配送模組
app.use("/mealdelivery", require(__dirname + "/routes/mealDelivery"));

// 預約廚房模組
app.use("/reservekitchen", require(__dirname + "/routes/reserveKitchen"));

// 成就模組
app.use("/milestone", require(__dirname + "/routes/milestone"));

// 獎勵模組
app.use("/reward", require(__dirname + "/routes/reward"));

//餐點模組
app.use("/meal", require(__dirname + "/routes/meal"));

//預約廚房場次模組
app.use("/reservationTimes", require(__dirname + "/routes/reservationTimes"));

//預約廚房模組
app.use(
  "/surprisekitchenOrder",
  require(__dirname + "/routes/surprisekitchenOrder")
);

//廚房評論模組
app.use(
  "/reservationComment",
  require(__dirname + "/routes/reservationComment")
);


app.get("/getdata", async (req, res) => {
  const [result] = await db.query("SELECT * FROM `test`");
  res.json(result);
});

// 接收登入
app.post("/login", upload.none(), async (req, res) => {
  // res.json(req.body);
  const [
    rows,
  ] = await db.query(
    "SELECT * FROM `membercenter` WHERE `email` = ? AND `password` =  SHA1(?)",
    [req.body.email, req.body.password]
  );

  if (rows.length === 1) {
    req.session.admin = rows[0];
    res.json({
      success: true,
      session: rows[0],
    });
  } else {
    res.json({
      success: false,
      body: req.body,
    });
  }
});

app.get("/logout", async (req, res) => {
  delete req.session.admin;
  res.json({ msg: "後端刪除登入SESSION" });
});

// 首頁
app.get("/", (req, res) => {
  res.render("index", { shortText: "這裡是後端伺服器, 你來錯地方了" });
});

// 這個要放最後, 不然會先被讀到
app.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面");
});

// 拿到.env設定的的PORT, 如果沒有那就預設4000
const port = process.env.PORT || 4000;
app.listen(port, () => {
  console.log(`port: ${port}`, new Date());
});
