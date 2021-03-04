-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2021-03-04 13:23:19
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
  `product_id` varchar(255) NOT NULL,
  `meal_name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `next_time` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `cart_mealdelivery`
--

INSERT INTO `cart_mealdelivery` (`sid`, `member_sid`, `meal_sid`, `product_id`, `meal_name`, `description`, `quantity`, `next_time`) VALUES
(11, 1, 1, 'american01', '輕食鮮蔬沙拉麵', '美式沙拉和冷麵完美搭配', 1, 0);

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
(525558059, 6, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 4, 100, 14000, 'LINE PAY', '2021-02-28 23:19:18'),
(671217133, 3, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 10, 250, 35000, '銀聯卡', '2021-03-02 15:46:57'),
(755315209, 6, 3, '經濟實惠組', '(包含5張餐卷, 加贈1張免費餐券)', 7, 42, 5950, 'LINE PAY', '2021-03-03 15:08:35'),
(755621031, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 1, 12, 1700, '銀聯卡', '2021-02-02 15:13:41'),
(755634020, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 1, 12, 1700, 'LINE PAY', '2021-02-10 15:13:54'),
(755643652, 1, 2, '食在很滿足組合', '(包含10張餐卷, 加贈2張免費餐券)', 1, 12, 1700, '銀聯卡', '2021-02-28 16:32:33'),
(755661886, 1, 1, '吃飽飽沒煩惱組合', '(包含20張餐卷, 加贈5張免費餐券)', 1, 25, 3500, 'LINE PAY', '2021-03-01 16:32:40'),
(755673730, 1, 3, '經濟實惠組', '(包含5張餐卷, 加贈1張免費餐券)', 1, 6, 850, '銀聯卡', '2021-03-10 15:14:33');

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
-- 資料表結構 `coupon_exchange`
--

CREATE TABLE `coupon_exchange` (
  `exchange_sid` int(6) NOT NULL COMMENT '兌換商品編號',
  `spend_point` int(6) NOT NULL DEFAULT 0 COMMENT '花費的點數',
  `event_time` datetime NOT NULL COMMENT '兌換的觸發時間',
  `member_number` int(11) NOT NULL COMMENT '該會員的ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `coupon_exchange`
--

INSERT INTO `coupon_exchange` (`exchange_sid`, `spend_point`, `event_time`, `member_number`) VALUES
(3, 50, '2021-03-03 15:11:16', 6),
(5, 50, '2021-03-04 13:22:48', 6);

-- --------------------------------------------------------

--
-- 資料表結構 `coupon_user`
--

CREATE TABLE `coupon_user` (
  `exchange_sid` int(6) NOT NULL COMMENT '兌換商品編號',
  `good_type` int(2) NOT NULL COMMENT '1=站外2=站內',
  `event_time` datetime NOT NULL COMMENT '兌換的觸發時間',
  `member_number` int(11) NOT NULL COMMENT '該會員的ID',
  `discount` int(11) DEFAULT NULL,
  `discount_code` varchar(255) NOT NULL,
  `used_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `coupon_user`
--

INSERT INTO `coupon_user` (`exchange_sid`, `good_type`, `event_time`, `member_number`, `discount`, `discount_code`, `used_date`) VALUES
(1, 1, '2021-03-01 01:04:55', 6, NULL, 'code9689330', NULL),
(1, 1, '2021-03-01 01:05:08', 6, NULL, 'code2696538', NULL),
(1, 1, '2021-03-01 01:05:08', 6, NULL, 'code8559011', NULL),
(1, 1, '2021-03-01 01:05:08', 6, NULL, 'code3883079', NULL),
(3, 1, '2021-03-03 15:10:39', 6, NULL, 'code6462483', NULL),
(3, 1, '2021-03-03 15:10:39', 6, NULL, 'code7372118', NULL),
(3, 1, '2021-03-03 15:11:16', 6, NULL, 'code2675518', NULL),
(3, 1, '2021-03-03 15:11:20', 6, NULL, 'code4599', NULL),
(5, 2, '2021-03-04 13:22:48', 6, 50, 'code9911541', NULL);

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
(1, '2020-12-24 00:00:00', 2, 30),
(3, '2021-03-02 15:46:57', 1, 35000),
(5, '2021-03-03 13:44:53', 1, 600),
(5, '2021-03-03 13:44:53', 5, 1),
(5, '2021-03-03 13:58:02', 1, 1100),
(5, '2021-03-03 13:58:02', 5, 1),
(6, '2021-03-03 15:08:35', 1, 5950),
(1, '2021-03-03 15:13:41', 1, 1700),
(1, '2021-03-03 15:13:54', 1, 1700),
(1, '2021-03-03 15:14:03', 1, 1700),
(1, '2021-03-03 15:14:21', 1, 3500),
(1, '2021-03-03 15:14:33', 1, 850),
(1, '2021-03-03 15:14:55', 6, 1),
(1, '2021-03-03 15:15:38', 6, 1),
(1, '2021-03-03 15:15:38', 6, 1),
(1, '2021-03-03 15:16:57', 1, 1200),
(1, '2021-03-03 15:16:57', 5, 1),
(1, '2021-03-03 15:17:36', 1, 1200),
(1, '2021-03-03 15:17:36', 5, 1),
(1, '2021-03-03 15:18:24', 1, 1700),
(1, '2021-03-03 15:18:24', 5, 1),
(1, '2021-03-03 15:18:51', 7, 1),
(1, '2021-03-03 15:19:28', 6, 4),
(1, '2021-03-03 15:20:40', 1, 700),
(1, '2021-03-03 15:20:40', 5, 1);

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
  `good_pic` varchar(255) NOT NULL COMMENT '優惠顯示圖片',
  `good_discount` int(5) DEFAULT NULL COMMENT '折扣'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `exchange_good`
--

INSERT INTO `exchange_good` (`good_ID`, `good_type`, `good_name`, `good_subs`, `need_point`, `good_pic`, `good_discount`) VALUES
(1, 1, '星巴克買一送一', '憑QR CODE可以獲得同口味大小星巴克飲料買一送一，效期一個月。', 100, 'rw-001.png', NULL),
(2, 1, '7-11折價券50元', '憑QR CODE於7-11消費折扣50元，效期一個月。', 100, 'rw-002.png', NULL),
(3, 1, '全家咖啡買一送一', '憑QR CODE可以獲得同口味咖啡買一送一，效期一個月。', 50, 'rw-003.png', NULL),
(4, 1, '7-11折價券100元', '憑QR CODE於7-11消費折扣100元，效期一個月。', 200, 'rw-004.png', NULL),
(5, 2, '站內50元折價', '購買餐卷或是預約廚房時可兌換50元折價', 50, 'rw-005.png', 50),
(6, 2, '站內100元折價', '購買餐卷或是預約廚房時可兌換100元折價', 100, 'rw-006.png', 100),
(7, 2, '站內150元折價', '購買餐卷或是預約廚房時可兌換150元折價', 150, 'rw-007.png', 150),
(8, 2, '站內200元折價', '購買餐卷或是預約廚房時可兌換200元折價', 200, 'rw-008.png', 200),
(9, 3, '站內100元折價券', '快來按我啊, 我是Lemon, 我就囂張, 我睡', 0, '', 100);

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
  `check_date` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `history_mealdelivery`
--

INSERT INTO `history_mealdelivery` (`sid`, `member_sid`, `meal_sid`, `meal_name`, `quantity`, `member_name`, `mobile`, `address`, `delivery_date`, `delivery_time`, `check_date`, `status`) VALUES
(755695799, 1, '1', '奶香核桃烤蛋糕', '1', '王展宇', '0952376886', '台北市信義區仁愛路四段505號', '2021-02-03', '16:14:00', '2021-03-03 15:14:55', 1),
(755738578, 1, '2,3', '麻辣墨西哥捲餅,豬肉漢堡佐沙拉', '2,1', '王展宇', '0952376886', '台北市信義區仁愛路四段505號', '2021-02-18', '16:15:00', '2021-03-03 15:15:38', 1),
(755931632, 1, '4', '香煎嫩皮檸檬雞', '1', '王展宇', '0952376886', '台北市信義區仁愛路四段505號', '2021-02-19', '15:18:00', '2021-03-03 15:18:51', 0),
(755968462, 1, '3', '豬肉漢堡佐沙拉', '4', '王展宇', '0952376886', '台北市信義區仁愛路四段505號', '2021-03-01', '16:19:00', '2021-03-03 15:19:28', 0);

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
  `category_name` text NOT NULL,
  `ingredient_id` varchar(255) DEFAULT NULL,
  `recipe_id` varchar(255) DEFAULT NULL,
  `cooktime` varchar(255) CHARACTER SET utf8 NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `meal`
--

INSERT INTO `meal` (`sid`, `product_name`, `product_id`, `price`, `on_sale`, `vegetarian_food`, `introduction`, `category_id`, `category_name`, `ingredient_id`, `recipe_id`, `cooktime`, `created_at`) VALUES
(1, '輕食鮮蔬沙拉麵', 'american01', 500, 1, 1, '美式沙拉和冷麵完美搭配', '1', '美式料理', '1,2,3,4,5,6,7,8,9,10', '1', '40分鐘', '2020-12-16 00:00:00'),
(2, '麻辣墨西哥捲餅', 'american02', 450, 1, 0, '墨西哥風味的鮮牛肉捲餅', '1', '美式料理', '1,9,2,10,16,11,12,13,14,3,8,16', '2', '50分鐘', '2020-12-16 00:00:00'),
(3, '豬肉漢堡佐沙拉', 'american03', 600, 1, 0, '現烤漢堡並夾上手做豬肉', '1', '美式料理', '17,18,2,19,16,20,21,22,5,3\r\n', '3', '45分鐘', '2020-12-16 00:00:00'),
(4, '香煎嫩皮檸檬雞', 'china01', 400, 1, 0, '永遠不敗的經典鮮煎嫩雞', '2', '中式料理', '23,24,25,19,16,26,13,12,27,28,29,30', '4', '40分鐘', '2020-12-18 09:22:00'),
(5, '中式脆皮豬肉飯', 'china02', 450, 1, 0, '脆皮豬肉搭上優質池上米', '2', '中式料理', '25,31,27,19,32,33,34,16,11,20,13,12', '5', '45分鐘', '2020-12-18 11:08:25'),
(6, '鮮鱸魚醬油炒麵', 'china03', 500, 1, 0, '新鮮鱸魚和炒麵完美搭配', '2', '中式料理', '25,31,27,19,33,35,36,11,37,38,28,13', '6', '35分鐘', '2020-12-18 11:16:39'),
(7, '奶油烤餅佐蘆筍', 'french01', 300, 1, 1, '手作烤餅並配上新鮮蘆筍', '3', '法式料理', '23,39,40,41,42,5,3,43', '7', '50分鐘', '2020-12-18 11:21:03'),
(8, '鮮檬烤魚佐菠菜', 'french02', 350, 1, 0, '無刺鮮魚搭配上奶油菠菜', '3', '法式料理', '23,10,44,41,5', '8', '50分鐘', '2020-12-18 11:23:54'),
(9, '奶油蘑菇舒肥雞', 'french03', 300, 1, 0, '蘿蔔嫩雞與奶油的交響曲', '3', '法式料理', '27,45,46,17,5,29', '9', '30分鐘', '2020-12-18 11:23:54'),
(10, '羅勒鮮蔬通心麵', 'italy01', 300, 1, 1, '經典不朽的青醬義大利麵', '4', '義式料理', '47,25,48,10,43,49', '10', '30分鐘', '2020-12-18 11:30:02'),
(11, '起司香腸烤比薩', 'italy02', 350, 1, 0, '香腸比薩融合起司的搭配', '4', '義式料理', '18,25,16,50,51,52,53,54,35', '11', '45分鐘', '2020-12-18 11:32:51'),
(12, '蒜味蝦義大利麵', 'italy03', 400, 1, 0, '蒜香口感帶給你無窮回味', '4', '義式料理', '23,24,25,19,55,56,49', '12', '35分鐘', '2020-12-18 11:32:51'),
(26, '起司肉醬通心麵', 'hero01', 500, 1, 0, '起司搭配肉醬的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '1', '40分鐘', '2020-12-21 11:58:54'),
(27, '青醬蔬菜通心麵', 'hero02', 101000, 1, 1, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,39,40,41,42,5,3,43', '1', '40分鐘', '2020-12-21 14:23:41'),
(28, '培根青花通心麵', 'hero03', 101000, 1, 0, '青花配上培根的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '1', '40分鐘', '2020-12-21 14:23:50'),
(29, '鮮蔬彩椒焗烤飯', 'hero04', 101000, 1, 1, '彩椒配上各式鮮蔬的燉飯', '3', '義式料理', '23,39,40,41,42,5,3,43', '1', '40分鐘', '2020-12-22 14:22:12'),
(30, '青醬蔬菜通心麵', 'hero02', 101000, 1, 1, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,39,40,41,42,5,3,43', '1', '40分鐘', '2020-12-22 15:03:18'),
(31, '青醬蔬菜通心麵', 'hero02', 101000, 1, 1, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,39,40,41,42,5,3,43', '11', '40分鐘', '2020-12-22 15:12:34'),
(32, '青醬蔬菜通心麵', 'hero02', 101000, 1, 1, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,39,40,41,42,5,3,43', '1', '40分鐘', '2020-12-22 17:20:27'),
(33, '青醬蔬菜通心麵', 'hero02', 121, 1, 1, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,39,40,41,42,5,3,43', '1', '40分鐘', '2020-12-22 17:22:48'),
(34, '青醬蔬菜通心麵', 'hero02', 101000, 1, 0, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '1', '40分鐘', '2020-12-22 18:15:21'),
(35, '青醬蔬菜通心麵', 'hero02', 1313131, 1, 0, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '8', '40分鐘', '2020-12-22 18:18:46'),
(36, '青醬蔬菜通心麵', 'hero02', 1313131, 1, 0, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '8', '40分鐘', '2020-12-22 18:19:58'),
(37, '青醬蔬菜通心麵', 'hero02', 11111, 1, 0, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '1', '40分鐘', '2020-12-22 18:21:36'),
(38, '青醬蔬菜通心麵', 'hero02', 11111, 1, 0, '有羅勒香和奶香的一頓餐點', '4', '義式料理', '23,24,25,19,55,56,49', '1', '40分鐘', '2020-12-22 18:29:40');

-- --------------------------------------------------------

--
-- 資料表結構 `membercenter`
--

CREATE TABLE `membercenter` (
  `id` int(100) NOT NULL,
  `member_number` varchar(255) DEFAULT NULL,
  `avater` varchar(255) DEFAULT 'lemonBasket.PNG',
  `level` varchar(30) DEFAULT 'VIP',
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `password1` varchar(255) DEFAULT NULL,
  `name` varchar(10) DEFAULT NULL,
  `nickname` varchar(10) DEFAULT NULL,
  `mobile` varchar(10) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `credit＿card` varchar(255) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `love` varchar(255) DEFAULT NULL,
  `simplemeal_coupon` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `membercenter`
--

INSERT INTO `membercenter` (`id`, `member_number`, `avater`, `level`, `email`, `password`, `password1`, `name`, `nickname`, `mobile`, `birthday`, `credit＿card`, `addr`, `love`, `simplemeal_coupon`) VALUES
(1, '20210001', 'avatar01.jpg', 'VIP', 'GoodGoodEat@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', '王展宇', '12344', '0952376886', '1910-01-19', '1234-1234-1234', '台北市信義區仁愛路四段505號', '1,2,3', 1058),
(2, '20210002', 'lemonBasket.png', '一般會員', 'FoodEat@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', 'Lemon', 'yellow', '0911111111', '2021-02-19', '1234-1234-1234-1234', '台北市信義區仁愛路四段505號', NULL, 0),
(3, '20210003', 'kirby.jpg', '一般會員', 'tomato@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', 'Tomato', 'orange', '0912345678', '2021-03-05', '1234-1234-1234-1234', '台北市信義區光復南路133號', NULL, 250),
(4, '20210004', 'yoshi.jpg', 'VIP', 'bacon@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', 'Bacon', 'red', '0978965842', '2021-01-01', '1234-1234-1234-1234', '台北市中正區仁愛路二段108號', NULL, 0),
(5, '20210005', 'gremlins.jpg', '一般會員', 'cheese@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', 'Cheese', 'stench', '0965423685', '2021-01-21', '1234-1234-1234-1234\r\n', '台北市中山區八德路二段306號', NULL, 0),
(6, '20210006', 'koopa.jpg', 'VIP', 'pork@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', '', 'Pork', 'pig', '0975888426', '2021-01-30', '1234-1234-1234-1234', '台北市中山區松江路199號', '7,8,9', 2),
(17, '20210007', 'pikachu.jpg', 'VIP', 'pikachu@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'Pikachu', 'pipi', '0945896654', '2020-09-16', '1234-1234-1234-1234', '桃園市楊梅區楊湖路二段327巷9號', NULL, 0),
(18, '20210008', 'umbreon.jpg', 'VIP', 'umbreon@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'Umbreon', 'uu', '0975554589', '2019-09-26', '1234-1234-1234-1234', '桃園市楊梅區楊湖路一段367巷15-1號', NULL, 0),
(19, '20210009', 'slowpoke.jpg', 'VIP', 'slowpoke@gmail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, 'Slowpoke', 'slow', '0988874563', '2019-04-10', '1234-1234-1234-1234', '桃園市中壢區民族路六段508號', NULL, 0);

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
(1, '累積消費一萬元', '2021-01-01 00:00:00', NULL, 1, 10000, 400, '累積消費一萬元可得400點', 'ms-001-unfinish.png', 'ms-001-finish.png'),
(2, '累積消費十萬元', '2021-01-01 00:00:00', NULL, 1, 100000, 1000, '累積消費十萬元可得1000點', 'ms-003-unfinish.png', 'ms-003-finish.png'),
(3, '累積消費五萬元', '2021-01-01 00:00:00', NULL, 1, 50000, 5000, '累積消費5萬元可得5000點', 'ms-002-unfinish.png', 'ms-002-finish.png'),
(4, '第一筆評論', '2021-01-01 00:00:00', NULL, 3, 1, 50, '第一次對餐點評分可得50點', 'ms-004-unfinish.png', 'ms-004-finish.png'),
(5, '我是評論家', '2021-01-01 00:00:00', NULL, 3, 10, 200, '累積發表十篇心得可得200點', 'ms-005-unfinish.png', 'ms-005-finish.png'),
(6, '累積消費五千元', '2021-01-01 00:00:00', NULL, 1, 5000, 100, '累積消費滿五千元，可獲得100點獎勵點數', 'ms-006-unfinish.png', 'ms-006-finish.png'),
(7, '初學小廚師', '2021-01-01 00:00:00', NULL, 5, 1, 100, '第一次參加驚喜廚房', 'ms-007-unfinish.png', 'ms-007-finish.png'),
(8, '熟能生巧', '2021-01-01 00:00:00', NULL, 5, 5, 200, '成功預約五次驚喜廚房', 'ms-008-unfinish.png', 'ms-008-finish.png'),
(9, '二月吃美式', '2021-01-01 00:00:00', '2021-01-31 23:59:59', 6, 1, 100, '於二月點購任何一道美式食譜', 'ms-009-unfinish.png', 'ms-009-finish.png'),
(10, '三月吃中式', '2021-03-01 00:00:00', '2021-03-31 23:59:59', 7, 1, 100, '於三月點購任何一道中式食譜', 'ms-010-unfinish.png', 'ms-010-finish.png'),
(11, '四月吃義式', '2021-04-01 00:00:00', '2021-04-30 23:59:59', 8, 1, 100, '於四月點購任何一道義式食譜', 'ms-011-unfinish.png', 'ms-011-finish.png');

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
(12, '簡單的大蝦，大蒜和辣椒扁麵條', 'italy03_01', '先燒一鍋熱水準備煮麵，將備好的大蒜剝皮並切碎，並準備青蔥切成蔥花，將辣椒仔去除後切成辣椒丁備用。', 'italy03_02', '將義大利麵放入燒開的熱鍋內，並加入半匙鹽巴提味。將義大利麵持續煮沸約8-10分(依麵條口感喜好)後即可起鍋濾乾，並保留一杯的煮剩的澱粉水。', 'italy03_03', '將第一步備好的蔥花、大蒜以及辣椒丁混再一起，持續切成更小的碎末，進一步提升義大利麵的風味。', 'italy03_04', '把之前煮軟的義大利麵加入三匙的橄欖油，放入鍋中並和蒜末蔥花一起亨煮約2分鐘，再加入備好的鮮蝦持續煮至4分鐘。\r\n', 'italy03_05', '在亨煮意麵期間，可將新鮮香菜切碎並備好一顆對切檸檬。', 'italy03_06', '把煮熟的義大利麵麵條加少許澱粉麵食水倒入鍋中，並將備好的半顆檸檬榨汁加到麵中，攪拌均勻。', 'italy03_07', '熄火後將義大利麵倒入餐盤中，並將另外半顆檸檬放入菜餐盤旁裝飾，一道美味的蒜味鮮蝦義大利麵完成!');

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

--
-- 傾印資料表的資料 `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('EIgWwhcntQihF9Y5XkYqOZ_oWQK6Wj7a', 1614769083, '{\"cookie\":{\"originalMaxAge\":18000000,\"expires\":\"2021-03-03T10:57:25.947Z\",\"httpOnly\":true,\"path\":\"/\"},\"admin\":{\"id\":5,\"member_number\":\"20210005\",\"avater\":\"gremlins.jpg\",\"level\":\"一般會員\",\"email\":\"cheese@gmail.com\",\"password\":\"7c4a8d09ca3762af61e59520943dc26494f8941b\",\"password1\":\"\",\"name\":\"Cheese\",\"nickname\":\"stench\",\"mobile\":\"0965423685\",\"birthday\":\"2021-01-20T16:00:00.000Z\",\"credit＿card\":\"1234-1234-1234-1234\\r\\n\",\"addr\":\"台北市中山區八德路二段306號\",\"love\":null,\"simplemeal_coupon\":0}}'),
('uwmogISyrB-lswE710VSLujecMegmhod', 1614853379, '{\"cookie\":{\"originalMaxAge\":18000000,\"expires\":\"2021-03-04T10:22:14.908Z\",\"httpOnly\":true,\"path\":\"/\"},\"admin\":{\"id\":6,\"member_number\":\"20210006\",\"avater\":\"koopa.jpg\",\"level\":\"VIP\",\"email\":\"pork@gmail.com\",\"password\":\"7c4a8d09ca3762af61e59520943dc26494f8941b\",\"password1\":\"\",\"name\":\"Pork\",\"nickname\":\"pig\",\"mobile\":\"0975888426\",\"birthday\":\"2021-01-29T16:00:00.000Z\",\"credit＿card\":\"1234-1234-1234-1234\",\"addr\":\"台北市中山區松江路199號\",\"love\":\"7,8,9\",\"simplemeal_coupon\":2}}'),
('vi12RJl1El2JTK0IDaiBEG2Wvi7FJGAa', 1614780912, '{\"cookie\":{\"originalMaxAge\":18000000,\"expires\":\"2021-03-03T12:23:29.578Z\",\"httpOnly\":true,\"path\":\"/\"},\"admin\":{\"id\":1,\"member_number\":\"20210001\",\"avater\":\"avatar01.jpg\",\"level\":\"VIP\",\"email\":\"GoodGoodEat@gmail.com\",\"password\":\"7c4a8d09ca3762af61e59520943dc26494f8941b\",\"password1\":\"\",\"name\":\"王展宇\",\"nickname\":\"12344\",\"mobile\":\"0952376886\",\"birthday\":\"1910-01-18T16:00:00.000Z\",\"credit＿card\":\"1234-1234-1234\",\"addr\":\"台北市信義區仁愛路四段505號\",\"love\":\"1,2,3\",\"simplemeal_coupon\":1058}}');

-- --------------------------------------------------------

--
-- 資料表結構 `share_recipe`
--

CREATE TABLE `share_recipe` (
  `id` int(10) NOT NULL COMMENT '食譜id',
  `createtime` datetime NOT NULL COMMENT '建立時間',
  `name` varchar(30) NOT NULL COMMENT '食譜名稱',
  `creator` int(10) NOT NULL COMMENT '創造者id',
  `cooktime` int(3) NOT NULL COMMENT '烹飪時間',
  `style` varchar(25) NOT NULL COMMENT '風格',
  `introduction` text NOT NULL COMMENT '簡介',
  `pic` text NOT NULL COMMENT '成品照',
  `step1` text DEFAULT NULL COMMENT '步驟1',
  `step2` text DEFAULT NULL COMMENT '步驟2',
  `step3` text DEFAULT NULL COMMENT '步驟3',
  `step4` text DEFAULT NULL COMMENT '步驟4',
  `step5` text DEFAULT NULL COMMENT '步驟5',
  `step6` text DEFAULT NULL COMMENT '步驟6',
  `step7` text CHARACTER SET utf8 DEFAULT NULL COMMENT '步驟7',
  `step8` text DEFAULT NULL COMMENT '步驟8'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `share_recipe`
--

INSERT INTO `share_recipe` (`id`, `createtime`, `name`, `creator`, `cooktime`, `style`, `introduction`, `pic`, `step1`, `step2`, `step3`, `step4`, `step5`, `step6`, `step7`, `step8`) VALUES
(2, '2021-02-23 00:14:29', '櫻桃香脂豬肉', 1, 40, '美式風格', '兩側保持簡單，配以烤西蘭花和土豆，可讓泛煎豬里脊肉發光。和男孩，它偷了節目。', 'http://localhost:3015/img/sharerecipe/1.jpg', '將機架調整到最高位置，然後將烤箱預熱至450度。洗滌並乾燥所有農產品。\r\n', '西葫蘆烤時，將大蒜去皮切碎或切碎。將西紅柿切成細末。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', '在中鍋中以中高溫加熱細雨橄欖油。加入蒸粗麥粉，大蒜，一半的西紅柿和剩餘的意大利調味料。煮一會兒，攪拌至香1-2分鐘。•添加濃湯，¾杯水（1.5杯，可4份）和一大撮鹽。放慢火鍋，然後蓋上鍋蓋，並將熱量降低至較低水平。煮至蒸粗麥粉蒸6-8分鐘。•關閉熱量。如有必要，從鍋中排出多餘的液體。', NULL, NULL, NULL),
(3, '2021-02-10 00:14:45', '照燒雞肉招標', 4, 60, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/2.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, '2021-02-22 00:15:36', '咸焦糖馬斯卡彭芝士蛋糕\r\n', 1, 80, '美式風格', '用傳統的牛肉換成豬肉，用鮮味包裝的海鮮醬給肉餅上釉', 'http://localhost:3015/img/sharerecipe/3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, '2021-02-24 00:16:01', '牛油蝦卷', 4, 25, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/4.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, '2021-02-13 00:16:04', '菠蘿波布拉諾牛肉玉米餅', 1, 40, '美式風格', '酥脆的塗層。在側面，有脆脆的蘆筍，烤麵包杏仁和奶油土豆泥。不管您為誰做飯，我們都有一個很好的感覺，他們會被迷住。', 'http://localhost:3015/img/sharerecipe/5.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, '2021-02-02 00:15:41', '芝麻牛肉玉米餅\r\n', 3, 40, '美式風格', '無花果果醬。在這裡，將甜食與香醋配對，製成濃郁而濃郁的泛醬，以淋上多汁的沙朗牛排', 'http://localhost:3015/img/sharerecipe/6.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, '2021-02-01 00:16:31', '泰式豬肉丸\r\n', 4, 25, '美式風格', '鍋裡烤的胡椒脆皮牛排上撒上細細斑點的黃油醬（提示勺子）。但這不僅是胡椒粉，也不是牛排：在這裡，新鮮開裂的三色胡椒粉為口中融化的牛里脊肉提供了辛辣', 'http://localhost:3015/img/sharerecipe/7.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, '2021-02-23 00:15:54', '雞蛋香腸麵包', 1, 40, '美式風格', '很濃郁，全能美味，這要歸功於我們上一次做菜時我們的快樂廚師絕對喜歡的果醬，可口，粘到湯​​匙厚的櫻桃香脂釉這個食譜', 'http://localhost:3015/img/sharerecipe/8.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, '2021-01-19 00:15:56', '蘋果荷蘭嬰兒煎餅\r\n', 1, 35, '美式風格', '一個好的辣椒包括調味好的牛肉，奶油豆和嫩蔬菜。', 'http://localhost:3015/img/sharerecipe/9.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, '2021-02-06 00:15:50', '衝浪的雞肉和飯碗\r\n', 3, 40, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/10.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, '2021-01-05 00:15:45', '脆皮切達干酪雞\r\n', 2, 35, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/11.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, '2021-02-06 00:16:27', '雞肉香腸，菠菜和鷹嘴豆湯\r\n', 1, 70, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/12.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, '2021-02-25 00:16:25', '山核桃殼雞\r\n', 2, 65, '美式風格', '一瓶很棒的辣椒就可以將所有的辣椒一起放入一個鍋中，並在不到一個小時的時間內融合在一起', 'http://localhost:3015/img/sharerecipe/13.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, '2021-02-15 00:16:22', '意大利恰巴塔芝士漢堡\r\n', 1, 90, '美式風格', '在上面撒上濃郁的黃瓜-胡蘿蔔色拉和斯拉拉查蛋黃醬。一切都夾在糊狀的土豆麵包之間，做成一個非常美味的漢堡', 'http://localhost:3015/img/sharerecipe/14.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, '2021-02-02 00:16:19', '帕瑪森麵食\r\n', 4, 40, '美式風格', '進入炸玉米粉圓餅，將其製成扁平的玉米餅，將其烘烤至酥脆', 'http://localhost:3015/img/sharerecipe/15.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, '2021-02-10 00:16:17', '芝麻蝦\r\n', 1, 60, '美式風格', '這辣椒是很棒的之一。一口咬一口，我們可以保證您會同意', 'http://localhost:3015/img/sharerecipe/16.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, '2021-02-28 00:16:14', '遊戲日牛肉辣椒\r\n', 4, 50, '美式風格', '在其上堆積大量表面積。值得慶幸的是，此食譜中有很多澆頭，不僅有熱辣的碎牛肉，還有青椒，番茄莎莎醬和辛辣的酸奶油。', 'http://localhost:3015/img/sharerecipe/17.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, '2021-02-17 00:16:11', '櫻桃香脂豬肉\r\n', 1, 50, '美式風格', '這些強壯的碗上裝飾有一些美味的食物：濃郁的辣醬克麗瑪和熔化的蒙特利傑克。如果手頭有一些，為什麼不把一些玉米粉圓餅弄碎然後撒在上面緊縮', 'http://localhost:3015/img/sharerecipe/18.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, '2021-02-02 00:16:36', '優勝者雞肉Orzo晚餐', 1, 30, '美式風格', '儘管此食譜的西葫蘆和番茄混合菜是一面，但它在我們眼中佔據著中心位置。它既奶油又脆，就像奶油一樣，在上面撒上Panko，芝士和帕爾馬干酪的組合，對此深表感謝。這頓飯與保持雞胸肉和檸檬味的佐料一起食用，使食物簡單而又令人滿意，使它保持清淡而不失風味。', 'http://localhost:4000/img/aa3179bc-c9cd-48ac-8267-850cb2d0dfbe.jpg', '洗滌並乾燥所有農產品。將機架調整到較高位置，然後將烤箱預熱到425度。將一大鍋鹽水燒開。將西葫蘆切成1/4英寸厚的圓形。將番茄切成½英寸厚的楔子。將西葫蘆和番茄與1 TBSP橄欖油和一半的意大利調味料一起放在烤盤上。用鹽和胡椒粉調味。', '在烤箱中烤西葫蘆和番茄，直到嫩滑，約10分鐘。水沸騰後，從包裝中往鍋中加入一半的Orzo（根據需要使用其餘的）。煮，不時攪拌，直到9-11分鐘為止。瀝乾水分，然後返回鍋中。', '將您的手放在一隻雞胸脯上，從中間切入¾，平行於切菜板，在完全切開之前停下來。重複其他雞胸肉。打開每個容器，然後用鹽，胡椒粉和其他意大利調味料調味。', '在大鍋中以中高溫加熱細雨橄欖油。加入雞肉並煮至中心不再變粉紅色，每側3-4分鐘。從鍋中取出並放在盤子上。同時，將奶酪切成½英寸的立方體。將檸檬減半。將歐芹切碎。', '蔬菜烤10分鐘後，從烤箱中取出烤盤。將肉雞加熱至較高溫度或將烤箱溫度提高至500度。在蔬菜上撒上Panko，芝士和巴馬干酪。烤（或烘烤）3-5分鐘，直到薄餅變成金棕色，奶酪融化並且蔬菜變軟。', NULL, NULL, NULL),
(21, '2021-02-17 00:16:08', '豬肉照燒肉丸\r\n', 2, 40, '美式風格', '沒有什麼組合比香腸和辣椒更令人滿意了。畢竟，在胃液中甜美的焦糖味和肉中的超鹹味，還有什麼比這更令人放鬆呢？', 'http://localhost:3015/img/sharerecipe/20.jpg', '將架子調整到頂部和中間位置，然後將烤箱預熱到425度。洗滌並乾燥所有農產品。縱向將土豆切成兩半。從莖上剝去迷迭香葉', '在烤盤上，將土豆撒上少許橄欖油，一小撮切碎的迷迭香，胡椒粉和幾小撮鹽。在頂部架子上烤20至25分鐘', '在第二塊烤盤上，將青豆和大蒜與細雨橄欖油，鹽和胡椒粉一起拌勻。土豆烘烤10分鐘後，將青豆放在中間的架子上', NULL, NULL, NULL, NULL, NULL),
(27, '0000-00-00 00:00:00', '燒烤奶酪烤麵包', 1, 20, '', '你知道你可以烤奶酪嗎？而且，不，我們不是指熔化的晚餐三明治，而是在直接將一大塊奶酪直接加熱，以使外部變得焦炭精美，而內部變得溫暖而柔軟。如果您還沒有聚會', 'http://localhost:4000/img/f08e144f-d5f1-45ec-94df-6970d35570ad.jpg', '將機架調整到最高位置，然後將烤箱預熱到425度。洗滌並乾燥所有農產品。•將土豆切成½英寸厚的楔子。將洋蔥切成一半，去皮，切成薄片；切碎幾片，直到有1茶匙（2茶匙4份）。將大蒜切碎。切碎的香菜。將墨西哥胡椒切成丁，去掉肋骨和種子，以減少熱量。熱情和四分之一石灰。', '將土豆撒在烤盤上，上面撒上大量的油，西南香料的一半（稍後再用），鹽和胡椒粉。•在頂部架子上烤至20-25分鐘，直至變成褐色和酥脆。', '烤土豆時，在中火（最好是不粘鍋）中加熱大量細雨油，然後用中火加熱。加入切成薄片的洋蔥；煮，不時攪拌，直到變黃變軟8-10分鐘。•加入1茶匙糖（2茶匙4份）和少量水；煮至焦糖，再煮2-3分鐘。用鹽和胡椒粉調味。關火。', '同時，在一個小碗中，將酸奶油，香菜，蔥末，石灰皮，¼茶匙大蒜，2個酸橙楔子榨汁（4楔子汁4份裝），少許墨西哥胡椒，少許小茴香，1 TBSP橄欖油（2 TBSP用於4），鹽和胡椒粉。•將麵包減半；在烤箱中烤至金黃，持續3-5分鐘。提示：直接放在烤箱架上，或使用第二個烤盤。', '', NULL, NULL, NULL);

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
  `check_date` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `surprisekitchen_order`
--

INSERT INTO `surprisekitchen_order` (`sid`, `member_number`, `order_sid`, `reservation_date`, `reservation_time`, `num_adult`, `num_child`, `adult_price`, `child_price`, `num_meal`, `remark`, `reservation_price`, `reservation_name`, `reservation_tel`, `reservation_email`, `payment_method`, `check_date`, `status`) VALUES
(26, 20210003, 418095413, '2021-03-14', '14:00', 2, 1, 500, 100, 1, '素食主義', 1100, 'Tomato', '0912345678', 'tomato@gmail.com', '信用卡線上刷卡一次付清', '2021-02-27 17:28:15', 0),
(27, 20210003, 418147314, '2021-03-16', '10:00', 2, 1, 500, 100, 3, '沒有', 1100, 'Tomato', '0912345678', 'tomato@gmail.com', '信用卡線上刷卡一次付清', '2021-02-27 17:29:07', 0),
(28, 20210003, 418183276, '2021-03-15', '14:00', 3, 0, 500, 100, 3, '', 1500, 'Tomato', '0912345678', 'tomato@gmail.com', '銀聯卡', '2021-02-27 17:29:43', 0),
(29, 20210003, 418224275, '2021-03-25', '18:00', 4, 0, 500, 100, 2, '', 2000, 'Tomato', '0912345678', 'tomato@gmail.com', 'LINE PAY', '2021-02-27 17:30:24', 0),
(30, 20210003, 418250862, '2021-03-25', '14:00', 2, 0, 500, 100, 3, '', 1000, 'Tomato', '0912345678', 'tomato@gmail.com', '銀聯卡', '2021-02-27 17:30:50', 0),
(31, 20210005, 750293904, '2021-03-01', '14:00', 1, 1, 500, 100, 2, '', 600, 'Cheese', '0965423685', 'cheese@gmail.com', '銀聯卡', '2021-03-03 13:44:53', 1),
(32, 20210005, 751082364, '2021-02-28', '14:00', 2, 1, 500, 100, 1, '需要兒童餐具', 1100, 'Cheese', '0965423685', 'cheese@gmail.com', 'LINE PAY', '2021-03-03 13:58:02', 1),
(34, 20210001, 755817279, '2021-02-11', '14:00', 2, 2, 500, 100, 0, '', 1200, '王展宇', '0952376886', 'GoodGoodEat@gmail.com', '銀聯卡', '2021-03-03 15:16:57', 1),
(35, 20210001, 755856061, '2021-02-17', '10:00', 2, 2, 500, 100, 3, '', 1200, '王展宇', '0952376886', 'GoodGoodEat@gmail.com', '銀聯卡', '2021-03-03 15:17:36', 1),
(36, 20210001, 755904699, '2021-03-03', '14:00', 3, 2, 500, 100, 0, '', 1700, '王展宇', '0952376886', 'GoodGoodEat@gmail.com', '銀聯卡', '2021-03-03 15:18:24', 0),
(37, 20210001, 756040525, '2021-03-11', '10:00', 1, 2, 500, 100, 2, '', 700, '王展宇', '0952376886', 'GoodGoodEat@gmail.com', '銀聯卡', '2021-03-03 15:20:40', 0);

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
(1, 20210001, 'lemonBasket', '2021-02-19', '場地很乾淨, 食材很新鮮', '2021-02-20'),
(2, 20210002, 'yoshi', '2021-02-26', '很好玩', '2021-02-27'),
(36, 20210001, 'pikachu', '2021-02-21', '本來就超期待要來體驗, 體驗之後非常滿意', '2021-02-28'),
(37, 20210003, 'Qoo', '2021-02-21', 'hihihi', '2021-03-02');

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
  `subs` varchar(255) NOT NULL COMMENT '觸發條件的資訊',
  `unit` varchar(6) NOT NULL COMMENT '單位'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 傾印資料表的資料 `trigger_describe`
--

INSERT INTO `trigger_describe` (`trigger_ID`, `subs`, `unit`) VALUES
(1, '消費金額', '元'),
(2, '訂餐次數', '次'),
(3, '評論次數', '次'),
(4, '抓到咧孟', '次'),
(5, '預約驚喜廚房', '次'),
(6, '嘗試美式料理', '次'),
(7, '嘗試中式料理', '次'),
(8, '嘗試義式料理', '次');

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
-- 資料表索引 `coupon_exchange`
--
ALTER TABLE `coupon_exchange`
  ADD UNIQUE KEY `addEvent` (`event_time`,`member_number`) USING BTREE;

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
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `share_recipe_ingredients`
--
ALTER TABLE `share_recipe_ingredients`
  ADD PRIMARY KEY (`sid`);

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
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
  MODIFY `good_ID` int(6) NOT NULL AUTO_INCREMENT COMMENT '優惠編號', AUTO_INCREMENT=10;

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
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `milestone_manager`
--
ALTER TABLE `milestone_manager`
  MODIFY `milestone_sid` int(6) NOT NULL AUTO_INCREMENT COMMENT '成就編號', AUTO_INCREMENT=12;

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
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '食譜id', AUTO_INCREMENT=28;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `share_recipe_ingredients`
--
ALTER TABLE `share_recipe_ingredients`
  MODIFY `sid` int(10) NOT NULL AUTO_INCREMENT COMMENT '流水號', AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `simplemealcoupon`
--
ALTER TABLE `simplemealcoupon`
  MODIFY `combination_sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `surprisekitchen_order`
--
ALTER TABLE `surprisekitchen_order`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `surprise_comment`
--
ALTER TABLE `surprise_comment`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `test`
--
ALTER TABLE `test`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `trigger_describe`
--
ALTER TABLE `trigger_describe`
  MODIFY `trigger_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '觸發的條件編號', AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
