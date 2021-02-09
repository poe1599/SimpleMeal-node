-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2021-02-09 05:15:16
-- 伺服器版本： 10.4.16-MariaDB
-- PHP 版本： 7.3.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `simplemeal`
--

-- --------------------------------------------------------

--
-- 資料表結構 `cart_mealdelivery`
--

CREATE TABLE `cart_mealdelivery` (
  `sid` int(11) NOT NULL,
  `member_sid` int(11) NOT NULL,
  `meal_sid` int(11) NOT NULL,
  `meal_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `member_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_time` time DEFAULT NULL,
  `next_time` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `cart_mealdelivery`
--

INSERT INTO `cart_mealdelivery` (`sid`, `member_sid`, `meal_sid`, `meal_name`, `description`, `quantity`, `member_name`, `mobile`, `address`, `delivery_date`, `delivery_time`, `next_time`) VALUES
(1, 1, 1, '紅薯蛋糕', '這個鮮活的小數字在切碎的小寶石上鋪上堅固耐用的現成的地瓜餅，上面舖有自製的藍紋奶酪醬，並飾以鬆脆的烤山核桃。', 1, '王曉明', '0945456321', '台北市大安區復興南路一段390號2樓', '2021-02-02', '10:50:17', 0),
(2, 1, 4, '中國檸檬雞和嫩皮', '黏膩，甜美和酥脆的完美水平，這是一款永不失敗的複古經典。您需要在炸雞上塗上蜂蜜檸檬醬，再搭配米飯和Tenderstem西蘭花。', 3, '王曉明', '0945456321', '台北市大安區復興南路一段390號2樓', NULL, NULL, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `cart_simplemealcoupon`
--

CREATE TABLE `cart_simplemealcoupon` (
  `order_sid` int(11) NOT NULL,
  `member_sid` int(11) NOT NULL,
  `combination_sid` int(11) NOT NULL,
  `combination_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `total_coupon_num` int(11) NOT NULL,
  `total_price` int(11) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `check_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `cart_simplemealcoupon`
--

INSERT INTO `cart_simplemealcoupon` (`order_sid`, `member_sid`, `combination_sid`, `combination_name`, `description`, `quantity`, `total_coupon_num`, `total_price`, `payment_method`, `check_date`) VALUES
(509572507, 1, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 1, 25, 7000, '信用卡線上刷卡一次付清', '2021-02-02 13:01:58'),
(509572508, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 1, 12, 1700, '銀聯卡', '2021-02-03 13:06:11'),
(509572509, 1, 3, '經濟實惠組', '(包含5張餐卷, 加贈1張免費餐券)', 1, 6, 850, '信用卡線上刷卡一次付清', '2021-02-04 13:07:18'),
(768452336, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 3, 36, 5100, 'LINE PAY', '2021-02-08 15:14:12'),
(773683259, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 3, 36, 5000, '信用卡線上刷卡一次付清', '2021-02-08 16:41:23'),
(773788123, 1, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 4, 100, 14000, 'LINE PAY', '2021-02-08 16:43:08'),
(783950920, 1, 3, '經濟實惠組', '(包含5張餐卷, 加贈1張免費餐券)', 1, 6, 750, '銀聯卡', '2021-02-08 19:32:30'),
(836190369, 1, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 3, 75, 10400, 'LINE PAY', '2021-02-09 10:03:10');

-- --------------------------------------------------------

--
-- 資料表結構 `categories_1`
--

CREATE TABLE `categories_1` (
  `sid` int(11) NOT NULL,
  `category1_name` varchar(255) NOT NULL,
  `category2_id` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `categories_1`
--

INSERT INTO `categories_1` (`sid`, `category1_name`, `category2_id`) VALUES
(1, '美式', '1'),
(2, '中式', '2'),
(3, '法式', '3'),
(4, '意式', '4');

-- --------------------------------------------------------

--
-- 資料表結構 `comment_get_good`
--

CREATE TABLE `comment_get_good` (
  `good_id` int(10) NOT NULL COMMENT '流水號',
  `comment_id` int(10) NOT NULL COMMENT '評論id',
  `id` int(100) NOT NULL COMMENT '點讚的會員帳號'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `comment_get_good`
--

INSERT INTO `comment_get_good` (`good_id`, `comment_id`, `id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `event_record`
--

CREATE TABLE `event_record` (
  `member_number` int(11) NOT NULL COMMENT '會員編號',
  `event_time` datetime NOT NULL COMMENT '增加進度的發生時間',
  `event_trigger` int(6) NOT NULL COMMENT '哪個trigger要增加',
  `add_progress` int(10) NOT NULL DEFAULT 0 COMMENT '增加的進度'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `event_record`
--

INSERT INTO `event_record` (`member_number`, `event_time`, `event_trigger`, `add_progress`) VALUES
(1, '2020-12-23 13:31:16', 1, 1000),
(1, '2020-12-23 13:31:32', 1, 1000),
(1, '2020-12-01 00:00:00', 1, 1000),
(1, '2020-12-01 00:00:00', 2, 3),
(1, '2020-12-02 00:00:00', 1, 1000),
(1, '2020-12-02 00:00:00', 2, 3),
(1, '2020-12-01 00:00:00', 1, 1000),
(1, '2020-12-01 00:00:00', 2, 3),
(1, '2020-12-02 00:00:00', 1, 10000),
(1, '2020-12-02 00:00:00', 2, 30),
(1, '2020-12-24 00:00:00', 4, 1),
(1, '2020-12-31 00:00:00', 3, 1),
(1, '2020-12-10 00:00:00', 4, 1),
(2, '2020-12-23 13:31:16', 1, 1000),
(2, '2020-12-23 13:31:32', 1, 1000),
(2, '2020-12-01 00:00:00', 1, 1000),
(2, '2020-12-01 00:00:00', 2, 3),
(2, '2020-12-02 00:00:00', 1, 1000),
(2, '2020-12-02 00:00:00', 2, 3),
(2, '2020-12-01 00:00:00', 1, 1000),
(2, '2020-12-01 00:00:00', 2, 3),
(2, '2020-12-02 00:00:00', 1, 10000),
(2, '2020-12-02 00:00:00', 2, 30),
(2, '2020-12-24 00:00:00', 4, 1),
(2, '2020-12-31 00:00:00', 3, 1),
(2, '2020-12-10 00:00:00', 4, 1),
(1, '2021-01-02 00:00:00', 1, 10000),
(1, '2021-01-02 00:00:00', 2, 30),
(1, '2020-12-15 00:00:00', 1, 10000),
(1, '2020-12-15 00:00:00', 2, 30),
(1, '2020-12-24 00:00:00', 1, 10000),
(1, '2020-12-24 00:00:00', 2, 30),
(1, '2020-12-24 00:00:00', 1, 10000),
(1, '2020-12-24 00:00:00', 2, 30),
(1, '2020-12-24 00:00:00', 1, 10000),
(1, '2020-12-24 00:00:00', 2, 30);

-- --------------------------------------------------------

--
-- 資料表結構 `exchange_good`
--

CREATE TABLE `exchange_good` (
  `good_ID` int(6) NOT NULL COMMENT '優惠編號',
  `good_type` int(2) NOT NULL COMMENT '優惠分類號碼',
  `good_name` varchar(255) NOT NULL COMMENT '優惠名稱',
  `good_subs` varchar(255) NOT NULL COMMENT '優惠說明',
  `need_point` int(6) NOT NULL COMMENT '兌換優惠所需點數',
  `good_pic` varchar(255) NOT NULL COMMENT '優惠顯示圖片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `exchange_good`
--

INSERT INTO `exchange_good` (`good_ID`, `good_type`, `good_name`, `good_subs`, `need_point`, `good_pic`) VALUES
(1, 1, '星巴克買一送一', '憑QR CODE可以獲得同口味大小星巴克飲料買一送一', 100, ''),
(2, 1, '7-11超商折價券50元', '我就是一段唬爛打我啊哈哈笨蛋', 100, ''),
(3, 1, '全家咖啡買一送一', '憑QR CODE可以獲得同口味咖啡買一送一', 50, ''),
(4, 1, '7-11超商折價券100元', '我就是一段唬爛打我啊哈哈笨蛋', 200, ''),
(5, 2, '站內50元折價', '你好我是一個介紹優惠的唬爛，你好我是一個介紹優惠的唬爛，你好我是一個介紹優惠的唬爛', 100, ''),
(6, 2, '站內100元折價', ' 儘管如此，別人往往卻不這麼想。蕭伯納告訴我們，勞動是惟一導向知識的道路。這段話對世界的改變有著深遠的影響。話雖如此，我們卻也不能夠這麼篤定。', 100, ''),
(7, 2, '站內150元折價', '如果仔細思考站內優惠，會發現其中蘊含的深遠意義。\r\n對於站內優惠，我們不能不去想，卻也不能走火入魔。', 150, ''),
(8, 2, '站內200元折價', '我就是一段唬爛打我啊哈哈笨蛋', 200, '');

-- --------------------------------------------------------

--
-- 資料表結構 `history_mealdelivery`
--

CREATE TABLE `history_mealdelivery` (
  `sid` int(11) NOT NULL,
  `member_sid` int(11) NOT NULL,
  `meal_sid` varchar(255) NOT NULL,
  `meal_name` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `member_name` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `delivery_time` time DEFAULT NULL,
  `check_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `history_mealdelivery`
--

INSERT INTO `history_mealdelivery` (`sid`, `member_sid`, `meal_sid`, `meal_name`, `quantity`, `member_name`, `mobile`, `address`, `delivery_date`, `delivery_time`, `check_date`) VALUES
(509572507, 1, '1,4', '紅薯蛋糕,中國檸檬雞和嫩皮', '1,1', '王曉明', '0945456321', '台北市大安區復興南路一段390號2樓', '2021-02-02', '10:50:17', '2021-01-31 13:42:59');

-- --------------------------------------------------------

--
-- 資料表結構 `ingredients`
--

CREATE TABLE `ingredients` (
  `sid` int(11) NOT NULL,
  `ingredient_name` varchar(255) NOT NULL,
  `ingredient_id` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `ingredients`
--

INSERT INTO `ingredients` (`sid`, `ingredient_name`, `ingredient_id`) VALUES
(1, '1個番茄', '1'),
(2, '1個生菜', '2'),
(3, '1個蛋黃醬', '3'),
(4, '50克克斯蒂爾頓奶酪', '4'),
(5, '300克土豆', '5'),
(6, '300克地瓜', '6'),
(7, '1湯匙白葡萄酒醋', '7'),
(8, '1湯匙辣椒醬', '8'),
(9, '1個石灰', '9'),
(10, '40克切達干酪', '10'),
(11, '1茶匙乾辣椒片', '11'),
(12, '100克印度香米', '12'),
(13, '1蜂蜜', '13'),
(14, '250g牛肉末', '14'),
(15, '6個玉米餅', '15'),
(16, '1茶匙煙燻辣椒粉', '16'),
(17, '1個蘋果', '17'),
(18, '2個紅洋蔥', '18'),
(19, '1個蔥', '19'),
(20, '250g英國豬肉末', '20'),
(21, '1瓶紅酒醋', '21'),
(22, '2塊奶油蛋捲麵包', '22'),
(23, '1個檸檬', '23'),
(24, '1個辣椒', '24'),
(25, '1辦大蒜', '25'),
(26, '4湯匙玉米粉', '26'),
(27, '30毫升醬油', '27'),
(28, '1包芝麻', '28'),
(29, '250克雞胸肉', '29'),
(30, '160g嫩莖西蘭花', '30'),
(31, '15克薑', '31'),
(32, '100克黃瓜', '32'),
(33, '2湯匙白米醋', '33'),
(34, '2湯匙豆沙醬', '34'),
(35, '1湯匙番茄醬', '35'),
(36, '250g白菜', '36'),
(37, '2個魚片', '37'),
(38, '2個小麥麵條', '38'),
(39, '1個雞蛋', '39'),
(40, '120g蘆筍', '40'),
(41, '2個多利魚', '41'),
(42, '30克麵包粉', '42'),
(43, '綜合種子', '43'),
(44, '150g菠菜', '44'),
(45, '50克奶油', '45'),
(46, '160克紅蘿蔔', '46'),
(47, '160克蘑菇', '47'),
(48, '40克羅勒', '48'),
(49, '200克義大利麵', '49'),
(50, '1個起司球', '50'),
(51, '80克甘藍切絲', '51'),
(52, '15毫升香醋', '52'),
(53, '3塊香腸', '53'),
(54, '2個火烤比薩皮', '54'),
(55, '10克香菜', '55'),
(56, '180克蝦仁', '56');

-- --------------------------------------------------------

--
-- 資料表結構 `meal`
--

CREATE TABLE `meal` (
  `sid` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `on_sale` tinyint(1) NOT NULL DEFAULT 1,
  `vegetarian_food` tinyint(1) NOT NULL,
  `introduction` text NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `ingredient_id` varchar(255) DEFAULT NULL,
  `recipe_id` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `meal`
--

INSERT INTO `meal` (`sid`, `product_name`, `product_id`, `price`, `on_sale`, `vegetarian_food`, `introduction`, `category_id`, `ingredient_id`, `recipe_id`, `created_at`) VALUES
(1, '紅薯蛋糕', 'american01', 500, 1, 1, '這個鮮活的小數字在切碎的小寶石上鋪上堅固耐用的現成的地瓜餅，上面舖有自製的藍紋奶酪醬，並飾以鬆脆的烤山核桃。', '1', '1,2,3,4,5,6,7,8,9,10', '1', '2020-12-16 00:00:00'),
(2, '粘辣椒辣椒墨西哥捲餅配酸橙蛋黃醬', 'american02', 450, 1, 0, '要製作這些墨西哥風味的粘稠的牛肉捲餅，您需要在溫暖的玉米餅中將米飯，脆皮生菜和辛辣牛肉分層。把它們包起來，撒上大量的薑黃蛋黃醬，細細挖一下！', '1', '1,9,2,10,16,11,12,13,14,3,8,16', '2', '2020-12-16 00:00:00'),
(3, '辣椒粉豬肉漢堡，蘋果沙拉和楔子', 'american03', 600, 1, 0, '對於這個煙熏的豬肉漢堡，您可以將多汁的英國豬肉和熏制的辣椒粉一起烤熟，然後在奶油焦糖麵包中加焦糖洋蔥和酥脆的蘋果色拉來做餡餅。包子令人難以置信！', '1', '17,18,2,19,16,20,21,22,5,3\r\n', '3', '2020-12-16 00:00:00'),
(4, '中國檸檬雞和嫩皮', 'china01', 400, 1, 0, '黏膩，甜美和酥脆的完美水平，這是一款永不失敗的複古經典。您需要在炸雞上塗上蜂蜜檸檬醬，再搭配米飯和Tenderstem西蘭花。', '2', '23,24,25,19,16,26,13,12,27,28,29,30', '4', '2020-12-18 09:22:00'),
(5, '脆皮中國豬肉飯', 'china02', 450, 1, 0, '這個中國風格的豬肉和飯碗滿足了您自家製中國菜的所有需求。脆，甜，咸，鬆脆的豬肉通過蓬鬆的米飯混合在一起。我們的醃製黃瓜絲帶是完美的快速面，帶來對比和新鮮感。', '2', '25,31,27,19,32,33,34,16,11,20,13,12', '5', '2020-12-18 11:08:25'),
(6, '鱸魚，白菜和四川醬', 'china03', 500, 1, 0, '搭配白菜的這種全麥麵條快速油炸，佐以火熱的四川風味紅醬。配以美麗的鱸魚片和撒上烤芝麻。下巴容易！', '2', '25,31,27,19,33,35,36,11,37,38,28,13', '6', '2020-12-18 11:16:39'),
(7, '魚籽，檸檬醬和英式蘆筍', 'french01', 300, 1, 0, '對於神話般的魚晚餐，您需要先在脆皮種子和麵包屑上塗巴薩魚片，然後再煎至金黃色。與烤的英式蘆筍，奶油土豆泥和辛辣的自製“檸檬醬”一起食用。', '3', '23,39,40,41,42,5,3,43', '7', '2020-12-18 11:21:03'),
(8, '檸檬菠菜烤魚', 'french02', 350, 1, 0, '要在經典的法式晚飯上加入這種風味，您需要在烤箱中烘烤檸檬魚片，然後將其配上脆皮的土豆片和最終的俗氣菠菜。祝您好胃口！', '3', '23,10,44,41,5', '8', '2020-12-18 11:23:54'),
(9, '雞肉奶油蘑菇醬和土豆泥', 'french03', 300, 1, 0, '奶油蘑菇醬是經典之作。要享用這道令人欣慰的晚餐，您可以將其與烤雞胸肉，黃油泥和烤Chantenay胡蘿蔔一起食用。祝您好胃口！', '3', '27,45,46,17,5,29', '9', '2020-12-18 11:23:54'),
(10, '波多貝羅蘑菇和香蒜醬扁麵條', 'italy01', 300, 1, 1, '柔滑的扁麵條，放入自製的羅勒香蒜醬和焦糖的波多貝羅蘑菇拌在一起，再加上烤好的種子。嗨，香蒜醬！', '4', '47,25,48,10,43,49', '10', '2020-12-18 11:30:02'),
(11, '茴香，香腸和羽衣甘藍披薩', 'italy02', 350, 1, 0, '茴香和香腸是這款簡單而精緻的比薩的完美意大利風味搭配。奶油芝士，甜焦糖洋蔥和羽衣甘藍蓬鬆的比薩餅底料。那是更多！', '4', '18,25,16,50,51,52,53,54,35', '11', '2020-12-18 11:32:51'),
(12, '簡單的大蝦，大蒜和辣椒扁麵條', 'italy03', 400, 1, 0, '用辣椒，大蒜，歐芹和多汁的大蝦製作經典的西西里意大利面。然後簡單地擠上檸檬即可提亮口味，並佐以細雨橄欖油。', '4', '23,24,25,19,55,56,49', '12', '2020-12-18 11:32:51'),
(26, '測試333aa', 'tesstaa', 155151533, 1, 1, 'ffdff333aa', '3', NULL, NULL, '2020-12-21 11:58:54'),
(27, '測試333', 'tesst', 101000, 1, 0, '', '1', NULL, NULL, '2020-12-21 14:23:41'),
(28, '測試2', '1222', 101000, 1, 0, '', '1', NULL, NULL, '2020-12-21 14:23:50'),
(29, '測試333aq', 'tesstaaqq', 101000, 1, 0, 'qqqqqq', '3', NULL, NULL, '2020-12-22 14:22:12'),
(30, '測試333aaww', 'wwwwww', 101000, 1, 0, 'wwwwww', '3', '13', NULL, '2020-12-22 15:03:18'),
(31, '測試333aa', 'tesstaaqqaaaaa', 101000, 1, 0, 'wwwtffff', '1', '17', '11', '2020-12-22 15:12:34'),
(32, '測試', 'tesstaa', 101000, 1, 0, '', '1', '6', '1', '2020-12-22 17:20:27'),
(33, '測試333aa', '12212', 121, 1, 0, '23121', '1', '1', '1', '2020-12-22 17:22:48'),
(34, '測試333aa', 'tesstaa', 101000, 1, 0, 'hhhh', '2', '21', '1', '2020-12-22 18:15:21'),
(35, '123131312', '12313123213', 1313131, 1, 0, '13131231232', '1', '20', '8', '2020-12-22 18:18:46'),
(36, '123131312', '12313123213', 1313131, 1, 0, '13131231232', '1', '20', '8', '2020-12-22 18:19:58'),
(37, '測試dadfafafaf', 'tesst', 11111, 1, 0, 'fadfadfadfafaf', '1', '18', '1', '2020-12-22 18:21:36'),
(38, '測試333aa', '12123131312', 11111, 1, 0, '312313', '1', NULL, '1', '2020-12-22 18:29:40'),
(39, '4516161', '15616156', 156165, 1, 0, '156156156', '1', '1', '1', '2020-12-23 13:44:20'),
(40, '測試', '123', 123, 1, 0, '', '1', 'Array', '1', '2020-12-23 13:47:41'),
(41, '測試333aa', 'tesst', 0, 1, 0, '', '1', 'Array', '1', '2020-12-23 13:48:02'),
(42, '測試', 'tesst', 0, 1, 0, '', '1', '1,18,13', '1', '2020-12-23 13:52:15'),
(43, 'sfsdfs', 'fsdfsdfsd', 1111, 1, 0, '', '1', 'Array', '1', '2020-12-23 13:56:43'),
(44, 'sfsdfs', 'fsdfsdfsd', 1111, 1, 0, '', '1', '15,18,1', '1', '2020-12-23 14:02:00'),
(46, '黯然消魂飯23', 'tesstaa23', 99999923, 1, 0, '食神特製23', '3', '1,5,7,8,15', '8', '2020-12-24 10:58:35'),
(49, '測試', 'tesst', 101000, 1, 0, '', '1', '1,16,20', '1', '2020-12-24 19:34:07');

-- --------------------------------------------------------

--
-- 資料表結構 `membercenter`
--

CREATE TABLE `membercenter` (
  `id` int(100) NOT NULL,
  `member_number` varchar(255) DEFAULT NULL,
  `avater` varchar(255) DEFAULT NULL,
  `level` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(10) NOT NULL,
  `nickname` varchar(10) NOT NULL,
  `mobile` varchar(10) NOT NULL,
  `birthday` date NOT NULL,
  `credit＿card` varchar(255) NOT NULL,
  `addr` varchar(255) NOT NULL,
  `love` varchar(255) DEFAULT NULL,
  `simplemeal_coupon` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `membercenter`
--

INSERT INTO `membercenter` (`id`, `member_number`, `avater`, `level`, `email`, `password`, `name`, `nickname`, `mobile`, `birthday`, `credit＿card`, `addr`, `love`, `simplemeal_coupon`) VALUES
(1, '20210001', 'avatar01.jpg', 'vip會員', 'GoodGoodEat@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '王曉明', '小明', '0945456321', '1990-10-10', '1234-1234-1234-1234', '台北市大安區復興南路一段390號2樓', '1,2,3', 100);

-- --------------------------------------------------------

--
-- 資料表結構 `milestone_manager`
--

CREATE TABLE `milestone_manager` (
  `milestone_sid` int(6) NOT NULL COMMENT '成就編號',
  `stone_name` varchar(255) NOT NULL COMMENT '成就名稱',
  `event_startime` datetime NOT NULL COMMENT '成就觸發開始時間',
  `event_endtime` datetime DEFAULT NULL COMMENT '成就觸發結束時間',
  `event_trigger` int(5) NOT NULL COMMENT '觸發成就進度的行為',
  `progress_goal` int(10) NOT NULL COMMENT '完成目標須達到的數量',
  `reward_point` int(10) NOT NULL DEFAULT 0 COMMENT '達成成就可獲得的獎勵點數',
  `subs` varchar(255) NOT NULL COMMENT '詳述此成就的活動辦法',
  `unfinished_goal_pic` varchar(255) NOT NULL COMMENT '未達成成就時的圖示連結',
  `finished_goal_pic` varchar(255) NOT NULL COMMENT '已達成成就時的圖示連結'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `milestone_manager`
--

INSERT INTO `milestone_manager` (`milestone_sid`, `stone_name`, `event_startime`, `event_endtime`, `event_trigger`, `progress_goal`, `reward_point`, `subs`, `unfinished_goal_pic`, `finished_goal_pic`) VALUES
(1, '累積消費一萬元', '2021-01-01 13:03:00', '2021-01-09 13:03:00', 1, 10000, 200, '累積消費一萬元可得200點', '5fe419625578c.png', '5fe4196255c28.png'),
(2, '累積消費十萬元', '2020-12-23 12:25:00', '2020-12-24 12:09:12', 1, 100000, 1000, '累積消費十萬元可得1000點', '5fe4143de8347.png', '5fe4143de8634.png'),
(3, '累積消費五萬元', '2020-12-23 12:25:00', NULL, 1, 50000, 500, '累積消費5萬元可得500點', '5fe418cc23365.png', '5fe418cc239a8.png'),
(4, '第一筆評論', '2020-01-24 12:32:00', '2020-01-24 12:32:00', 3, 1, 50, '第一次對餐點評分可得50點', '5fe41a73444a3.png', '5fe41a7344606.png'),
(5, '我是評論家', '2021-01-25 09:11:00', NULL, 3, 10, 200, '累積發表十篇心得可得200點', '', '');

-- --------------------------------------------------------

--
-- 資料表結構 `milestone_user`
--

CREATE TABLE `milestone_user` (
  `exchange_sid` int(6) NOT NULL COMMENT '兌換商品編號',
  `spend_point` int(6) NOT NULL DEFAULT 0 COMMENT '花費的點數',
  `event_time` datetime NOT NULL COMMENT '兌換的觸發時間',
  `memner_number` int(11) NOT NULL COMMENT '該會員的ID',
  `discount` int(11) DEFAULT NULL,
  `discount_code` varchar(255) NOT NULL,
  `used_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `milestone_user`
--

INSERT INTO `milestone_user` (`exchange_sid`, `spend_point`, `event_time`, `memner_number`, `discount`, `discount_code`, `used_date`) VALUES
(1, 100, '2020-12-25 01:40:09', 1, NULL, '', NULL),
(2, 100, '2020-12-25 01:57:48', 1, NULL, '', NULL),
(5, 100, '2020-12-25 02:18:34', 1, 50, '', NULL),
(5, 100, '2021-02-08 10:05:07', 1, 50, '', NULL);

-- --------------------------------------------------------

--
-- 資料表結構 `partner`
--

CREATE TABLE `partner` (
  `vender_id` int(10) NOT NULL COMMENT '廠商ID',
  `vender_name` varchar(25) NOT NULL COMMENT '廠商名稱',
  `vender_pic` int(11) DEFAULT NULL COMMENT '廠商照片',
  `vender_add` text DEFAULT NULL COMMENT '廠商地址'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `partner`
--

INSERT INTO `partner` (`vender_id`, `vender_name`, `vender_pic`, `vender_add`) VALUES
(1, '青椒農場', NULL, '台北市大安區阿福路一段333號');

-- --------------------------------------------------------

--
-- 資料表結構 `recipe`
--

CREATE TABLE `recipe` (
  `sid` int(11) NOT NULL,
  `recipe_name` varchar(255) NOT NULL,
  `recipe_pic_01` varchar(255) NOT NULL,
  `recipe01` text DEFAULT NULL,
  `recipe_pic_02` varchar(255) NOT NULL,
  `recipe02` text DEFAULT NULL,
  `recipe_pic_03` varchar(255) NOT NULL,
  `recipe03` text DEFAULT NULL,
  `recipe_pic_04` varchar(255) NOT NULL,
  `recipe04` text DEFAULT NULL,
  `recipe_pic_05` varchar(255) NOT NULL,
  `recipe05` text DEFAULT NULL,
  `recipe_pic_06` varchar(255) NOT NULL,
  `recipe06` text DEFAULT NULL,
  `recipe_pic_07` varchar(255) NOT NULL,
  `recipe07` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `recipe`
--

INSERT INTO `recipe` (`sid`, `recipe_name`, `recipe_pic_01`, `recipe01`, `recipe_pic_02`, `recipe02`, `recipe_pic_03`, `recipe03`, `recipe_pic_04`, `recipe04`, `recipe_pic_05`, `recipe05`, `recipe_pic_06`, `recipe06`, `recipe_pic_07`, `recipe07`) VALUES
(1, '紅薯蛋糕', 'american01_01', '燒水壺\r\n\r\n將烤箱預熱至220°C / 200°C（風扇）/ 425°F /氣體7\r\n\r\n將白土豆洗淨切成3厘米的立方體\r\n\r\n將它們放入帶有匹配蓋的大鍋中，加熱時要蓋上鍋蓋，鍋中要加2英寸長的鹽（開水）', 'american01_02', '將水高火燒開，蓋上蓋子將土豆煮沸8分鐘\r\n\r\n同時，將紅薯洗淨切成3厘米的立方體\r\n\r\n設置預留了攪拌碗足夠大，以適應白色和紅薯既為第4步', 'american01_03', '添加甘藷到鍋8分鐘後，煮沸都未被覆蓋的另外的5分鐘，稍微軟化\r\n\r\n同時，將藍紋奶酪和醋一起倒入一個碗中，然後搗成糊狀\r\n\r\n混合蛋黃醬，1湯匙（2湯匙）牛奶和胡椒粉調味\r\n\r\n這是你的藍紋奶酪醬', 'american01_04', '冷卻至可以處理的程度，然後搖幹\r\n\r\n將兩者都加入到攪拌碗中，並塗上辣椒醬，然後塗上4湯匙（8湯匙）麵粉，然後用土豆泥將它們輕輕壓碎。\r\n\r\n季鹽和胡椒，形狀為4個（8）肉餅＆灰塵在麵粉密封', 'american01_05', '用2湯匙（4湯匙）的植物油加熱一個大的不粘煎鍋\r\n\r\n當熱，添加蛋糕和煮在每一側為3分鐘，直至金黃色\r\n\r\n提示：將蛋糕變平成均勻的形狀後，用抹刀（或類似的東西）將蛋糕稍稍向下壓 ', 'american01_06', '一旦焦黃，蛋糕的烘烤盤（用錫紙，以避免混亂）和賽季鹽和胡椒轉移到你的口味\r\n\r\n將其放入烤箱10-15分鐘，或直到蛋糕酥脆 \r\n\r\n添加山核桃到一個單獨的烤盤，放在烤箱5分鐘，或直至顏色略變暗 ', 'american01_07', '同時，洗淨切絲小寶石生菜（S）\r\n\r\n大致砍番茄（ES） \r\n\r\n'),
(2, '粘辣椒辣椒墨西哥捲餅配酸橙蛋黃醬', 'american02_01', '將烤箱預熱至220°C / 200°C（風扇）/ 425°F /氣體7\r\n\r\n將印度香米和250毫升[500毫升] 冷水加到有蓋的鍋中，並用高火煮沸\r\n\r\n煮沸後，將熱量降低至極低，然後蓋上鍋蓋煮10-12分鐘，或者直到所有水被吸收並煮熟米飯為止，然後從鍋上移開並蓋上鍋蓋直至上菜', 'american02_02', '用細雨植物油將大的寬底鍋（最好是不粘鍋）加熱\r\n\r\n加熱後，將牛肉末加入適量的鹽調味，煮3-4分鐘或直至變黃，然後用木勺將其切碎', 'american02_03', '雖然肉是烹飪，剁番茄[ES] 細\r\n\r\n切石灰[S]在半\r\n\r\n結合果汁的1/2 [1]石灰與蛋黃醬和的毛毛雨橄欖油\r\n\r\n用少許鹽和胡椒粉調味 -這就是您的酸橙蛋黃醬', 'american02_04', '烤焦後，將 熏制的辣椒粉和辣椒粉（不能承受熱量？容易！）加入牛肉中，煮1分鐘或直到香\r\n\r\n加入切碎的西紅柿，墨西哥辣椒醬和蜂蜜，煮3-5分鐘，或直到西紅柿開始分解並且牛肉變脆變粘為止–這就是您的粘辣椒牛肉', 'american02_05', '同時，將玉米餅加到烤盤中，然後將盤放在烤箱中3-4分鐘，或直至加熱至完全起酥', 'american02_06', '洗淨切絲的小寶石生菜 細\r\n\r\n爐排切達乾酪', 'american02_07', '將剩餘的石灰切成楔形\r\n\r\n煮熟後，用叉子將煮熟的 米飯撒上絨毛，然後用少許鹽調味'),
(3, '辣椒粉豬肉漢堡，蘋果沙拉和楔子', 'american03_01', '將烤箱預熱至220°C / 200°C（風扇）/ 425°F /氣體7\r\n\r\n將土豆 （去皮）縱向切成楔形\r\n\r\n將土豆楔子放入烤盤中，用植物油淋毛細雨 ， 然後 用 一半的煙熏辣椒粉調味（剩下的留待以後使用！）和一小撮鹽\r\n\r\n混合均勻，然後將托盤放入烤箱中25分鐘，直到酥脆', 'american03_02', '在煮土豆時，修整，然後切碎蔥[s]，將白色和綠色部分分開\r\n\r\n結合豬肉剁碎與剩下的 辣椒粉和白蔥部分碗裡，賽季非常慷慨鹽和胡椒\r\n\r\n將切碎的肉末切成2 [4] 小塊，然後冷凍至第6步（這有助於他們在烹飪時保持其形狀）–這些是您的辣椒粉豬肉漢堡', 'american03_03', '用大火加熱大的寬底鍋（最好是不粘鍋，配上合適的蓋子）\r\n\r\n變熱後，放入奶油蛋捲麵包，切成一面朝下，煮3分鐘或直至輕輕烤熟\r\n\r\n敬酒後，放在一邊，直到上菜並保留平底鍋', 'american03_04', '將紅洋蔥去皮，切成薄片\r\n\r\n將預留的鍋和細雨橄欖油倒回中火\r\n\r\n變熱後，加入 洋蔥圈並煮4-5分鐘，或者直到洋蔥開始焦糖化為止\r\n\r\n焦糖化後，放在一邊，直到上菜並保留鍋-這些就是您的焦糖洋蔥圈', 'american03_05', '同時，結合 了 紅酒醋，蛋黃醬，蔥的綠色部分，2湯匙[4湯匙] 橄欖油和少許鹽和胡椒粉-這是你的沙拉醬\r\n\r\n切片的蘋果[S]  （皮膚）薄，並將其添加到沙拉醬，傾其所有了良好的混淆-這是你打扮的蘋果', 'american03_06', '將保留的鍋放高火\r\n\r\n變熱後，加入辣椒粉豬肉漢堡並煮熟，每面覆蓋3-4或直到煮熟為止（沒有粉紅色的肉！）', 'american03_07', '切碎小寶石生菜\r\n\r\n在切碎的蘋果中加入切碎的生菜，然後將所有食物充分拌勻-這就是您的蘋果沙拉'),
(4, '中國檸檬雞和嫩皮', 'china01_01', '將烤箱預熱至200°C / 180°C（風扇）/ 350°F /氣體4\r\n\r\n將印度香米和300ml [600ml] 冷水加到有蓋的鍋中，並用高火煮沸\r\n\r\n煮沸後，將熱量降低至極低，然後蓋上鍋蓋煮10至12分鐘，或直到所有水被吸收並煮熟米飯為止\r\n\r\n煮熟後，從火上移開並蓋上鍋蓋直至上菜', 'china01_02', '大米煮的時候，將Tenderstem brocolli切成兩半\r\n\r\n切1 [2]片[S]的錫箔約 A3紙的尺寸\r\n\r\n 用1湯匙[2湯匙]水和少許鹽將Tenderstem放在中間，然後放入烤盤中\r\n\r\n將箔的邊緣纏繞在Tenderstem周圍以形成密封的包裹\r\n\r\n將托盤放在烤箱中15分鐘或直到變軟', 'china01_03', '同時，將大蒜去皮並切碎（或切碎）\r\n\r\n將1/2 [1] 檸檬切成薄片，然後將1/2 [1] 檸檬切成碗\r\n\r\n將蜂蜜，1茶匙[2茶匙]的玉米粉，1/2的醬油（剩下的留待以後使用！）和100毫升[200毫升]的 冷水倒入碗中\r\n\r\n拌勻-這是您的檸檬醬', 'china01_04', '縱向將雞胸肉切成4 [8]條，然後將每條切成兩半\r\n\r\n添加剩餘的 玉米粉一碗用1茶匙沿著[2茶匙] 糖，1/2 [全部]中的五香組合 和慷慨的磨黑胡椒 和把全部加在一起\r\n\r\n將雞條放入碗中，攪拌均勻，直到所有雞都被塗上', 'china01_05', '用大量的植物油在高溫下加熱一個寬大的平底鍋（最好是不粘鍋）\r\n\r\n將鍋放熱後，將塗有塗層的雞肉與剩餘的 醬油一起加入，每面煮5-6分鐘，直到金黃和香脆，然後將雞肉煮熟（沒有粉紅色的肉！）–這就是您的香脆雞\r\n\r\n酥脆後，轉移到盤子上並放在一邊\r\n\r\n保留鍋', 'china01_06', '同時，修剪，然後切片的蔥細\r\n\r\n切紅辣椒[ES]在一半縱向，解種子（刮種子出用茶匙）和CHOP音響納利\r\n\r\n將切成薄片的蔥和切碎的辣椒（不能承受熱量？輕鬆！）倒入煮好的米飯中–這就是您的辣椒飯', 'china01_07', '用細雨植物油將鍋放回中低火\r\n\r\n加熱後，加入切碎的 大蒜，煮1分鐘直至香\r\n\r\n放香後，加入檸檬醬並煮2-3分鐘，直到醬變粘稠為止'),
(5, '脆皮中國豬肉飯', 'china02_01', '添加大米和350毫升[700毫升]水到罐中，加上蓋子並在高的熱燒開\r\n\r\n一旦沸騰，熱降低到非常低的和做飯，覆蓋，10-15分鐘或直到水吸收和大米煮熟，然後從火上移開和保持覆蓋，直到服務', 'china02_02', '同時，用蔬菜削皮器將黃瓜去皮\r\n\r\n提示：請保持柔軟的種子中心在第6步！\r\n\r\n結合米醋和黃瓜絲帶與少許鹽碗，放置一旁醃製，直至服務 ', 'china02_03', '將大蒜去皮並切碎（或切碎）\r\n\r\n將生薑去皮（用茶匙刮掉皮膚）並切碎（或切碎）\r\n\r\n將葡萄乾，蜂蜜，一半的醬油和2湯匙 [4湯匙] 水混合在一起\r\n\r\n 在中高溫下，將1-2湯匙植物油加到一個大的寬底鍋中（最好是不粘鍋）', 'china02_04', '一旦熱時，放入蒜，姜，五香粉和辣椒片（不能處理熱？悠著點！），並不斷攪拌1分鐘，再加入豬肉肉和煮4-6分鐘或直到開始褐色隨身攜帶分解', 'china02_05', '攪拌海鮮醬\r\n\r\n煮 約。4分鐘或直到酥脆並煮熟', 'china02_06', '同時，將黃瓜的種子中心切成小塊\r\n\r\n切片蔥[S] 精細，丟棄所述根端部', 'china02_07', '用叉子把煮好的米飯弄松\r\n\r\n添加大米，黃瓜片，蔥半豬肉\r\n\r\n季節與剩餘的醬油和辣椒碾好'),
(6, '鱸魚，白菜和四川醬', 'china03_01', '燒水壺\r\n\r\n將全麥麵條放入鍋中，並用開水蓋住，直到完全浸沒\r\n\r\n用高火煮沸，煮5-7分鐘，直到被輕微咬​​軟為止，然後瀝乾 \r\n\r\n提示：將排幹的麵條塗上植物油，以防止它們粘在一起', 'china03_02', '同時，將大蒜 去皮並切碎（或切碎）\r\n\r\n削皮（用茶匙刮掉皮膚）並切碎（或切碎）生薑\r\n\r\n修剪，然後將每個蔥切 成兩半\r\n\r\n將白菜切成兩半，將白色底料和綠色頂料分開', 'china03_03', '將瀝乾的麵條放在一旁，然後用細雨植物油將鍋放回中火（無需沖洗！）\r\n\r\n加熱後，加入切碎的 大蒜和姜，煮2分鐘或直到香 ', 'china03_04', '加入蘋果 醋，番茄醬，蜂蜜，醬油和辣椒 粉（不能加熱嗎？放輕鬆！）煮1分鐘\r\n\r\n加一點水使醬汁變松，然後用大量黑胡椒粉調味 \r\n\r\n將鍋從火上移開並放在一旁–這是您的四川醬 ', 'china03_05', '熱量大，基於寬鍋（優選不粘）用的毛毛雨植物油在中高熱量\r\n\r\n拍打鱸魚魚片乾燥並用鹽適量調味\r\n\r\n變熱後，將鱸魚，皮膚朝下放入鍋中煮4分鐘，然後再翻轉並煮1分鐘\r\n\r\n提示：請盡量不要在鍋子周圍移動鱸魚，因為這會防止它變脆', 'china03_06', '同時，熱的第二大的，基於寬鍋（優選不粘）用的毛毛雨植物油在中高熱量\r\n\r\n加熱後，將 白菜切碎 ，放入鍋中，然後加入 切碎的蔥 和少許鹽，煮2分鐘', 'china03_07', '加入瀝乾的麵條和 青菜 頂 ，再煮2分鐘'),
(7, '魚籽，檸檬醬和英式蘆筍', 'french01_01', '將烤箱預熱至200°C / 180°C（風扇）/ 350°F /氣體4\r\n\r\n燒水壺\r\n\r\n修剪蘆筍長矛的木質末端，並將其添加到烤盤中\r\n\r\n用橄欖油將切碎的蘆筍毛毛雨，並用少許鹽調味，然後將托盤放入烤箱中15-20分鐘或直到蘆筍變軟。', 'french01_02', '同時，將土豆去皮切成小塊\r\n\r\n將切碎的土豆放到開水鍋中，加少許鹽在高溫下煮10-15分鐘或直到它們變嫩\r\n\r\n煮熟後，瀝乾並將其放回鍋中', 'french01_03', '同時，將檸檬減半[s]\r\n\r\n熱情和果汁一半的檸檬[S]成一個小碗裡\r\n\r\n將蛋黃醬和適量的鹽和胡椒粉倒入碗中，然後將所有東西充分攪拌均勻-這就是您的檸檬醬\r\n\r\n切剩下的檸檬[S]成楔', 'french01_04', '將3湯匙[6湯匙] 麵粉加到盤子裡\r\n\r\n破解蛋[S]成淺碗和用叉子輕輕拍\r\n\r\n將Panko麵包屑和松子和種子混合小袋[s]放在一個大碗中，放少許鹽', 'french01_05', '大衣巴沙 魚片在麵粉，水龍頭掉多餘的，然後蘸成蛋液，最後按他們進入種子和 麵包屑混合堅決外套一切均勻-這些都是你的種子魚片', 'french01_06', '用中湯加熱3湯匙[6湯匙] 植物油，將一個寬大的鍋（最好是不粘鍋）加熱\r\n\r\n加熱後，加入去籽的魚片，並在各面上煮3-4分鐘，或直至煮至金黃\r\n\r\n提示：如果您的鍋看起來乾燥，請添加一些額外的油', 'french01_07', '將瀝乾的土豆放低火，並加一點牛奶和一大把黃油\r\n\r\n用少許鹽，胡椒粉和土豆泥調味，直到變滑'),
(8, '檸檬菠菜烤魚', 'french02_01', '將烤箱預熱至220°C / 200°C（風扇）/ 425°F /氣體7\r\n\r\n將土豆（去皮）切成薄片。1厘米厚\r\n\r\n將它們添加到烤盤中', 'french02_02', '用橄欖油大量淋土豆，然後用鹽和胡椒充分調味。\r\n\r\n將托盤放在烤箱中20-25分鐘，或直到土豆煮熟並酥脆', 'french02_03', '同時，切達干酪切碎\r\n\r\n熱情的1/2 [1] 檸檬 切成四分之一\r\n\r\n洗淨，乾燥後，再剁成菠菜大致', 'french02_04', '在中低火中在鍋中融化1湯匙[2湯匙]黃油\r\n\r\n融化後，加入1湯匙[2湯匙] 麵粉，然後用木勺攪拌1-2分鐘或直到形成沙糊狀–這就是您的通心粉', 'french02_05', '逐漸將200毫升[300毫升]牛奶攪打入肉湯中，並煮5分鐘或直到剩下光滑，濃稠的醬汁–這就是您的奶油醬', 'french02_06', '將巴薩魚片添加到烤盤中（使用錫紙以避免混亂！）\r\n\r\n用1-2湯匙橄欖油下毛毛雨，用鹽和胡椒調味，然後將檸檬皮撒在上面。\r\n\r\n將托盤放在烤箱中10分鐘或直到魚煮熟為止\r\n\r\n提示：魚變得不透明且容易剝落時會煮熟', 'french02_07', '將白醬調味醬放到中火中加熱1-2分鐘\r\n\r\n加熱後，加入切碎的 奶酪和切碎的菠菜，攪拌直至奶酪融化，菠菜枯萎–這就是您的菠菜Mornay\r\n\r\n提示：如果醬汁看起來有點稠，請加一點水！'),
(9, '雞肉奶油蘑菇醬和土豆泥', 'french03_01', '將烤箱預熱至200°C / 180°C（風扇）/ 395°F /氣體6\r\n\r\n燒水壺\r\n\r\n將 雞胸肉 放到烤盤的一側，撒上細雨 橄欖油 和少許 鹽 和 胡椒粉', 'french03_02', '添加 Chantenay胡蘿蔔 到托盤的另一側的小雨橄欖油 和少許 鹽 和 胡椒粉\r\n\r\n將托盤放在烤箱中25-30分鐘，或直到雞肉煮熟（沒有粉紅色的肉！）並且胡蘿蔔變軟', 'french03_03', '將土豆去皮切  成小塊\r\n\r\n將它們加入一鍋加少許鹽的 開水中 ，  並用高火加熱至沸騰，煮10-15分鐘，或直至嫩叉\r\n\r\n完成後，瀝乾水分並返回鍋中蒸乾', 'french03_04', '雖然土豆做飯，剁栗蘑 大致\r\n\r\n再煮四分之一的水壺', 'french03_05', '熱量大，基於寬鍋（優選不粘）用的毛毛雨橄欖油通過介質熱\r\n\r\n加熱後，加入切碎的蘑菇並煮4-5分鐘，或直到開始變軟', 'french03_06', '同時，將軟奶酪溶解在50ml [100ml]開水中 –這是您的 乳脂狀湯料\r\n\r\n變軟後，在蘑菇中加入醬油和奶油狀的原料，再煮3-4分鐘，或直到變稠至類似奶油的雙重稠度–這就是您的奶油蘑菇醬', 'french03_07', '將瀝乾的土豆放低熱量，倒入大量 牛奶和黃油\r\n\r\n搗成泥，用少許鹽和胡椒粉調味'),
(10, '波多貝羅蘑菇和香蒜醬扁麵條', 'italy01_01', '將烤架預熱至高溫，然後燒開水壺\r\n\r\n（以獲得更有趣的質感）將波多貝羅和栗子蘑菇 切成小塊，放在烤盤上，撒上橄欖油， 然後用鹽和胡椒調味 \r\n\r\n將托盤直接放在烤架下方，煮12-15分鐘，或直到焦糖充分地焦化', 'italy01_02', '將3種種子混合物在高火下加入大鍋中，煮1-2分鐘或直至烤熟\r\n\r\n敬酒後，放在盤子上，放下鍋備用', 'italy01_03', '把鍋放高火\r\n\r\n將扁麵條加大量白開水加少許鹽，用高火煮沸，煮8-12分鐘，或直至稍加煮熟\r\n\r\n煮熟後，瀝乾並儲備一杯澱粉狀的烹飪水', 'italy01_04', '同時，將大蒜去皮並切碎（或切碎）\r\n\r\n將羅勒切碎，包括莖 \r\n\r\n爐排切達乾酪細 ', 'italy01_05', '在研缽和研缽中將切碎的 羅勒，切碎的 大蒜和少許鹽研磨成光滑的糊狀。\r\n\r\n加入2-3湯匙橄欖油，攪拌均勻\r\n\r\n提示：如果沒有研缽和研缽，則將羅勒切碎，然後與橄欖油混合\r\n\r\n ', 'italy01_06', '添加磨碎的奶酪到羅勒2-3湯匙橄欖油\r\n\r\n加入少許鹽和胡椒粉調味，然後調勻-這就是您的香蒜醬', 'italy01_07', '將瀝乾的扁麵條倒入鍋中，並灑上少許保留的澱粉狀烹飪水\r\n\r\n將香蒜醬和一半的焦糖 蘑菇攪拌均勻， 然後煮1分鐘，或者直到香蒜醬覆蓋麵食並且奶酪融化為止 '),
(11, '茴香，香腸和羽衣甘藍披薩', 'italy02_01', '將烤箱預熱至200°C / 180°C（風扇）/ 390°F /氣體6\r\n\r\n在烤箱中放一個大的烤盤進行加熱（這將防止比薩餅底部變濕！）\r\n\r\n 從他們的皮膚上去除香腸肉 並丟棄皮膚\r\n\r\n將大蒜去皮並切碎（或切碎）', 'italy02_02', '加熱一個寬大的平底鍋（最好是不粘鍋，配上合適的蓋子），然後在中高溫下淋上橄欖油\r\n\r\n一旦變熱，將香腸肉加進去，用木勺將其切成小塊，然後加入茴香籽（不是茴香的粉絲嗎？放輕鬆！）\r\n\r\n煮4分鐘或直到 香腸肉變脆', 'italy02_03', '同時，在一個小碗中將番茄醬，細雨橄欖油，少量冷水和1茶匙[2茶匙] 糖混合在一起\r\n\r\n季慷慨與鹽和胡椒-這是你的番茄醬\r\n\r\n排乾奶酪，將其撕成一口大小的塊，然後用廚房用紙拍幹 ', 'italy02_04', '從烤箱中取出加熱的烤盤，然後添加比薩餅基料\r\n\r\n用勺子的背面將番茄醬塗在比薩餅上 \r\n\r\n將撕碎的 奶酪點在上面，然後將托盤放入烤箱，直到第6步', 'italy02_05', '將比薩餅放在烤箱中時，將切碎的大蒜，辣椒片 （無法承受熱量？輕鬆！）和羽衣甘藍加香腸肉到鍋中\r\n\r\n煮1-2分鐘或蓋好，直到嬰兒 羽衣甘藍開始枯萎-這是您的羽衣甘藍和香腸混合物', 'italy02_06', '羽衣甘藍枯萎後，在羽衣甘藍和香腸混合物的比薩底上放上\r\n\r\n將它們放回烤箱10-12分鐘，或者直到馬蘇里拉 融化並且比薩餅變得脆脆-這些是您的茴香，香腸和羽衣甘藍比薩餅', 'italy02_07', '同時，將櫻桃番茄切成兩半\r\n\r\n將羅勒葉 切碎\r\n\r\n將其加入碗中，並淋上 橄欖油，然後加入少許 鹽和胡椒粉調味\r\n\r\n混合均勻-這就是您的番茄和羅勒沙拉'),
(12, '簡單的大蝦，大蒜和辣椒扁麵條', 'italy03_01', '燒開水壺，然後剝皮並切碎（或切碎） 大蒜\r\n\r\n修剪，然後切碎 蔥 大致\r\n\r\n切 紅辣椒[ES] 在一半縱向，deseed（刮種子出用茶匙），並大致斬', 'italy03_02', '將扁麵條加到一鍋加少許鹽的白開水中，並用高火煮沸\r\n\r\n將 意大利面煮8-10分鐘，或直至稍稍咬一口再煮\r\n\r\n完成後，排乾扁麵條，保留一杯澱粉麵食水', 'italy03_03', '混合切碎的 辣椒（無法承受熱量？輕鬆！）和蔥 一起切碎，直到剩下切碎的混合物–這就是您的辣椒和蔥的混合物', 'italy03_04', '熱量大，基於寬鍋（優選不粘）與3湯匙[6湯匙] 橄欖油通過介質熱\r\n\r\n加熱後，將辣椒和蔥混合物 放入鍋中，煮2分鐘或直至其開始變軟\r\n\r\n加入 大蝦和切碎的大蒜，煮4-5分鐘，或直到大蝦煮熟為止', 'italy03_05', '而蝦被烹調，切檸檬[S]在半\r\n\r\n切碎歐芹，包括莖', 'italy03_06', '將蝦煮熟後，將煮熟的扁麵條加少許澱粉麵食水倒入鍋中\r\n\r\n擠在果汁1/2 [1]檸檬，攪拌，直到醬粘到 扁-這是你的大蝦，大蒜和辣椒扁', 'italy03_07', '從火上移開並攪拌切碎的香菜\r\n\r\n將剩餘的 檸檬切成楔形');

-- --------------------------------------------------------

--
-- 資料表結構 `recipe_comment`
--

CREATE TABLE `recipe_comment` (
  `comment_id` int(10) NOT NULL COMMENT '評論id',
  `recipe` int(10) NOT NULL COMMENT '食譜id',
  `Account` int(255) NOT NULL COMMENT '會員id',
  `create_time` datetime NOT NULL COMMENT '建立時間',
  `comment` text NOT NULL COMMENT '評論內容',
  `reply_id` int(11) NOT NULL COMMENT '回覆的評論id',
  `del` int(1) NOT NULL DEFAULT 0 COMMENT '刪除',
  `ifread` int(1) NOT NULL DEFAULT 0 COMMENT '已讀'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `recipe_comment`
--

INSERT INTO `recipe_comment` (`comment_id`, `recipe`, `Account`, `create_time`, `comment`, `reply_id`, `del`, `ifread`) VALUES
(1, 1, 1, '2021-02-11 14:04:26', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', 23, 0, 0);

-- --------------------------------------------------------

--
-- 資料表結構 `recipe_get_good`
--

CREATE TABLE `recipe_get_good` (
  `good_id` int(10) NOT NULL COMMENT '流水號',
  `recipe_id` int(10) NOT NULL COMMENT '食譜id',
  `id` int(255) NOT NULL COMMENT '點讚的會員帳號'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `recipe_get_good`
--

INSERT INTO `recipe_get_good` (`good_id`, `recipe_id`, `id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- 資料表結構 `share_recipe`
--

CREATE TABLE `share_recipe` (
  `recipe_id` int(10) NOT NULL COMMENT '食譜id',
  `recipe_createtime` datetime NOT NULL COMMENT '建立時間',
  `recipe_name` varchar(30) NOT NULL COMMENT '食譜名稱',
  `recipe_creator` int(10) NOT NULL COMMENT '創造者id',
  `cook_time` int(3) NOT NULL COMMENT '烹飪時間',
  `style` varchar(25) NOT NULL COMMENT '風格',
  `Introduction` text NOT NULL COMMENT '簡介',
  `pic` text NOT NULL COMMENT '成品照'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `share_recipe`
--

INSERT INTO `share_recipe` (`recipe_id`, `recipe_createtime`, `recipe_name`, `recipe_creator`, `cook_time`, `style`, `Introduction`, `pic`) VALUES
(1, '2021-02-11 13:56:16', '青椒葛利義大利麵', 1, 60, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', '');

-- --------------------------------------------------------

--
-- 資料表結構 `share_recipe_ingredients`
--

CREATE TABLE `share_recipe_ingredients` (
  `sid` int(10) NOT NULL COMMENT '流水號',
  `recipe_id` int(10) NOT NULL COMMENT '食譜id',
  `Ingredients_id` int(10) NOT NULL COMMENT '食材id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `share_recipe_ingredients`
--

INSERT INTO `share_recipe_ingredients` (`sid`, `recipe_id`, `Ingredients_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- 資料表結構 `share_recipe_step`
--

CREATE TABLE `share_recipe_step` (
  `recipe_id` int(10) NOT NULL COMMENT '食譜流水號',
  `step1` text NOT NULL COMMENT '步驟1',
  `step2` text NOT NULL COMMENT '步驟2',
  `step3` text NOT NULL COMMENT '步驟3',
  `step4` text NOT NULL COMMENT '步驟4',
  `step5` text NOT NULL COMMENT '步驟5',
  `step6` text NOT NULL COMMENT '步驟6',
  `step7` text NOT NULL COMMENT '步驟7',
  `step8` text NOT NULL COMMENT '步驟8'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `share_recipe_step`
--

INSERT INTO `share_recipe_step` (`recipe_id`, `step1`, `step2`, `step3`, `step4`, `step5`, `step6`, `step7`, `step8`) VALUES
(1, '將機架調整到最高位置，然後將烤箱預熱至450度。洗滌並乾燥所有農產品。\r\n              將西葫蘆切成兩半；用勺子seeds出種子並丟棄。用細雨橄欖油將每半擦\r\n              乾淨；用一半的意大利調味料（稍後再使用），鹽和胡椒粉調味。將切面朝\r\n              下放在烤板上。•在頂部架子上烤15至20分鐘，直至變成褐色並變軟。', '西葫蘆烤時，將大蒜去皮切碎或切碎。將西紅柿切成細末。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', '', '', '');

-- --------------------------------------------------------

--
-- 資料表結構 `simplemealcoupon`
--

CREATE TABLE `simplemealcoupon` (
  `combination_sid` int(11) NOT NULL,
  `combination_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `coupon_num` int(11) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `simplemealcoupon`
--

INSERT INTO `simplemealcoupon` (`combination_sid`, `combination_name`, `description`, `coupon_num`, `price`) VALUES
(1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 25, 7000),
(2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 12, 1700),
(3, '經濟實惠組', '(包含5張餐卷, 加贈1張免費餐券)', 6, 850);

-- --------------------------------------------------------

--
-- 資料表結構 `surprisekitchen_order`
--

CREATE TABLE `surprisekitchen_order` (
  `sid` int(11) NOT NULL,
  `member_number` int(11) NOT NULL,
  `order_sid` int(11) NOT NULL,
  `reservation_date` date NOT NULL,
  `reservation_time` varchar(255) NOT NULL,
  `num_adult` int(11) NOT NULL,
  `num_child` int(11) NOT NULL,
  `adult_price` int(11) NOT NULL,
  `child_price` int(11) NOT NULL,
  `num_meal` int(11) NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `reservation_price` int(11) NOT NULL,
  `reservation_name` varchar(255) DEFAULT NULL,
  `reservation_tel` varchar(255) DEFAULT NULL,
  `reservation_email` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `check_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `surprisekitchen_order`
--

INSERT INTO `surprisekitchen_order` (`sid`, `member_number`, `order_sid`, `reservation_date`, `reservation_time`, `num_adult`, `num_child`, `adult_price`, `child_price`, `num_meal`, `remark`, `reservation_price`, `reservation_name`, `reservation_tel`, `reservation_email`, `payment_method`, `check_date`) VALUES
(1, 20210001, 843838714, '2021-02-19', '10:00', 1, 2, 500, 100, 2, '不要香菜 不要蔥 不要豬肉', 600, 'DD', 'DDD', 'DDDDD', '銀聯卡', '2021-02-09 12:10:38'),
(2, 20210001, 509572502, '2021-02-26', '14:00', 2, 1, 500, 100, 3, '不吃牛肉', 1100, NULL, NULL, NULL, NULL, '2021-02-05 11:31:32'),
(3, 20210001, 509572503, '2021-02-27', '18:00', 1, 2, 500, 100, 3, '素', 700, NULL, NULL, NULL, NULL, '2021-02-05 14:44:37');

-- --------------------------------------------------------

--
-- 資料表結構 `surprise_comment`
--

CREATE TABLE `surprise_comment` (
  `sid` int(11) NOT NULL,
  `member_number` int(11) NOT NULL,
  `nickname` varchar(255) NOT NULL,
  `used_date` date NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `builded_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `surprise_comment`
--

INSERT INTO `surprise_comment` (`sid`, `member_number`, `nickname`, `used_date`, `comment`, `builded_date`) VALUES
(1, 20210001, '小明', '2021-02-19', '場地很乾淨, 食材很新鮮', '2021-02-20'),
(2, 20210002, '小王', '2021-02-26', '很好玩', '2021-02-27');

-- --------------------------------------------------------

--
-- 資料表結構 `surprise_times`
--

CREATE TABLE `surprise_times` (
  `sid` int(11) NOT NULL,
  `reservation_time` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `surprise_times`
--

INSERT INTO `surprise_times` (`sid`, `reservation_time`) VALUES
(1, '10:00'),
(2, '14:00'),
(3, '18:00');

-- --------------------------------------------------------

--
-- 資料表結構 `test`
--

CREATE TABLE `test` (
  `id` int(11) NOT NULL,
  `string` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `test`
--

INSERT INTO `test` (`id`, `string`) VALUES
(1, '5566');

-- --------------------------------------------------------

--
-- 資料表結構 `trigger_describe`
--

CREATE TABLE `trigger_describe` (
  `trigger_ID` int(11) NOT NULL COMMENT '觸發的條件編號',
  `subs` varchar(255) NOT NULL COMMENT '觸發條件的資訊'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `trigger_describe`
--

INSERT INTO `trigger_describe` (`trigger_ID`, `subs`) VALUES
(1, '訂餐金額'),
(2, '訂餐次數'),
(3, '評論次數'),
(4, '登入次數');

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `cart_mealdelivery`
--
ALTER TABLE `cart_mealdelivery`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `cart_simplemealcoupon`
--
ALTER TABLE `cart_simplemealcoupon`
  ADD PRIMARY KEY (`order_sid`);

--
-- 資料表索引 `categories_1`
--
ALTER TABLE `categories_1`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `comment_get_good`
--
ALTER TABLE `comment_get_good`
  ADD PRIMARY KEY (`good_id`);

--
-- 資料表索引 `exchange_good`
--
ALTER TABLE `exchange_good`
  ADD PRIMARY KEY (`good_ID`);

--
-- 資料表索引 `history_mealdelivery`
--
ALTER TABLE `history_mealdelivery`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `meal`
--
ALTER TABLE `meal`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `membercenter`
--
ALTER TABLE `membercenter`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `milestone_manager`
--
ALTER TABLE `milestone_manager`
  ADD PRIMARY KEY (`milestone_sid`);

--
-- 資料表索引 `milestone_user`
--
ALTER TABLE `milestone_user`
  ADD UNIQUE KEY `addEvent` (`event_time`,`memner_number`) USING BTREE;

--
-- 資料表索引 `partner`
--
ALTER TABLE `partner`
  ADD PRIMARY KEY (`vender_id`);

--
-- 資料表索引 `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `recipe_comment`
--
ALTER TABLE `recipe_comment`
  ADD PRIMARY KEY (`comment_id`);

--
-- 資料表索引 `recipe_get_good`
--
ALTER TABLE `recipe_get_good`
  ADD PRIMARY KEY (`good_id`);

--
-- 資料表索引 `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- 資料表索引 `share_recipe`
--
ALTER TABLE `share_recipe`
  ADD PRIMARY KEY (`recipe_id`);

--
-- 資料表索引 `share_recipe_ingredients`
--
ALTER TABLE `share_recipe_ingredients`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `share_recipe_step`
--
ALTER TABLE `share_recipe_step`
  ADD PRIMARY KEY (`recipe_id`);

--
-- 資料表索引 `simplemealcoupon`
--
ALTER TABLE `simplemealcoupon`
  ADD PRIMARY KEY (`combination_sid`);

--
-- 資料表索引 `surprisekitchen_order`
--
ALTER TABLE `surprisekitchen_order`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `surprise_comment`
--
ALTER TABLE `surprise_comment`
  ADD PRIMARY KEY (`sid`);

--
-- 資料表索引 `surprise_times`
--
ALTER TABLE `surprise_times`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `reservation_time` (`reservation_time`);

--
-- 資料表索引 `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `trigger_describe`
--
ALTER TABLE `trigger_describe`
  ADD PRIMARY KEY (`trigger_ID`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `cart_mealdelivery`
--
ALTER TABLE `cart_mealdelivery`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `cart_simplemealcoupon`
--
ALTER TABLE `cart_simplemealcoupon`
  MODIFY `order_sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2021020402;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `categories_1`
--
ALTER TABLE `categories_1`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `comment_get_good`
--
ALTER TABLE `comment_get_good`
  MODIFY `good_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `exchange_good`
--
ALTER TABLE `exchange_good`
  MODIFY `good_ID` int(6) NOT NULL AUTO_INCREMENT COMMENT '優惠編號', AUTO_INCREMENT=9;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `history_mealdelivery`
--
ALTER TABLE `history_mealdelivery`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `meal`
--
ALTER TABLE `meal`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `membercenter`
--
ALTER TABLE `membercenter`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `milestone_manager`
--
ALTER TABLE `milestone_manager`
  MODIFY `milestone_sid` int(6) NOT NULL AUTO_INCREMENT COMMENT '成就編號', AUTO_INCREMENT=6;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `partner`
--
ALTER TABLE `partner`
  MODIFY `vender_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '廠商ID', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `recipe`
--
ALTER TABLE `recipe`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `recipe_comment`
--
ALTER TABLE `recipe_comment`
  MODIFY `comment_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '評論id', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `recipe_get_good`
--
ALTER TABLE `recipe_get_good`
  MODIFY `good_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `share_recipe`
--
ALTER TABLE `share_recipe`
  MODIFY `recipe_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '食譜id', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `share_recipe_ingredients`
--
ALTER TABLE `share_recipe_ingredients`
  MODIFY `sid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `share_recipe_step`
--
ALTER TABLE `share_recipe_step`
  MODIFY `recipe_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '食譜流水號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `simplemealcoupon`
--
ALTER TABLE `simplemealcoupon`
  MODIFY `combination_sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `trigger_describe`
--
ALTER TABLE `trigger_describe`
  MODIFY `trigger_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '觸發的條件編號', AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
