/*
Navicat MariaDB Data Transfer

Source Server         : xlocal.serverdev
Source Server Version : 100309
Source Host           : 127.0.0.1:3307
Source Database       : db_adipos

Target Server Type    : MariaDB
Target Server Version : 100309
File Encoding         : 65001

Date: 2020-09-30 10:11:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_categories
-- ----------------------------
DROP TABLE IF EXISTS `tbl_categories`;
CREATE TABLE `tbl_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(100) DEFAULT 'no_image.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_categories
-- ----------------------------
INSERT INTO `tbl_categories` VALUES ('1', 'AL1', 'Alkes', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('2', 'BA1', 'Bahan', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('3', 'LA1', 'Lain-Lain', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('4', 'MA1', 'Makanan', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('5', 'MN1', 'Minuman', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('6', 'PR1', 'Perabot', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('7', 'PR2', 'Permen', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('8', 'SA1', 'Sabun', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('9', 'SH1', 'Shampoo', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('10', 'SN1', 'Snack', 'no_image.png');
INSERT INTO `tbl_categories` VALUES ('11', 'SS1', 'Siap Saji', 'no_image.png');

-- ----------------------------
-- Table structure for tbl_combo_items
-- ----------------------------
DROP TABLE IF EXISTS `tbl_combo_items`;
CREATE TABLE `tbl_combo_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `item_code` varchar(20) NOT NULL,
  `quantity` decimal(12,4) NOT NULL,
  `price` decimal(25,2) DEFAULT NULL,
  `cost` decimal(25,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_combo_items
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_customers
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customers`;
CREATE TABLE `tbl_customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `nama_pengirim` varchar(255) NOT NULL,
  `no_pengirim` varchar(25) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  `kurir` varchar(200) DEFAULT NULL,
  `layanan` varchar(200) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customers
-- ----------------------------
INSERT INTO `tbl_customers` VALUES ('1', 'default konsumen', 'GL GROSIR', '08123456789', '', 'jakarta', null, null, null);

-- ----------------------------
-- Table structure for tbl_expenses
-- ----------------------------
DROP TABLE IF EXISTS `tbl_expenses`;
CREATE TABLE `tbl_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `reference` varchar(50) NOT NULL,
  `amount` decimal(25,2) NOT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `created_by` varchar(55) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_expenses
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_gift_cards
-- ----------------------------
DROP TABLE IF EXISTS `tbl_gift_cards`;
CREATE TABLE `tbl_gift_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `card_no` varchar(20) NOT NULL,
  `value` decimal(25,2) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `balance` decimal(25,2) NOT NULL,
  `expiry` date DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `card_no` (`card_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_gift_cards
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_groups
-- ----------------------------
DROP TABLE IF EXISTS `tbl_groups`;
CREATE TABLE `tbl_groups` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_groups
-- ----------------------------
INSERT INTO `tbl_groups` VALUES ('1', 'admin', 'Administrator');
INSERT INTO `tbl_groups` VALUES ('2', 'staff', 'Staff');

-- ----------------------------
-- Table structure for tbl_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `tbl_login_attempts`;
CREATE TABLE `tbl_login_attempts` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_login_attempts
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_payments
-- ----------------------------
DROP TABLE IF EXISTS `tbl_payments`;
CREATE TABLE `tbl_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `sale_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `transaction_id` varchar(50) DEFAULT NULL,
  `paid_by` varchar(20) NOT NULL,
  `cheque_no` varchar(20) DEFAULT NULL,
  `cc_no` varchar(20) DEFAULT NULL,
  `cc_holder` varchar(25) DEFAULT NULL,
  `cc_month` varchar(2) DEFAULT NULL,
  `cc_year` varchar(4) DEFAULT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `amount` decimal(25,2) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `attachment` varchar(55) DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `pos_paid` decimal(25,2) DEFAULT 0.00,
  `pos_balance` decimal(25,2) DEFAULT 0.00,
  `gc_no` varchar(20) DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_payments
-- ----------------------------
INSERT INTO `tbl_payments` VALUES ('28', '2020-09-30 06:27:36', '28', '1', null, 'cash', '', '', '', '', '', '', '25000.00', null, '1', null, '', '50000.00', '25000.00', '', null, null, null, '1');

-- ----------------------------
-- Table structure for tbl_printers
-- ----------------------------
DROP TABLE IF EXISTS `tbl_printers`;
CREATE TABLE `tbl_printers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(55) NOT NULL,
  `type` varchar(25) NOT NULL,
  `profile` varchar(25) NOT NULL,
  `char_per_line` tinyint(3) unsigned DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `ip_address` varbinary(45) DEFAULT NULL,
  `port` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_printers
-- ----------------------------
INSERT INTO `tbl_printers` VALUES ('1', 'XPrinter', 'network', 'default', '45', '', 0x3139322E3136382E312E323030, '9100');
INSERT INTO `tbl_printers` VALUES ('2', 'a', 'windows', 'simple', '32', 'smb://sapasenja-PC/Printer Kasir', 0x6173, null);

-- ----------------------------
-- Table structure for tbl_products
-- ----------------------------
DROP TABLE IF EXISTS `tbl_products`;
CREATE TABLE `tbl_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` char(255) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 1,
  `price` decimal(25,2) NOT NULL,
  `image` varchar(255) DEFAULT 'no_image.png',
  `tax` varchar(20) DEFAULT NULL,
  `cost` decimal(25,2) DEFAULT NULL,
  `tax_method` tinyint(1) DEFAULT 1,
  `quantity` decimal(15,2) DEFAULT 0.00,
  `barcode_symbology` varchar(20) NOT NULL DEFAULT 'code39',
  `type` varchar(20) NOT NULL DEFAULT 'standard',
  `details` text DEFAULT NULL,
  `alert_quantity` decimal(10,2) DEFAULT 0.00,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1433 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_products
-- ----------------------------
INSERT INTO `tbl_products` VALUES ('1089', 'Km201700001', 'Gula Pasir', '2', '10000.00', 'no_image.png', '10', '9250.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1090', 'Km201700002', 'Kopi Keluarga Besar', '2', '5000.00', 'no_image.png', '10', '3600.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1091', 'Km201700003', 'Kopi Keluarga Kecil', '2', '3000.00', 'no_image.png', '10', '1700.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1092', '8998899004242', 'Autan Care & Protect', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1093', '8998899004105', 'Autan Floral & Protex', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1094', '8997210230018', 'Balon AA', '3', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1095', 'Km201700008', 'Balon Air', '3', '1000.00', 'no_image.png', '10', '900.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1096', '8991977110019', 'Bedak Powder Mbk', '3', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1097', '8993571003933', 'Bedak Salicyl', '3', '7000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1098', '8991389230220', 'Buku Campus', '3', '5000.00', 'no_image.png', '10', '4000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1099', '8993189270277', 'Charm Body Fit', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1100', '8993189270680', 'Charm safe Night', '3', '3000.00', 'no_image.png', '10', '2300.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1101', '8999999528935', 'Citra Natural Bengkoang & Green Tea 120 Ml', '3', '12000.00', 'no_image.png', '10', '10833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1102', 'Km201700009', 'Cukur Jenggot Gillete', '3', '5000.00', 'no_image.png', '10', '3750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1103', '8998103011806', 'Cussons Baby Powder Fresh & Nourish', '3', '6000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1104', '8888103201010', 'Cussons Baby Powder Mild & Gentle', '3', '6000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1105', '8998103000565', 'Cussons Baby Powder Soft & Smooth', '3', '6000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1106', '8992911017074', 'Cutton Bud', '3', '2500.00', 'no_image.png', '10', '1667.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1107', '902430557139', 'Downy Anti Bau', '3', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1108', '902430504454', 'Downy Parfum Collection Mystiquue', '3', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1109', '902430542753', 'Downy Parfum Collecttion Passion', '3', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1110', '8998866888639', 'Giv Green Tea & Almond Oil', '3', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1111', '8993176803075', 'Green Oil Herbal', '3', '8000.00', 'no_image.png', '10', '5917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1112', 'Km201700007', 'Hansaplast Plester', '3', '500.00', 'no_image.png', '10', '270.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1113', '8998866500340', 'Her Protex extra Maxi', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1114', '8998866500357', 'Her Protex Maxi wing', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1115', '8996200900092', 'Herocyn', '3', '15000.00', 'no_image.png', '10', '13333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1116', '8996200900047', 'Herocyn Baby Powder', '3', '11000.00', 'no_image.png', '10', '9000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1117', '8998667100763', 'Jesscool', '3', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1118', '8992812805190', 'Kotex Soft & Smooth', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1119', 'Km201700027', 'Lap Tangan', '3', '5000.00', 'no_image.png', '10', '2500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1120', '8998866106306', 'Lovely White Red Pomegranate', '3', '8000.00', 'no_image.png', '10', '5500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1121', '8999908060907', 'Marina Natrural Protect & Cares', '3', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1122', '8999908045607', 'Marina Natural Nutri Fresh Kecil', '3', '7000.00', 'no_image.png', '10', '4167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1123', '8999908214706', 'Marina Natural Rich Moisturizing Kecil', '3', '7000.00', 'no_image.png', '10', '4167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1124', 'Km201700013', 'Masker Kain', '3', '15000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1125', '8993176110081', 'Minyak Kayu Putih 30 ml', '3', '12000.00', 'no_image.png', '10', '9917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1126', '8993176110074', 'Minyak Kayu Putih 60 ml', '3', '22000.00', 'no_image.png', '10', '19083.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1127', '8993176110111', 'Minyak Urut GPU 30 ml', '3', '10000.00', 'no_image.png', '10', '8250.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1128', '8992745550532', 'Mitu baby Anti Septic Wipes', '3', '16000.00', 'no_image.png', '10', '14373.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1129', '8992745475019', 'Mitu Baby Changing Diaper Wipes', '3', '13000.00', 'no_image.png', '10', '9274.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1130', '8999908208309', 'My Baby Baby Powder Fres Fruity', '3', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1131', '8999908208101', 'My Baby Baby Powder Soft & Getle', '3', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1132', '8999908059802', 'My Baby Powder Fresh Fruity Kecil', '3', '5000.00', 'no_image.png', '10', '3333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1133', '8999908042408', 'My Baby Powder Soft & Gentle Kecil', '3', '5000.00', 'no_image.png', '10', '3333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1134', '8991389247037', 'Paperline Amplop', '3', '500.00', 'no_image.png', '10', '185.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1135', '8999999706081', 'Pepsodent 75 gr', '3', '5000.00', 'no_image.png', '10', '4167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1136', 'Km201700014', 'Pisau Cutter', '3', '5000.00', 'no_image.png', '10', '2500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1137', 'Km201700015', 'Pulpen', '3', '3000.00', 'no_image.png', '10', '2083.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1138', '8999999042387', 'Rexona Atvancet Whitening', '3', '3000.00', 'no_image.png', '10', '2083.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1139', '8934868015031', 'Rexona Men Ice Cool', '3', '3000.00', 'no_image.png', '10', '2083.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1140', 'Km201700024', 'Sandal Yeye', '3', '10000.00', 'no_image.png', '10', '8750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1141', '7237842121416', 'Sensi Diapers XL', '3', '10000.00', 'no_image.png', '10', '8750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1142', '7237842121317', 'Sensi Dipers L', '3', '10000.00', 'no_image.png', '10', '6500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1143', '8991102020152', 'Sikat Gigi Formula', '3', '4000.00', 'no_image.png', '10', '2917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1144', '8999999031930', 'Sikat Gigi Pepsodent', '3', '4000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1145', 'Km201700026', 'Sisir', '3', '3000.00', 'no_image.png', '10', '1667.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1146', '8992959117613', 'Softex Daun Sirih 23cm', '3', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1147', '8992959974131', 'Softex Daun Sirih 28cm', '3', '1500.00', 'no_image.png', '10', '1000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1148', '89928061454147', 'Spons Cuci Piring', '3', '3500.00', 'no_image.png', '10', '2750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1149', '8992959508305', 'Sweety Silver Pants L', '3', '3000.00', 'no_image.png', '10', '2167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1150', '8992959508299', 'Sweety Silver Pants M', '3', '3000.00', 'no_image.png', '10', '2167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1151', '8992959001875', 'Sweety Silver Pants S', '3', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1152', '8992959508312', 'Sweety Silver Pants XL', '3', '3500.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1153', '8993176110135', 'Telon Lan 30 ml', '3', '10000.00', 'no_image.png', '10', '9000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1154', 'Km201700019', 'Tissu Nice', '3', '8500.00', 'no_image.png', '10', '5790.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1155', 'Km201700018', 'Tissu Paseo Basah', '3', '12000.00', 'no_image.png', '10', '8750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1156', 'Km201700017', 'Tissu Paseo Besar', '3', '12000.00', 'no_image.png', '10', '9000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1157', 'Km201700016', 'Tisu Paseo Kecil', '3', '2000.00', 'no_image.png', '10', '1000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1158', '8993053131093', 'Tisu Paseo Sedang', '3', '7000.00', 'no_image.png', '10', '4500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1159', '8993176130591', 'Vfresh Original', '3', '11000.00', 'no_image.png', '10', '9333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1160', 'Km201700049', 'Ayam Bumbu Kecap', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1161', 'Km201700078', 'Ayam Bumbu RW', '4', '15000.00', 'no_image.png', '10', '12000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1162', 'Km201700048', 'Ayam Bumbu Saus', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1163', 'Km201700033', 'Ayam Geprek', '4', '12000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1164', 'Km201700034', 'Ayam Geprek + Nasi', '4', '18000.00', 'no_image.png', '10', '12000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1165', 'Km201700040', 'Ayam Kentaki', '4', '12000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1166', 'Km201700037', 'Ayam Lalapan', '4', '20000.00', 'no_image.png', '10', '18000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1167', 'Km201700038', 'Ayam Lalapan + Nasi', '4', '25000.00', 'no_image.png', '10', '20000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1168', 'Km201700056', 'Bakwan', '4', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1169', 'Km201700079', 'Bebek Bumbu RW', '4', '15000.00', 'no_image.png', '10', '12000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1170', 'Km201700045', 'Bubur Ayam', '4', '12000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1171', 'Km201700042', 'Bubur Tinutuan', '4', '8000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1172', 'Km201700043', 'Bubur Tinutuan+Tahu', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1173', 'Km201700083', 'Empek-Empek', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1174', 'Km201700050', 'Ikan Bumbu Saus', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1175', 'Km201700051', 'Ikan Bumbu Woku', '4', '10000.00', 'no_image.png', '10', '8000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1176', 'Km201700035', 'Ikan Lalapan', '4', '20000.00', 'no_image.png', '10', '18000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1177', 'Km201700036', 'Ikan Lalapan + Nasi', '4', '25000.00', 'no_image.png', '10', '20000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1178', 'Km201700041', 'Mie Bakso', '4', '12000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1179', 'Km201700052', 'Mie Instan', '4', '5000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1180', 'Km201700053', 'Mie Telur Ceplok', '4', '8000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1181', 'Km201700028', 'Nasi Campur (Sayur + Ayam)', '4', '20000.00', 'no_image.png', '10', '18000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1182', 'Km201700029', 'Nasi Campur (Sayur + Ikan )', '4', '17000.00', 'no_image.png', '10', '15000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1183', 'Km201700031', 'Nasi Campur (Sayur + Tahu)', '4', '17000.00', 'no_image.png', '10', '15000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1184', 'Km201700030', 'Nasi Campur (Sayur + Telur)', '4', '17000.00', 'no_image.png', '10', '15000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1185', 'Km201700032', 'Nasi Campur (Sayur + Tempe)', '4', '17000.00', 'no_image.png', '10', '15000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1186', 'KM201700046', 'Nasi Goreng Biasa', '4', '13000.00', 'no_image.png', '10', '10000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1187', 'Km201700047', 'Nasi Goreng Komplit', '4', '15000.00', 'no_image.png', '10', '13000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1188', 'Km201700080', 'Nila Penyet Kemangi', '4', '15000.00', 'no_image.png', '10', '12000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1289', '8999999195649', 'Teh Celup Kotak', '5', '6000.00', 'no_image.png', '10', '5583.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1290', '8999999193522', 'Teh Celup Sari Wangi', '5', '2000.00', 'no_image.png', '10', '1333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1291', 'Km201700069', 'Teh Dingin', '5', '5000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1292', 'Km201700070', 'Teh Hangat', '5', '5000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1293', '8998866201827', 'Teh Javana 350 ml', '5', '6000.00', 'no_image.png', '10', '2500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1294', '8998009040023', 'Teh Kotak', '5', '5000.00', 'no_image.png', '10', '3125.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1295', '8998866500388', 'Teh Rio', '5', '1000.00', 'no_image.png', '10', '875.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1296', 'Km201700068', 'Torabicca Capuchino Hangat', '5', '5000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1297', 'Km201700067', 'Torabicca Capuuchino Dingin', '5', '5000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1298', '8992994110112', 'Yakult', '5', '2500.00', 'no_image.png', '10', '1800.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1299', '8997009510055', 'You C 1000', '5', '7500.00', 'no_image.png', '10', '4667.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1300', 'Km201700010', 'Ember Sedang No.14', '6', '12000.00', 'no_image.png', '10', '8333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1301', 'Km201700011', 'Gayung Mandi', '6', '8000.00', 'no_image.png', '10', '5417.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1302', 'Km201700006', 'Sikat Baju', '6', '7000.00', 'no_image.png', '10', '5833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1303', 'Km201700012', 'Tikar', '6', '35000.00', 'no_image.png', '10', '25000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1304', 'Km201700022', 'Timba No.12', '6', '9000.00', 'no_image.png', '10', '6667.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1305', 'Km201700023', 'Timba No.14', '6', '10000.00', 'no_image.png', '10', '8333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1306', 'Km201700021', 'Timba No.18', '6', '14000.00', 'no_image.png', '10', '12500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1307', '8991115000080', 'Alpenliebe', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1308', '8990800021379', 'Alpenliebe Lolipop', '7', '1000.00', 'no_image.png', '10', '450.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1309', '8991102213189', 'Blaster Choco', '7', '8000.00', 'no_image.png', '10', '6000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1310', '8991102230308', 'Blaster Neapolitan Strawbery Vanila', '7', '8000.00', 'no_image.png', '10', '6000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1311', '8997878002200', 'Chola Candy', '7', '1000.00', 'no_image.png', '10', '472.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1312', '8996001326220', 'Kis Mint Cherry', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1313', '8996001326275', 'Kis Mint Grape', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1314', '8996001320051', 'Kopiko Coffee Candy', '7', '8000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1315', '8991102283380', 'Mintz Cherrymint', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1316', '8991102281430', 'Mintz Duomint', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1317', '8996001338060', 'Tamarin Sari Asam', '7', '9000.00', 'no_image.png', '10', '7000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1318', '8999999533731', 'Citra Bengkoang', '8', '4000.00', 'no_image.png', '10', '2333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1319', '8999999533724', 'Citra Pearl', '8', '4000.00', 'no_image.png', '10', '2333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1320', '8998103012650', 'Cusson Baby Fress & Nourish', '8', '6000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1321', '8888103200617', 'Cusson Baby Mild & Getle', '8', '6000.00', 'no_image.png', '10', '5000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1322', '8998103000534', 'Cusson Baby Soft & Smooth', '8', '5000.00', 'no_image.png', '10', '4000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1323', '8998866604956', 'Daia Deterjen Lemont 55 gr', '8', '2000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1324', '8998866607360', 'Daia Deterjen Putih 55 gr', '8', '2000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1325', '8998866610230', 'Daia Deterjen Violet 55 gr', '8', '2000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1326', '8993518994010', 'Detergent Batangan  Kucing Angora', '8', '4000.00', 'no_image.png', '10', '2500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1327', '8993560025014', 'Dettol Profres Coll', '8', '5000.00', 'no_image.png', '10', '3750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1328', '8993560024116', 'Dettol Proskin', '8', '5000.00', 'no_image.png', '10', '3750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1329', '8993560025113', 'Dettol Re-Energize', '8', '5000.00', 'no_image.png', '10', '3750.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1330', '8998866603683', 'Fress & N atural', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1331', '8998866888622', 'Giv Damaskk Rosa & Cherry Blonssom', '8', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1332', '8998866602389', 'Giv Pasion Flowers & Sweet Berry', '8', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1333', '8998866804516', 'Giv White Lemon & Jojoba Oil', '8', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1334', '8998866609142', 'Giv White Mulberry & Collagen', '8', '3000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1335', '8993379210854', 'Harmony Green Apple Fuji', '8', '3000.00', 'no_image.png', '10', '2167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1336', '8993379200855', 'Harmony Strawberry Alpine', '8', '3000.00', 'no_image.png', '10', '2167.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1337', '8992727005272', 'Jaz One', '8', '2000.00', 'no_image.png', '10', '1000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1338', '8999999059323', 'Lifebuoy Lemon Fresh', '8', '4000.00', 'no_image.png', '10', '2917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1339', '8999999059316', 'Lifebuoy Mild Care', '8', '4000.00', 'no_image.png', '10', '2917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1340', '8999999059309', 'Lifebuoy Total 10', '8', '4000.00', 'no_image.png', '10', '2917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1341', '8999999036638', 'Lux Velvet Jasmine', '8', '4000.00', 'no_image.png', '10', '3333.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1342', '8998866105125', 'Mama Lemon', '8', '2000.00', 'no_image.png', '10', '903.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1343', '8992745540823', 'Mitu Baby Ganti Popok Wipes', '8', '13000.00', 'no_image.png', '10', '9274.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1344', '8999908059703', 'My Baby Honey & Olife Oil', '8', '5000.00', 'no_image.png', '10', '4000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1345', '8999908043108', 'My Baby Soft & Getle', '8', '5000.00', 'no_image.png', '10', '4000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1346', '89999080554302', 'My Baby Sweet Floral', '8', '5000.00', 'no_image.png', '10', '4000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1347', '8998866610742', 'Nuvo Care Protect', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1348', '8998866602570', 'Nuvo Fres Protect', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1349', '8998866602549', 'Nuvo Mild Protect', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1350', '8998866602563', 'Nuvo Nature Protect', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1351', '8998866602556', 'Nuvo Total Protect', '8', '4000.00', 'no_image.png', '10', '2000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1352', '8993379152017', 'Sabu Surya', '8', '4000.00', 'no_image.png', '10', '2917.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1353', '8992946512285', 'Shinzui Kirey', '8', '5000.00', 'no_image.png', '10', '3666.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1354', '8993335516471', 'Total Bunga', '8', '6000.00', 'no_image.png', '10', '4833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1355', '4902430699761', 'Kondisioner Rejoice', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1356', '8999999529819', 'Shampo Clear', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1357', '4902430566988', 'Shampo Head & Sholder', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1358', '4902430563888', 'Shampo nPantene', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1359', '4902430879583', 'Shampo Pantene Gold Series', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1360', '4902430697941', 'Shampo Rejoice', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1361', '8998866106764', 'Shampo Serasoft', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1362', '8999999048167', 'Shampo Sunsilk Cho-Creation', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1363', '8999999048280', 'Shampo Sunsilk Hijab Recharge', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1364', '8999999554972', 'Shampo Thresemme', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1365', '8998866107518', 'Shampo Zinc BlackShine', '9', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1366', '8998866107495', 'Shampo Zinc Hair Fall Treatment', '9', '1000.00', 'no_image.png', '10', '500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1367', '8999999554934', 'Shampoo Dove', '9', '1000.00', 'no_image.png', '10', '833.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1368', '8992946511790', 'Shinzui Matsu', '8', '5000.00', 'no_image.png', '10', '3666.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1369', '8993175538541', ' Nextar Pineaple  jam', '10', '2000.00', 'no_image.png', '10', '1850.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1370', '8996001305119', 'Arden Choco Splendid', '10', '2000.00', 'no_image.png', '10', '1603.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1371', '8886001038011', 'Beng-Beng', '10', '2000.00', 'no_image.png', '10', '1400.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1372', '8996001318430', 'Better Sandwich Biscuit', '10', '1000.00', 'no_image.png', '10', '900.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1373', '8992716109554', 'Biskuat Besar', '10', '4000.00', 'no_image.png', '10', '3000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1374', '7622210437617', 'Biskuat Kecil', '10', '750.00', 'no_image.png', '10', '418.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1375', '8999918383188', 'Biskuit Cream Crackers', '10', '10000.00', 'no_image.png', '10', '9000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1376', '8997025911355', 'Biskuit Hatari Bluebery', '10', '10000.00', 'no_image.png', '10', '5714.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1377', '8997025913120', 'Biskuit Hatari Chocolate', '10', '10000.00', 'no_image.png', '10', '5714.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1378', '8992839690083', 'Biskuit Marie Rasa Coklat', '10', '1500.00', 'no_image.png', '10', '1000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1379', '8992839690014', 'Biskuit Marie Rasa Susu', '10', '1500.00', 'no_image.png', '10', '1000.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1380', '8993039111255', 'Biskuit Regal', '10', '13000.00', 'no_image.png', '10', '10500.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1381', '8996001301142', 'Biskuit Roma Kelapa Besar', '10', '10000.00', 'no_image.png', '10', '7571.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1382', '8996001301111', 'Biskuit Roma Kelapa Sachet', '10', '1000.00', 'no_image.png', '10', '900.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1383', '8991001502926', 'Cha-Cha Peanut Milk Chocolate', '10', '1000.00', 'no_image.png', '10', '900.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1384', '089686600223', 'Cheetos', '10', '1500.00', 'no_image.png', '10', '900.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1385', '8992775311479', 'Chocolatos Dark', '10', '1000.00', 'no_image.png', '10', '875.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1386', '8992775000007', 'Chocolatos Hazelnut', '10', '1000.00', 'no_image.png', '10', '875.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1387', '8992775001608', 'Chocolatos Sweet Cheese', '10', '1000.00', 'no_image.png', '10', '875.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1388', '8996001370063', 'Choky-Choky', '10', '1000.00', 'no_image.png', '10', '875.00', '1', '0.00', 'code39', 'standard', null, '0.00');
INSERT INTO `tbl_products` VALUES ('1432', '8886008101053', 'AQUA 600 ML', '5', '2500.00', '7f1a31a49d1d434523ed0d3d64542885.jpg', '0', '1980.00', '0', '0.00', 'code128', 'standard', '', '10.00');

-- ----------------------------
-- Table structure for tbl_product_store_qty
-- ----------------------------
DROP TABLE IF EXISTS `tbl_product_store_qty`;
CREATE TABLE `tbl_product_store_qty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `quantity` decimal(12,2) NOT NULL DEFAULT 0.00,
  `price` decimal(25,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `store_id` (`store_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_product_store_qty
-- ----------------------------
INSERT INTO `tbl_product_store_qty` VALUES ('16', '1432', '1', '138.00', '2500.00');
INSERT INTO `tbl_product_store_qty` VALUES ('17', '1089', '1', '12.00', null);
INSERT INTO `tbl_product_store_qty` VALUES ('18', '1099', '1', '24.00', null);
INSERT INTO `tbl_product_store_qty` VALUES ('19', '1128', '1', '10.00', null);
INSERT INTO `tbl_product_store_qty` VALUES ('20', '1154', '1', '12.00', null);

-- ----------------------------
-- Table structure for tbl_purchases
-- ----------------------------
DROP TABLE IF EXISTS `tbl_purchases`;
CREATE TABLE `tbl_purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reference` varchar(55) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `note` varchar(1000) NOT NULL,
  `total` decimal(25,2) NOT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `received` tinyint(1) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_purchases
-- ----------------------------
INSERT INTO `tbl_purchases` VALUES ('5', 'Beli Barang', '2020-07-26 06:57:00', '', '459996.00', null, null, null, '1', '1');

-- ----------------------------
-- Table structure for tbl_purchase_items
-- ----------------------------
DROP TABLE IF EXISTS `tbl_purchase_items`;
CREATE TABLE `tbl_purchase_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `cost` decimal(25,2) NOT NULL,
  `subtotal` decimal(25,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_purchase_items
-- ----------------------------
INSERT INTO `tbl_purchase_items` VALUES ('7', '5', '1089', '12.00', '9250.00', '111000.00');
INSERT INTO `tbl_purchase_items` VALUES ('8', '5', '1099', '24.00', '500.00', '12000.00');
INSERT INTO `tbl_purchase_items` VALUES ('9', '5', '1128', '12.00', '14373.00', '172476.00');
INSERT INTO `tbl_purchase_items` VALUES ('10', '5', '1154', '12.00', '5790.00', '69480.00');
INSERT INTO `tbl_purchase_items` VALUES ('11', '5', '1432', '48.00', '1980.00', '95040.00');

-- ----------------------------
-- Table structure for tbl_registers
-- ----------------------------
DROP TABLE IF EXISTS `tbl_registers`;
CREATE TABLE `tbl_registers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL,
  `cash_in_hand` decimal(25,2) NOT NULL,
  `status` varchar(10) NOT NULL,
  `total_cash` decimal(25,2) DEFAULT NULL,
  `total_cheques` int(11) DEFAULT NULL,
  `total_cc_slips` int(11) DEFAULT NULL,
  `total_cash_submitted` decimal(25,2) DEFAULT NULL,
  `total_cheques_submitted` int(11) DEFAULT NULL,
  `total_cc_slips_submitted` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `transfer_opened_bills` varchar(50) DEFAULT NULL,
  `closed_by` int(11) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_registers
-- ----------------------------
INSERT INTO `tbl_registers` VALUES ('6', '2020-07-19 16:53:48', '1', '100000.00', 'close', '112500.00', '0', '0', '112500.00', '0', '0', '', '2020-07-23 13:40:01', null, '1', '1');
INSERT INTO `tbl_registers` VALUES ('7', '2020-07-25 08:24:01', '1', '500000.00', 'close', '515000.00', '0', '0', '515000.00', '0', '0', '', '2020-07-25 14:39:30', null, '1', '1');
INSERT INTO `tbl_registers` VALUES ('8', '2020-07-26 06:59:38', '1', '50000.00', 'close', '50000.00', '0', '0', '50000.00', '0', '0', '', '2020-08-21 06:13:53', null, '1', '1');
INSERT INTO `tbl_registers` VALUES ('9', '2020-08-24 07:51:35', '1', '500000.00', 'close', '525000.00', '0', '0', '525000.00', '0', '0', '', '2020-09-30 07:09:30', null, '1', '1');

-- ----------------------------
-- Table structure for tbl_sales
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sales`;
CREATE TABLE `tbl_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(55) NOT NULL,
  `total` decimal(25,2) NOT NULL,
  `product_discount` decimal(25,2) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_discount` decimal(25,2) DEFAULT NULL,
  `total_discount` decimal(25,2) DEFAULT NULL,
  `product_tax` decimal(25,2) DEFAULT NULL,
  `order_tax_id` varchar(20) DEFAULT NULL,
  `order_tax` decimal(25,2) DEFAULT NULL,
  `total_tax` decimal(25,2) DEFAULT NULL,
  `grand_total` decimal(25,2) NOT NULL,
  `total_items` int(11) DEFAULT NULL,
  `total_quantity` decimal(15,2) DEFAULT NULL,
  `paid` decimal(25,2) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `rounding` decimal(8,2) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  `hold_ref` varchar(255) DEFAULT NULL,
  `resi` varchar(255) DEFAULT NULL,
  `kurir` varchar(100) DEFAULT NULL,
  `tgl_input` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_sales
-- ----------------------------
INSERT INTO `tbl_sales` VALUES ('28', '2020-09-30 06:27:36', '1', 'default konsumen', '12500.00', '0.00', null, '0.00', '0.00', '0.00', null, '0.00', '0.00', '12500.00', '1', '5.00', '25000.00', '1', '1', '2020-09-30 06:28:23', '', 'partial', '0.00', '1', null, null, null, null);

-- ----------------------------
-- Table structure for tbl_sale_items
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sale_items`;
CREATE TABLE `tbl_sale_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `unit_price` decimal(25,2) NOT NULL,
  `net_unit_price` decimal(25,2) NOT NULL,
  `discount` varchar(20) DEFAULT NULL,
  `item_discount` decimal(25,2) DEFAULT NULL,
  `tax` int(20) DEFAULT NULL,
  `item_tax` decimal(25,2) DEFAULT NULL,
  `subtotal` decimal(25,2) NOT NULL,
  `real_unit_price` decimal(25,2) DEFAULT NULL,
  `cost` decimal(25,2) DEFAULT 0.00,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_sale_items
-- ----------------------------
INSERT INTO `tbl_sale_items` VALUES ('37', '28', '1432', '5.00', '2500.00', '2500.00', '0', '0.00', '0', '0.00', '12500.00', '2500.00', '1980.00', '8886008101053', 'AQUA 600 ML', '');

-- ----------------------------
-- Table structure for tbl_sessions
-- ----------------------------
DROP TABLE IF EXISTS `tbl_sessions`;
CREATE TABLE `tbl_sessions` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_sessions
-- ----------------------------
INSERT INTO `tbl_sessions` VALUES ('1butm2rtu241smmj52mfrm6ip7vv6iie', '127.0.0.1', '1601423522', 0x5F5F63695F6C6173745F726567656E65726174657C693A313630313432333532323B6964656E746974797C733A353A2261646D696E223B757365726E616D657C733A353A2261646D696E223B656D61696C7C733A32333A22676F6C646C696F6E73746F726540676D61696C2E636F6D223B757365725F69647C733A313A2231223B66697273745F6E616D657C733A323A22474C223B6C6173745F6E616D657C733A353A2253746F7265223B637265617465645F6F6E7C733A32323A22313920417072696C20323031382032303A33373A3337223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231353938323330323830223B6C6173745F69707C733A393A223132372E302E302E31223B6176617461727C733A33363A2262616639366236616131333736306363326563656365353837653733633166382E6A7067223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B73746F72655F69647C693A313B6861735F73746F72655F69647C4E3B72656769737465725F69647C733A313A2239223B636173685F696E5F68616E647C733A393A223530303030302E3030223B72656769737465725F6F70656E5F74696D657C733A31393A22323032302D30382D32342030373A35313A3335223B);
INSERT INTO `tbl_sessions` VALUES ('c1d4cdg7uej1atlh0q1bgduaql53fqke', '127.0.0.1', '1601424437', 0x5F5F63695F6C6173745F726567656E65726174657C693A313630313432343433373B6964656E746974797C733A353A2261646D696E223B757365726E616D657C733A353A2261646D696E223B656D61696C7C733A32333A22676F6C646C696F6E73746F726540676D61696C2E636F6D223B757365725F69647C733A313A2231223B66697273745F6E616D657C733A323A22474C223B6C6173745F6E616D657C733A353A2253746F7265223B637265617465645F6F6E7C733A32323A22313920417072696C20323031382032303A33373A3337223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231353938323330323830223B6C6173745F69707C733A393A223132372E302E302E31223B6176617461727C733A33363A2262616639366236616131333736306363326563656365353837653733633166382E6A7067223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B73746F72655F69647C693A313B6861735F73746F72655F69647C4E3B72656769737465725F69647C733A313A2239223B636173685F696E5F68616E647C733A393A223530303030302E3030223B72656769737465725F6F70656E5F74696D657C733A31393A22323032302D30382D32342030373A35313A3335223B);
INSERT INTO `tbl_sessions` VALUES ('trb54euua4mf8jg7aq33bucbnh326js0', '127.0.0.1', '1601424636', 0x5F5F63695F6C6173745F726567656E65726174657C693A313630313432343433373B6964656E746974797C733A353A2261646D696E223B757365726E616D657C733A353A2261646D696E223B656D61696C7C733A32333A22676F6C646C696F6E73746F726540676D61696C2E636F6D223B757365725F69647C733A313A2231223B66697273745F6E616D657C733A323A22474C223B6C6173745F6E616D657C733A353A2253746F7265223B637265617465645F6F6E7C733A32323A22313920417072696C20323031382032303A33373A3337223B6F6C645F6C6173745F6C6F67696E7C733A31303A2231353938323330323830223B6C6173745F69707C733A393A223132372E302E302E31223B6176617461727C733A33363A2262616639366236616131333736306363326563656365353837653733633166382E6A7067223B67656E6465727C733A343A226D616C65223B67726F75705F69647C733A313A2231223B73746F72655F69647C693A313B6861735F73746F72655F69647C4E3B);

-- ----------------------------
-- Table structure for tbl_settings
-- ----------------------------
DROP TABLE IF EXISTS `tbl_settings`;
CREATE TABLE `tbl_settings` (
  `setting_id` int(1) NOT NULL,
  `logo` varchar(255) NOT NULL,
  `site_name` varchar(55) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `dateformat` varchar(20) DEFAULT NULL,
  `timeformat` varchar(20) DEFAULT NULL,
  `default_email` varchar(100) NOT NULL,
  `language` varchar(20) NOT NULL,
  `version` varchar(10) NOT NULL DEFAULT '1.0',
  `theme` varchar(20) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT '0',
  `protocol` varchar(20) NOT NULL DEFAULT 'mail',
  `smtp_host` varchar(255) DEFAULT NULL,
  `smtp_user` varchar(100) DEFAULT NULL,
  `smtp_pass` varchar(255) DEFAULT NULL,
  `smtp_port` varchar(10) DEFAULT '25',
  `smtp_crypto` varchar(5) DEFAULT NULL,
  `mmode` tinyint(1) NOT NULL,
  `captcha` tinyint(1) NOT NULL DEFAULT 1,
  `mailpath` varchar(55) DEFAULT NULL,
  `currency_prefix` varchar(3) NOT NULL,
  `default_customer` int(11) NOT NULL,
  `default_tax_rate` varchar(20) NOT NULL,
  `rows_per_page` int(2) NOT NULL,
  `total_rows` int(2) NOT NULL,
  `header` varchar(1000) DEFAULT NULL,
  `footer` varchar(1000) DEFAULT NULL,
  `bsty` tinyint(4) NOT NULL,
  `display_kb` tinyint(4) NOT NULL,
  `default_category` int(11) NOT NULL,
  `default_discount` varchar(20) NOT NULL,
  `item_addition` tinyint(1) NOT NULL,
  `barcode_symbology` varchar(55) DEFAULT NULL,
  `pro_limit` tinyint(4) NOT NULL,
  `decimals` tinyint(1) NOT NULL DEFAULT 2,
  `thousands_sep` varchar(2) NOT NULL DEFAULT ',',
  `decimals_sep` varchar(2) NOT NULL DEFAULT '.',
  `focus_add_item` varchar(55) DEFAULT NULL,
  `add_customer` varchar(55) DEFAULT NULL,
  `toggle_category_slider` varchar(55) DEFAULT NULL,
  `cancel_sale` varchar(55) DEFAULT NULL,
  `suspend_sale` varchar(55) DEFAULT NULL,
  `print_order` varchar(55) DEFAULT NULL,
  `print_bill` varchar(55) DEFAULT NULL,
  `finalize_sale` varchar(55) DEFAULT NULL,
  `today_sale` varchar(55) DEFAULT NULL,
  `open_hold_bills` varchar(55) DEFAULT NULL,
  `close_register` varchar(55) DEFAULT NULL,
  `java_applet` tinyint(1) NOT NULL,
  `receipt_printer` varchar(55) DEFAULT NULL,
  `pos_printers` varchar(255) DEFAULT NULL,
  `cash_drawer_codes` varchar(55) DEFAULT NULL,
  `char_per_line` tinyint(4) DEFAULT 42,
  `rounding` tinyint(1) DEFAULT 0,
  `pin_code` varchar(20) DEFAULT NULL,
  `stripe` tinyint(1) DEFAULT NULL,
  `stripe_secret_key` varchar(100) DEFAULT NULL,
  `stripe_publishable_key` varchar(100) DEFAULT NULL,
  `purchase_code` varchar(100) DEFAULT NULL,
  `envato_username` varchar(50) DEFAULT NULL,
  `theme_style` varchar(25) DEFAULT 'green',
  `after_sale_page` tinyint(1) DEFAULT NULL,
  `overselling` tinyint(1) DEFAULT 1,
  `multi_store` tinyint(1) DEFAULT NULL,
  `qty_decimals` tinyint(1) DEFAULT 2,
  `symbol` varchar(55) DEFAULT NULL,
  `sac` tinyint(1) DEFAULT 0,
  `display_symbol` tinyint(1) DEFAULT NULL,
  `remote_printing` tinyint(1) DEFAULT 1,
  `printer` int(11) DEFAULT NULL,
  `order_printers` varchar(55) DEFAULT NULL,
  `auto_print` tinyint(1) DEFAULT 0,
  `local_printers` tinyint(1) DEFAULT NULL,
  `rtl` tinyint(1) DEFAULT NULL,
  `print_img` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_settings
-- ----------------------------
INSERT INTO `tbl_settings` VALUES ('1', 'logo1.png', 'GL Store', '0812345678', 'd F Y', 'H:i:s', '', 'indonesian', '1.0', 'default', 'Asia/Makassar', '', 'pop.gmail.com', 'noreply@aikogamis.com', '', '25', '', '0', '0', null, 'IDR', '1', '0', '100', '30', null, null, '1', '1', '0', '0', '1', null, '127', '0', ',', '.', null, null, null, null, null, null, null, null, null, null, null, '0', '', '', '', '42', null, null, null, null, null, 'a0de5805-13d4-4bb5-a1c6-4a6837b5cda3', 'savagega', 'green', '0', null, '0', '0', 'Rp', '0', '0', '0', '2', '[\"2\"]', null, '1', null, '0');

-- ----------------------------
-- Table structure for tbl_stores
-- ----------------------------
DROP TABLE IF EXISTS `tbl_stores`;
CREATE TABLE `tbl_stores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `code` varchar(20) NOT NULL,
  `logo` varchar(40) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) NOT NULL,
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `state` varchar(20) DEFAULT NULL,
  `postal_code` varchar(8) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  `currency_code` varchar(3) DEFAULT NULL,
  `receipt_header` text DEFAULT NULL,
  `receipt_footer` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_stores
-- ----------------------------
INSERT INTO `tbl_stores` VALUES ('1', 'Gold Lion Store', 'GLNI', 'b65698a2f3763f2b6320ddc7ce8e5a7e.jpg', 'admin@admin.com', '083808381212', 'Gold Lion Street', 'District GLNI', 'Jombang', 'Banten', '15414', 'Indonesia', 'IDR', '', 'Terima Kasih Telah Berbelanja Di Gold Lion Store Indonesia');

-- ----------------------------
-- Table structure for tbl_suppliers
-- ----------------------------
DROP TABLE IF EXISTS `tbl_suppliers`;
CREATE TABLE `tbl_suppliers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(55) NOT NULL,
  `cf1` varchar(255) NOT NULL,
  `cf2` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_suppliers
-- ----------------------------
INSERT INTO `tbl_suppliers` VALUES ('8', 'INDRA', '', '', '', '');
INSERT INTO `tbl_suppliers` VALUES ('9', 'ID', '', '', '', '');

-- ----------------------------
-- Table structure for tbl_suspended_items
-- ----------------------------
DROP TABLE IF EXISTS `tbl_suspended_items`;
CREATE TABLE `tbl_suspended_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `suspend_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` decimal(15,2) NOT NULL,
  `unit_price` decimal(25,2) NOT NULL,
  `net_unit_price` decimal(25,2) NOT NULL,
  `discount` varchar(20) DEFAULT NULL,
  `item_discount` decimal(25,2) DEFAULT NULL,
  `tax` int(20) DEFAULT NULL,
  `item_tax` decimal(25,2) DEFAULT NULL,
  `subtotal` decimal(25,2) NOT NULL,
  `real_unit_price` decimal(25,2) DEFAULT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `product_name` varchar(50) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_suspended_items
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_suspended_sales
-- ----------------------------
DROP TABLE IF EXISTS `tbl_suspended_sales`;
CREATE TABLE `tbl_suspended_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(55) NOT NULL,
  `total` decimal(25,2) NOT NULL,
  `product_discount` decimal(25,2) DEFAULT NULL,
  `order_discount_id` varchar(20) DEFAULT NULL,
  `order_discount` decimal(25,2) DEFAULT NULL,
  `total_discount` decimal(25,2) DEFAULT NULL,
  `product_tax` decimal(25,2) DEFAULT NULL,
  `order_tax_id` varchar(20) DEFAULT NULL,
  `order_tax` decimal(25,2) DEFAULT NULL,
  `total_tax` decimal(25,2) DEFAULT NULL,
  `grand_total` decimal(25,2) NOT NULL,
  `total_items` int(11) DEFAULT NULL,
  `total_quantity` decimal(15,2) DEFAULT NULL,
  `paid` decimal(25,2) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `note` varchar(1000) DEFAULT NULL,
  `hold_ref` varchar(255) DEFAULT NULL,
  `store_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_suspended_sales
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_users
-- ----------------------------
DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `last_ip_address` varbinary(45) DEFAULT NULL,
  `ip_address` varbinary(45) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activation_code` varchar(40) DEFAULT NULL,
  `forgotten_password_code` varchar(40) DEFAULT NULL,
  `forgotten_password_time` int(11) unsigned DEFAULT NULL,
  `remember_code` varchar(40) DEFAULT NULL,
  `created_on` int(11) unsigned NOT NULL,
  `last_login` int(11) unsigned DEFAULT NULL,
  `active` tinyint(1) unsigned DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `avatar` varchar(55) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `group_id` int(11) unsigned NOT NULL DEFAULT 2,
  `store_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_users
-- ----------------------------
INSERT INTO `tbl_users` VALUES ('1', 0x3132372E302E302E31, 0x3A3A31, 'admin', '18a60c37a48319890063587963caa050fec1e5d0', null, 'goldlionstore@gmail.com', null, null, null, null, '1524145057', '1601421941', '1', 'GL', 'Store', null, '08123456', 'baf96b6aa13760cc2ecece587e73c1f8.jpg', 'male', '1', null);
INSERT INTO `tbl_users` VALUES ('8', 0x3138302E3234312E3134322E3935, 0x3132352E3136332E35362E32, 'nisa', 'e0261b45be71efcdd66c2293013642b5f8c1ec0c', null, 'goldlionstore@gmail.com', null, null, null, null, '1532537501', '1580020927', '1', 'tia', 'Admin3', null, '085884026749', '20c008e5f38330c44375b73e627dbab7.jpg', 'female', '2', '1');
INSERT INTO `tbl_users` VALUES ('10', 0x3132372E302E302E31, 0x33362E37392E3137312E3935, 'dinda', 'e93f27595efe7638ad4b72df4bc11c341d3a1e72', null, 'goldlionstore@gmail.com', null, null, null, null, '1533374763', '1595297348', '1', 'Dinda', 'Admin1', null, '089560193455', 'f73cf0bab4b66088574106e749ca461c.jpg', 'female', '2', '1');

-- ----------------------------
-- Table structure for tbl_user_logins
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user_logins`;
CREATE TABLE `tbl_user_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `company_id` int(11) DEFAULT NULL,
  `ip_address` varbinary(16) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user_logins
-- ----------------------------
INSERT INTO `tbl_user_logins` VALUES ('80', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-04 08:50:01');
INSERT INTO `tbl_user_logins` VALUES ('81', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-19 17:53:24');
INSERT INTO `tbl_user_logins` VALUES ('82', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-19 18:36:21');
INSERT INTO `tbl_user_logins` VALUES ('83', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-21 07:42:42');
INSERT INTO `tbl_user_logins` VALUES ('84', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-21 10:08:02');
INSERT INTO `tbl_user_logins` VALUES ('85', '10', null, 0x3132372E302E302E31, 'dinda', '2020-07-21 10:09:08');
INSERT INTO `tbl_user_logins` VALUES ('86', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-23 14:20:52');
INSERT INTO `tbl_user_logins` VALUES ('87', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-25 09:23:39');
INSERT INTO `tbl_user_logins` VALUES ('88', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-25 15:32:09');
INSERT INTO `tbl_user_logins` VALUES ('89', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-25 15:41:38');
INSERT INTO `tbl_user_logins` VALUES ('90', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-25 16:08:27');
INSERT INTO `tbl_user_logins` VALUES ('91', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-26 07:55:41');
INSERT INTO `tbl_user_logins` VALUES ('92', '1', null, 0x3132372E302E302E31, 'admin', '2020-07-26 08:09:28');
INSERT INTO `tbl_user_logins` VALUES ('93', '1', null, 0x3132372E302E302E31, 'admin', '2020-08-02 08:20:47');
INSERT INTO `tbl_user_logins` VALUES ('94', '1', null, 0x3132372E302E302E31, 'admin', '2020-08-21 07:12:51');
INSERT INTO `tbl_user_logins` VALUES ('95', '1', null, 0x3132372E302E302E31, 'admin', '2020-08-24 08:51:20');
INSERT INTO `tbl_user_logins` VALUES ('96', '1', null, 0x3132372E302E302E31, 'admin', '2020-09-30 07:25:41');
SET FOREIGN_KEY_CHECKS=1;
