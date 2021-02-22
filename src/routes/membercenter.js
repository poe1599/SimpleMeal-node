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

//   餐卷歷史紀錄
// http://localhost:4000/membercenter/cart_simplemealcoupon
router.get("/cart_simplemealcoupon", async (req, res) => {
  
  if(req.query.start === 'null' && req.query.end === 'null'){
     const [result,] = await db.query("SELECT * FROM `cart_simplemealcoupon` ORDER BY `check_date` ASC");
    
    res.json(result);
    return;
  }
    const [result] = await db.query("SELECT * FROM `cart_simplemealcoupon` WHERE `check_date` >= ?  AND `check_date` <= ? ORDER BY `cart_simplemealcoupon`.`check_date` ASC",[req.query.start, req.query.end]);

  
 


  
  // const [result] = await db.query("SELECT * FROM `cart_simplemealcoupon` ORDER BY `order_sid` ASC");
  res.json(result);
});


  // 驚喜廚房歷史紀錄
// http://localhost:4000/membercenter/cart_simplemealcoupon
router.get("/cart_simplemealcoupon", async (req, res) => {
  // const [result] = await db.query("SELECT * FROM `cart_simplemealcoupon` WHERE `check_date` > ?  AND `check_date`<  ?" ,[req.query.start, req.query.end]);
   // SELECT * FROM `cart_simplemealcoupon` WHERE `check_date` <  '2021-02-23'  AND `check_date` > '2021-01-15'
  const [result] = await db.query("SELECT * FROM `cart_mealdelivery`");
  res.json(result);
  

});
  // 我的餐點歷史紀錄
// http://localhost:4000/membercenter/cart_mealdelivery
router.get("/cart_mealdelivery", async (req, res) => {
 
  const [result] = await db.query("SELECT * FROM `cart_mealdelivery`");
  res.json(result);
});
  // 會員中心資料
// http://localhost:4000/membercenter/membercenter
router.get("/membercenter", async (req, res) => {
  const [result] = await db.query("SELECT * FROM `membercenter`");
  res.json(result);
});

  // 會員中心資料新增
// http://localhost:4000/membercenter/cart_simplemealcoupon
router.get("/membercenter", async (req, res) => {
  const [result] = await db.query("SELECT * FROM `membercenter`");
  res.json(result);
});


router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
