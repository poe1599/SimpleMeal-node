const express = require("express");

const moment = require("moment-timezone");
const router = express.Router();
const db = require(__dirname + "/../modules/db_connect2");

router.use((req, res, next) => {
  //     if (!req.session.admin) {
  //     return res.redirect('/');
  // }

  res.locals.baseUrl = req.baseUrl;
  res.locals.url = req.url;
  next();
});

router.get("/get", async (req, res) => {
  const [result] = await db.query("SELECT * FROM `test`");
  res.json(result);
});

router.use((req, res) => {
  res.type("text/plain");
  res.status(404).send("有問題喔 找不到頁面6666");
});

module.exports = router;