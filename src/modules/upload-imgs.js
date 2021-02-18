// 檔案上傳
const multer = require("multer");
// uuid . v4亂數命名 . v4改名為uuidv4
const { v4: uuidv4 } = require("uuid");

// 副檔名對應 . 限制附檔名
const extMap = {
  "image/jpeg": ".jpg",
  "image/png": ".png",
  "image/gif": ".gif",
};


const storage = multer.diskStorage({
    
  // 存放位置 . req路由來的 . file上傳的 . cb處理方式
    destination: function (req, file, cb) {
        // null : node有錯誤先行 . 第一個參數放錯誤 . 沒錯誤就給空值 . 如果想寫錯誤就放在null這位置
    cb(null, __dirname + "/../../public/img");
  },
  // 檔名
    filename: function (req, file, cb) {
    //   extMap[file.mimetype: 副檔名
    cb(null, uuidv4() + extMap[file.mimetype]);
  },
});

// 判斷是否符合定義副檔名
const fileFilter = function (req, file, cb) {
    // 若符合就換拿到字串再用!!轉成布林
    cb(null, !!extMap[file.mimetype]);
};

module.exports = multer({ storage, fileFilter });
