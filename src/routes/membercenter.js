const express = require("express");

const moment = require("moment-timezone");

const upload = require(__dirname + "/../modules/upload-imgs");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

// 會員註冊
// http://localhost:4000/membercenter/registered //upload上傳檔關閉 none
router.post("/registered",upload.none(),async (req, res) => {
  
  const [result] = await db.query("INSERT INTO `membercenter` (`email`, `password`, `password1`, `name`, `mobile`,`addr`) VALUES (? ,SHA1(?) ,? ,? ,? ,? )", [
    req.body.email,
    req.body.password,
    req.body.password1,
    req.body.name,
    req.body.mobile,
    req.body.addr
  ]);
  res.json(result);
});
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

//   購買餐卷歷史紀錄
// http://localhost:4000/membercenter/cart_simplemealcoupon
router.get("/cart_simplemealcoupon", async (req, res) => {
  
  if(req.query.start === 'null' && req.query.end === 'null'){
     const [result,] = await db.query("SELECT * FROM `cart_simplemealcoupon` ORDER BY `check_date` ASC");
    
    res.json(result);
    return;
  }
    const [result] = await db.query("SELECT * FROM `cart_simplemealcoupon` WHERE `check_date` >= ?  AND `check_date` <= DATE_ADD(?, INTERVAL 1 DAY) ORDER BY `cart_simplemealcoupon`.`check_date` ASC",[req.query.start, req.query.end]);

  res.json(result);
});
//   餐卷歷史紀錄
// http://localhost:4000/membercenter/history_mealdelivery
router.get("/history_mealdelivery", async (req, res) => {
  

  if(req.query.start === 'null' && req.query.end === 'null'){
    const [result,] = await db.query("SELECT * FROM `history_mealdelivery` ORDER BY `history_mealdelivery`.`check_date` ASC");
    res.json(result);
   return;
 }

 const[result,] =await db.query("SELECT * FROM `history_mealdelivery` WHERE `check_date` >= ?  AND `check_date` <= DATE_ADD(?, INTERVAL 1 DAY) ORDER BY `history_mealdelivery`.`check_date` ASC ",[req.query.start, req.query.end])
 res.json(result); 
});
// 驚喜廚房紀錄
// http://localhost:4000/membercenter/surprisekitchen_order
router.get("/surprisekitchen_order", async (req, res) => {

  if(req.query.start === 'null' && req.query.end === 'null'){
    const [result,] = await db.query("SELECT * FROM `surprisekitchen_order`");
    res.json(result);
   return;
 }
 const[result,] =await db.query("SELECT * FROM `surprisekitchen_order` WHERE `check_date` >= ?  AND `check_date` <= DATE_ADD(?, INTERVAL 1 DAY) ",[req.query.start, req.query.end])
 res.json(result);
});



// 會員資料引入
// http://localhost:4000/membercenter/info
router.get("/info", async (req, res) => {
  const member_sid = req.session.admin.id;
    const [result] = await db.query("SELECT * FROM `membercenter` WHERE id= ?",[member_sid]);

    result.map((v) => {
      v.birthday = moment(v.birthday).format(
        "YYYY-MM-DD"
      );
     
    })
    res.json(result);
   return;
});


// 會員基本個人資料修改
// http://localhost:4000/membercenter/information
router.post("/information",upload.none(), async (req, res) => {
  const member_sid = req.session.admin.id;
  const [result,] = await db.query("UPDATE `membercenter` SET name= ?, nickname= ?, birthday= ?, mobile= ? WHERE `membercenter`.`id` = ?",[
    req.body.name,
    req.body.nickname,
    req.body.birthday,
    req.body.mobile,
    member_sid
  ]);
  
  res.json(result);
 return;
});
// 會員基本個人地址修改
// http://localhost:4000/membercenter/addr
router.post("/addr",upload.none(), async (req, res) => {
  const member_sid = req.session.admin.id;
  const [result,] = await db.query("UPDATE `membercenter` SET addr = ? WHERE `membercenter`.`id` = ?; ",[
    req.body.addr,member_sid 
  ]);
  res.json(result);
 return;
});

// 會員基本個人信用卡修改
// http://localhost:4000/membercenter/creditcard
router.post("/creditcard",upload.none(), async (req, res) => {
  const member_sid = req.session.admin.id;
  const [result,] = await db.query("UPDATE `membercenter` SET `credit＿card` = ? WHERE `membercenter`.`id` = ?; ",
  [req.body.credit＿card,member_sid]);
  res.json(result);
 return;
});

// 會員個人密碼修改
// http://localhost:4000/membercenter/password
router.post("/password",upload.none(), async (req, res) => {
  const member_sid = req.session.admin.id;
  const [result,] = await db.query("UPDATE `membercenter` SET `password` = SHA1(?),`password1` = ? WHERE `membercenter`.`id` = ?;",[
    req.body.password,
    req.body.password1,
    member_sid
  ]);
  res.json(result);
 return;
});



//UPDATE `membercenter` SET `credit＿card` = '' WHERE `membercenter`.`id` = 1; 會員信用卡修改
//UPDATE `membercenter` SET `password` = SHA1('') WHERE `membercenter`.`id` = 1;會員密碼修改
// router.post("/try-upload", upload.single("pic"), async (req, res) => {
//   console.log(req.body.name);
//   const [
//     result,
//   ] = await db.query(
//     "INSERT INTO `share_recipe`(`name`,`creator`, `cooktime`, `introduction`, `step1`, `step2`, `step3`, `step4`, `step5`,`pic`) VALUES (?,?,?,?,?,?,?,?,?,?)",
//     [
//       "http://localhost:4000/img/" + req.file.filename,
//     ]
//   );
//   res.json({
//     file: req.file,
//     // 其他欄位放這裡
//     body: req.body,
//   });
// });
router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面 你還是多看幾次吧");
});

module.exports = router;
