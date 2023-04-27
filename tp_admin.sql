/*
 Navicat Premium Data Transfer

 Source Server         : tp_admin
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : tp_admin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 26/03/2023 02:48:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for xt_admin
-- ----------------------------
DROP TABLE IF EXISTS `xt_admin`;
CREATE TABLE `xt_admin`  (
  `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '管理员账号',
  `truename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '真实姓名',
  `phone` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '联系方式',
  `admin_pwd` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '管理员密码',
  `pwd_hash` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'HASH密码',
  `login_time` int(10) NOT NULL DEFAULT 0 COMMENT '登录时间',
  `login_ip` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '登录IP',
  `create_time` int(10) NOT NULL DEFAULT 0 COMMENT '注册时间',
  `power_team` int(2) NULL DEFAULT 0 COMMENT '权限组,默认0,没有权限',
  `is_delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否冻结1是0否',
  `delete_time` int(10) NOT NULL DEFAULT 0 COMMENT '删除时间',
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录后唯一标识',
  `language` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '语言',
  `intro` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qrcode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '二维码',
  `login_str` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '单点登录',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '后台管理员表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_admin
-- ----------------------------
INSERT INTO `xt_admin` VALUES (1, 'admin', '超级管理员', '', '$2y$10$ylYO42VTKG7v1u.uSix6x.0BBGuNGx0i2GkTyQcWm1O2MECpMKlqG', '', 1679758717, '127.0.0.1', 0, 1, 1, 0, '', '', NULL, '', '2bf041fc55bdc78b422bd643e9c93bdc');
INSERT INTO `xt_admin` VALUES (20, 'baixiantao', '白白白', '', '445a6f975e58ed7cb696ca034140aae2', '', 1606895054, '36.46.161.120', 1606894776, 1, 1, 0, '', '', NULL, '', NULL);
INSERT INTO `xt_admin` VALUES (21, 'chengbin', '嘿嘿', '', 'fe35c960aeb94b7e65ceed4b8992f4f5', '', 1606900381, '36.46.161.120', 1606896163, 2, 0, 0, '', '', NULL, '', NULL);
INSERT INTO `xt_admin` VALUES (22, 'geluqi', '小白白', '', '022798d51e32c743000956a9b2eeab9d', '', 1606901352, '192.200.115.226', 1606896284, 2, 0, 0, '', '', NULL, '', NULL);

-- ----------------------------
-- Table structure for xt_admin_author
-- ----------------------------
DROP TABLE IF EXISTS `xt_admin_author`;
CREATE TABLE `xt_admin_author`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `third_token` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '第三方唯一标识',
  `third_type` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1google2facebook3账号密码',
  `email` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `user_type` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0:普通会员1:VIP',
  `passwd` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `nickname` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `realname` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实名字',
  `birthday` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '生日',
  `token` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录生成token验证',
  `gender` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别0:未知1:男2:女',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `register_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '注册时间',
  `register_ip` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '注册IP',
  `last_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_ip` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `login_num` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录次数',
  `user_lock` tinyint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户锁定1锁定0正常',
  `time_zone` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'GMT+8' COMMENT '默认中国时区东八区',
  `ip_zone` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP地区',
  `country` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '国家',
  `language` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '语言',
  `author_source` tinyint(4) NOT NULL DEFAULT 0 COMMENT '作者来源1作家平台，0其他',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mobile`(`email` ASC) USING BTREE,
  INDEX `openid`(`third_token` ASC) USING BTREE,
  INDEX `nickname`(`nickname` ASC) USING BTREE,
  INDEX `language`(`language` ASC) USING BTREE,
  INDEX `country`(`country` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of xt_admin_author
-- ----------------------------
INSERT INTO `xt_admin_author` VALUES (1, 'zuojia', '', 3, '', 0, 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '', 0, '', 1564646217, '', 1564969152, '127.0.0.1', 0, 0, 'GMT+8', '', '', '', 1);
INSERT INTO `xt_admin_author` VALUES (3, 'google', '104832614229127492552', 1, '', 0, 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '', 0, '', 0, '', 1564993357, '127.0.0.1', 0, 0, 'GMT+8', '', '', '', 1);
INSERT INTO `xt_admin_author` VALUES (26, 'author', '', 3, '', 0, 'e10adc3949ba59abbe56e057f20f883e', '', '', '', '69e81d45513068734d8be863e9d271e8', 0, '', 0, '114.4.222.153', 1567740394, '127.0.0.1', 3, 0, 'GMT+8', '印度尼西亚 雅加达', '印度尼西亚', '', 1);
INSERT INTO `xt_admin_author` VALUES (47, 'Zhuang Bifan', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1560767490, '', 1565149981, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (48, 'Athifa', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 1564985674, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (49, 'Sasikirana', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 1564986084, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (50, 'Parisya', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (51, 'Lemon', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (52, 'Teresa', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (53, 'Fabricia Rosalie', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (54, 'Clarissa', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (55, 'Marshmallow', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 1567740261, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (56, 'Ann', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 1564986052, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (57, 'Arshinta Kirania Pratista', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 0, '', 0, '', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (58, '123', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1559289969, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (59, '123', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1559290126, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (60, '', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1561345114, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (61, '陈西', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1563608562, '', 1565059308, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (62, 'at', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564045535, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (63, '香蕉西红柿', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564646217, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (64, 'webread', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564647973, '', 1567732416, '127.0.0.1', 0, 0, 'GMT+8', '', '', 'indonesian', 0);
INSERT INTO `xt_admin_author` VALUES (65, '天蚕土豆', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564648274, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (66, '香蕉西红柿', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564652840, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);
INSERT INTO `xt_admin_author` VALUES (68, 'mengfeike', '', 3, '', 0, 'f0d9bac9279c026a720f9caaebd14bea', '', '', '', '', 0, '', 1564725970, '', 0, '', 0, 0, 'GMT+8', '', '', 'english', 0);

-- ----------------------------
-- Table structure for xt_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `xt_admin_log`;
CREATE TABLE `xt_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `content` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作内容',
  `create_time` int(10) NOT NULL DEFAULT 0,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ip',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员操作log日志' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_admin_log
-- ----------------------------
INSERT INTO `xt_admin_log` VALUES (1, 1, '1', '[admin] 登录', 1651826791, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (2, 1, '1', '[admin] 登录', 1651830369, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (3, 1, '1', '[admin] 登录', 1651883867, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (4, 1, '1', '[admin] 登录', 1651887496, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (5, 1, '1', '[admin] 登录', 1651888032, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (6, 1, '1', '[admin] 登录', 1651894631, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (7, 1, '1', '[admin] 登录', 1652068144, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (8, 1, '1', '[admin] 登录', 1652147976, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (9, 1, '1', '[admin] 登录', 1652152292, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (10, 1, '1', '[admin] 登录', 1652161699, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (11, 1, '1', '[admin] 登录', 1652165347, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (12, 1, '1', '[admin] 登录', 1652167834, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (13, 1, '1', '[admin] 登录', 1652168179, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (14, 1, '1', '[admin] 登录', 1652168708, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (15, 1, '1', '[admin] 登录', 1652168717, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (16, 1, '1', '[admin] 登录', 1652169149, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (17, 1, '1', '[admin] 登录', 1652172915, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (18, 1, '1', '[admin] 登录', 1652176587, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (19, 1, '1', '[admin] 登录', 1652342704, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (20, 1, '2', '修改了权限组规则', 1652346153, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (21, 1, '1', '[admin] 登录', 1652346313, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (22, 1, '1', '[admin] 登录', 1652689201, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (23, 1, '1', '[admin] 登录', 1653533394, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (24, 1, '1', '[admin] 登录', 1653956926, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (25, 1, '1', '[admin] 登录', 1653963996, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (26, 1, '1', '[admin] 登录', 1654139609, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (27, 1, '1', '[admin] 登录', 1654151181, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (28, 1, '1', '[admin] 登录', 1654475874, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (29, 1, '2', '添加了权限组：测试', 1654475889, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (30, 1, '1', '[admin] 登录', 1654486231, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (31, 1, '1', '[admin] 登录', 1654497580, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (32, 1, '1', '[admin] 登录', 1654501872, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (33, 1, '1', '[admin] 登录', 1654502035, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (34, 1, '1', '[admin] 登录', 1654845891, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (35, 1, '1', '[admin] 登录', 1656322492, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (36, 1, '1', '[admin] 登录', 1656490531, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (37, 1, '1', '[admin] 登录', 1656495829, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (38, 1, '1', '[admin] 登录', 1656496729, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (39, 1, '1', '[admin] 登录', 1656552249, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (40, 1, '1', '[admin] 登录', 1656555253, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (41, 1, '1', '[admin] 登录', 1656556334, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (42, 1, '1', '[admin] 登录', 1656567985, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (43, 1, '1', '[admin] 登录', 1656570309, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (44, 1, '1', '[admin] 登录', 1656572997, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (45, 1, '1', '[admin] 登录', 1656575596, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (46, 1, '1', '[admin] 登录', 1656582535, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (47, 1, '1', '[admin] 登录', 1656582545, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (48, 1, '1', '[admin] 登录', 1656582551, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (49, 1, '1', '[admin] 登录', 1656582560, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (50, 1, '1', '[admin] 登录', 1656583044, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (51, 1, '1', '[admin] 登录', 1656583047, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (52, 1, '1', '[admin] 登录', 1656583079, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (53, 1, '1', '[admin] 登录', 1656583144, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (54, 1, '1', '[admin] 登录', 1656636096, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (55, 1, '1', '[admin] 登录', 1656654890, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (56, 1, '1', '[admin] 登录', 1656656019, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (57, 1, '1', '[admin] 登录', 1656656066, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (58, 1, '1', '[admin] 登录', 1656657960, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (59, 1, '1', '[admin] 登录', 1656658276, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (60, 1, '1', '[admin] 登录', 1656658335, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (61, 1, '1', '[admin] 登录', 1656895876, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (62, 1, '1', '[admin] 登录', 1656914170, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (63, 1, '1', '[admin] 登录', 1656918192, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (64, 1, '1', '[admin] 登录', 1656918253, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (65, 1, '1', '[admin] 登录', 1656926466, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (66, 1, '1', '[admin] 登录', 1656980552, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (67, 1, '1', '[admin] 登录', 1656981500, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (68, 1, '1', '[admin] 登录', 1656981623, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (69, 1, '1', '[admin] 登录', 1656982768, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (70, 1, '1', '[admin] 登录', 1656999720, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (71, 1, '1', '[admin] 登录', 1657003532, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (72, 1, '1', '[admin] 登录', 1657010666, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (73, 1, '1', '[admin] 登录', 1663955860, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (74, 1, '1', '[admin] 登录', 1663956030, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (75, 1, '1', '[admin] 登录', 1663956032, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (76, 1, '1', '[admin] 登录', 1663956036, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (77, 1, '1', '[admin] 登录', 1663956095, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (78, 1, '1', '[admin] 登录', 1663956097, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (79, 1, '1', '[admin] 登录', 1663956098, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (80, 1, '1', '[admin] 登录', 1663956164, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (81, 1, '1', '[admin] 登录', 1677001755, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (82, 1, '1', '[admin] 登录', 1677005046, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (83, 1, '1', '[admin] 登录', 1677014552, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (84, 1, '1', '[admin] 登录', 1677058298, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (85, 1, '1', '[admin] 登录', 1679447950, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (86, 1, '1', '[admin] 登录', 1679674881, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (87, 1, '1', '[admin] 登录', 1679685579, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (88, 1, '1', '[admin] 登录', 1679685827, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (89, 1, '1', '[admin] 登录', 1679694712, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (90, 1, '1', '[admin] 登录', 1679695242, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (91, 1, '1', '[admin] 登录', 1679696241, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (92, 1, '1', '[admin] 登录', 1679701175, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (93, 1, '1', '[admin] 登录', 1679705231, '127.0.0.1');
INSERT INTO `xt_admin_log` VALUES (94, 1, '1', '[admin] 登录', 1679758717, '127.0.0.1');

-- ----------------------------
-- Table structure for xt_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_group`;
CREATE TABLE `xt_auth_group`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0禁用1允许',
  `rules` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_group 用户组表， \r\n-- id：主键， title:用户组中文名称， rules：用户组拥有的规则id， 多个规则\",\"隔开，status 状态：为1正常，为0禁用' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of xt_auth_group
-- ----------------------------
INSERT INTO `xt_auth_group` VALUES (1, '超级管理员', 1, '32,1,3,4,5,6,7,9,10,11,12,13,23,24,25,26,33,27,29,30,31,34,14,16,17,18');
INSERT INTO `xt_auth_group` VALUES (2, '运营', 1, '20,21');
INSERT INTO `xt_auth_group` VALUES (3, '编辑', 1, '');
INSERT INTO `xt_auth_group` VALUES (4, '运维', 1, '');
INSERT INTO `xt_auth_group` VALUES (5, '管理员', 0, '');
INSERT INTO `xt_auth_group` VALUES (6, '测试', 1, '');

-- ----------------------------
-- Table structure for xt_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_group_access`;
CREATE TABLE `xt_auth_group_access`  (
  `uid` mediumint(8) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL,
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_group_access 用户组明细表\r\n-- uid:用户id，group_id：用户组id' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of xt_auth_group_access
-- ----------------------------
INSERT INTO `xt_auth_group_access` VALUES (1, 1);

-- ----------------------------
-- Table structure for xt_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_rule`;
CREATE TABLE `xt_auth_rule`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则唯一标识 ：控制器-方法',
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名称',
  `controller` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '方法',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '状态：1正常 0禁用',
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `type` int(10) NOT NULL DEFAULT 0 COMMENT '类型：0菜单  1按钮',
  `level` int(10) NOT NULL DEFAULT 0 COMMENT '级别：1一级菜单或按钮 2二级菜单或按钮 3三级菜单或按钮',
  `parent` int(10) NOT NULL DEFAULT 0 COMMENT '父级菜单',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图标',
  `sort` int(10) NULL DEFAULT 0 COMMENT '菜单排序',
  PRIMARY KEY (`id`, `name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_rule，规则表，\r\n-- id:主键，name：规则唯一标识, title：规则中文名称 status 状态：为1正常，为0禁用，condition：规则表达式，为空表示存在就验证，不为空表示按照条件验证' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of xt_auth_rule
-- ----------------------------
INSERT INTO `xt_auth_rule` VALUES (1, 'admin/admin/index', '管理员', 'admin', 'Admin', 'index', 1, '', 0, 0, 32, '', 0);
INSERT INTO `xt_auth_rule` VALUES (3, 'admin/admin/add', '新增', 'admin', 'Admin', 'add', 1, '', 1, 0, 1, '', 0);
INSERT INTO `xt_auth_rule` VALUES (4, 'admin/admin/edit', '修改', 'admin', 'Admin', 'edit', 1, '', 1, 0, 1, '', 0);
INSERT INTO `xt_auth_rule` VALUES (5, 'admin/admin/del', '删除', 'admin', 'Admin', 'del', 1, '', 1, 0, 1, '', 0);
INSERT INTO `xt_auth_rule` VALUES (6, 'admin/admin/uppass', '改密', 'admin', 'Admin', 'uppass', 1, '', 1, 0, 1, '', 0);
INSERT INTO `xt_auth_rule` VALUES (7, 'admin/auth/index', '权限组', 'admin', 'Auth', 'index', 1, '', 0, 0, 32, '', 0);
INSERT INTO `xt_auth_rule` VALUES (9, 'admin/auth/add', '新增', 'admin', 'Auth', 'add', 1, '', 1, 0, 7, '', 0);
INSERT INTO `xt_auth_rule` VALUES (10, 'admin/auth/edit', '修改', 'admin', 'Auth', 'edit', 1, '', 1, 0, 7, '', 0);
INSERT INTO `xt_auth_rule` VALUES (11, 'admin/auth/del', '删除', 'admin', 'Auth', 'del', 1, '', 1, 0, 7, '', 0);
INSERT INTO `xt_auth_rule` VALUES (12, 'admin/auth/rule', '规则', 'admin', 'Auth', 'rule', 1, '', 1, 0, 7, '', 0);
INSERT INTO `xt_auth_rule` VALUES (13, 'admin/auth/rule_save', '规则保存', 'admin', 'Auth', 'rule_save', 1, '', 1, 0, 7, '', 0);
INSERT INTO `xt_auth_rule` VALUES (14, 'admin/database/index', '数据库管理', 'admin', 'Database', 'index', 1, '', 0, 0, 34, '', 0);
INSERT INTO `xt_auth_rule` VALUES (16, 'admin/database/add', '新增', 'admin', 'Database', 'add', 1, '', 1, 0, 14, '', 0);
INSERT INTO `xt_auth_rule` VALUES (17, 'admin/database/edit', '修改', 'admin', 'Database', 'edit', 1, '', 1, 0, 14, '', 0);
INSERT INTO `xt_auth_rule` VALUES (18, 'admin/database/del', '删除', 'admin', 'Database', 'del', 1, '', 1, 0, 14, '', 0);
INSERT INTO `xt_auth_rule` VALUES (19, 'admin/index/#', '首页1', 'admin', 'Index', '#', 0, '', 0, 0, 0, '', 0);
INSERT INTO `xt_auth_rule` VALUES (20, 'admin/index/index1', '首页2', 'admin', 'Index', 'index1', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule` VALUES (21, 'admin/index/index2', '首页3', 'admin', 'Index', 'index2', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule` VALUES (22, 'admin/index/index3', '首页4', 'admin', 'Index', 'index3', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule` VALUES (23, 'admin/menu/index', '菜单列表', 'admin', 'Menu', 'index', 1, '', 0, 0, 32, '', 0);
INSERT INTO `xt_auth_rule` VALUES (24, 'admin/menu/add', '新增', 'admin', 'Menu', 'add', 1, '', 1, 0, 23, '', 0);
INSERT INTO `xt_auth_rule` VALUES (25, 'admin/menu/edit', '修改', 'admin', 'Menu', 'edit', 1, '', 1, 0, 23, '', 0);
INSERT INTO `xt_auth_rule` VALUES (26, 'admin/menu/del', '删除', 'admin', 'Menu', 'del', 1, '', 1, 0, 23, '', 0);
INSERT INTO `xt_auth_rule` VALUES (27, 'admin/user/index', '用户列表', 'admin', 'User', 'index', 1, '', 0, 0, 33, '', 0);
INSERT INTO `xt_auth_rule` VALUES (29, 'admin/user/add', '新增', 'admin', 'User', 'add', 1, '', 1, 0, 27, '', 0);
INSERT INTO `xt_auth_rule` VALUES (30, 'admin/user/edit', '修改', 'admin', 'User', 'edit', 1, '', 1, 0, 27, '', 0);
INSERT INTO `xt_auth_rule` VALUES (31, 'admin/user/del', '删除', 'admin', 'User', 'del', 1, '', 1, 0, 27, '', 0);
INSERT INTO `xt_auth_rule` VALUES (32, 'admin/auth/#', '权限管理', 'admin', 'Auth', '#', 1, '', 0, 0, 0, '', 0);
INSERT INTO `xt_auth_rule` VALUES (33, 'admin/user/#', '用户管理', 'admin', 'User', '#', 1, '', 0, 0, 0, '', 0);
INSERT INTO `xt_auth_rule` VALUES (34, 'admin/#/#', '系统设置', 'admin', '#', '#', 1, '', 0, 0, 0, '', 0);
INSERT INTO `xt_auth_rule` VALUES (35, 'admin/test/#', '测试菜单', 'admin', 'Test', '#', 1, '', 0, 0, 0, '', 0);
INSERT INTO `xt_auth_rule` VALUES (36, 'admin/test/index1', '测试菜单2', 'admin', 'Test', 'index1', 1, '', 0, 0, 35, '', 0);
INSERT INTO `xt_auth_rule` VALUES (37, 'admin/test/index2', '测试菜单3', 'admin', 'Test', 'index2', 1, '', 0, 0, 36, '', 0);
INSERT INTO `xt_auth_rule` VALUES (38, 'admin/test/index3', '测试菜单3', 'admin', 'Test', 'index3', 1, '', 0, 0, 37, '', 0);

-- ----------------------------
-- Table structure for xt_auth_rule_1
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_rule_1`;
CREATE TABLE `xt_auth_rule_1`  (
  `id` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT NULL,
  `parent` int(11) NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_rule，规则表，\n-- id:主键，name：规则唯一标识, title：规则中文名称 status 状态：为1正常，为0禁用，condition：规则表达式，为空表示存在就验证，不为空表示按照条件验证' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xt_auth_rule_1
-- ----------------------------
INSERT INTO `xt_auth_rule_1` VALUES ('1', '/admin/index/index', '控制台', 1, '', 0, 1, 0, '');
INSERT INTO `xt_auth_rule_1` VALUES ('2', '/admin/index/index2', '仪表盘2', 0, '', 0, 2, 1, '');
INSERT INTO `xt_auth_rule_1` VALUES ('3', '/admin/index/index3', '仪表盘3', 0, '', 0, 2, 1, '');
INSERT INTO `xt_auth_rule_1` VALUES ('4', '/admin/auth/index', '权限设置', 1, '', 0, 1, 0, '');
INSERT INTO `xt_auth_rule_1` VALUES ('5', '/admin/auth/powerlist', '菜单列表', 1, '', 0, 2, 4, '');
INSERT INTO `xt_auth_rule_1` VALUES ('6', '/admin/auth/poweradd', '新增', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_1` VALUES ('7', '/admin/auth/poweredit', '修改', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_1` VALUES ('8', '/admin/auth/powerdelete', '删除', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_1` VALUES ('9', '/admin/auth/powersave', '保存', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_1` VALUES ('11', '/admin/auth/grouplist', '权限组', 1, '', 0, 0, 4, '');
INSERT INTO `xt_auth_rule_1` VALUES ('12', '/admin/admin/index', '管理员', 1, '', 0, 0, 0, '');
INSERT INTO `xt_auth_rule_1` VALUES ('13', '/admin/admin/add', '新增', 1, '', 1, 0, 12, '');
INSERT INTO `xt_auth_rule_1` VALUES ('14', '/admin/auth/groupadd', '新增', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_1` VALUES ('15', '/admin/auth/groupup', '修改', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_1` VALUES ('16', '/admin/auth/groupsave', '保存', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_1` VALUES ('17', '/admin/auth/groupde', '删除', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_1` VALUES ('18', 'auth/changepower', '规则修改', 1, '', 1, 0, 11, '');

-- ----------------------------
-- Table structure for xt_auth_rule_2
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_rule_2`;
CREATE TABLE `xt_auth_rule_2`  (
  `id` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT NULL,
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT NULL,
  `parent` int(11) NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_rule，规则表，\n-- id:主键，name：规则唯一标识, title：规则中文名称 status 状态：为1正常，为0禁用，condition：规则表达式，为空表示存在就验证，不为空表示按照条件验证' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xt_auth_rule_2
-- ----------------------------
INSERT INTO `xt_auth_rule_2` VALUES ('1', '/admin/index/index', '控制台', 1, '', 0, 1, 0, '');
INSERT INTO `xt_auth_rule_2` VALUES ('2', '/admin/index/index2', '仪表盘2', 0, '', 0, 2, 1, '');
INSERT INTO `xt_auth_rule_2` VALUES ('3', '/admin/index/index3', '仪表盘3', 0, '', 0, 2, 1, '');
INSERT INTO `xt_auth_rule_2` VALUES ('4', '/admin/auth/index', '权限设置', 1, '', 0, 1, 0, '');
INSERT INTO `xt_auth_rule_2` VALUES ('5', '/admin/auth/powerlist', '菜单列表', 1, '', 0, 2, 4, '');
INSERT INTO `xt_auth_rule_2` VALUES ('6', '/admin/auth/poweradd', '新增', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_2` VALUES ('7', '/admin/auth/poweredit', '修改', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_2` VALUES ('8', '/admin/auth/powerdelete', '删除', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_2` VALUES ('9', '/admin/auth/powersave', '保存', 1, '', 1, 0, 5, '');
INSERT INTO `xt_auth_rule_2` VALUES ('11', '/admin/auth/grouplist', '权限组', 1, '', 0, 0, 4, '');
INSERT INTO `xt_auth_rule_2` VALUES ('12', '/admin/admin/index', '管理员', 1, '', 0, 0, 4, '');
INSERT INTO `xt_auth_rule_2` VALUES ('13', '/admin/admin/add', '新增', 1, '', 1, 0, 12, '');
INSERT INTO `xt_auth_rule_2` VALUES ('14', '/admin/auth/groupadd', '新增', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_2` VALUES ('15', '/admin/auth/groupup', '修改', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_2` VALUES ('16', '/admin/auth/groupsave', '保存', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_2` VALUES ('17', '/admin/auth/groupde', '删除', 1, '', 1, 0, 11, '');
INSERT INTO `xt_auth_rule_2` VALUES ('18', '/admin/auth/changepower', '规则修改', 1, '', 1, 0, 11, '');

-- ----------------------------
-- Table structure for xt_auth_rule_copy1
-- ----------------------------
DROP TABLE IF EXISTS `xt_auth_rule_copy1`;
CREATE TABLE `xt_auth_rule_copy1`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则唯一标识 ：控制器-方法',
  `title` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则中文名称',
  `module` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '应用名称',
  `controller` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '方法',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态：1正常 0禁用',
  `condition` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则表达式，为空表示存在就验证，不为空表示按照条件验证',
  `type` int(10) NOT NULL DEFAULT 0 COMMENT '类型：0菜单  1按钮',
  `level` int(10) NOT NULL DEFAULT 0 COMMENT '级别：1一级菜单或按钮 2二级菜单或按钮 3三级菜单或按钮',
  `parent` int(10) NOT NULL DEFAULT 0 COMMENT '父级菜单',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '图标',
  `sort` int(10) NULL DEFAULT 0 COMMENT '菜单排序',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 80 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '-- think_auth_rule，规则表，\r\n-- id:主键，name：规则唯一标识, title：规则中文名称 status 状态：为1正常，为0禁用，condition：规则表达式，为空表示存在就验证，不为空表示按照条件验证' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of xt_auth_rule_copy1
-- ----------------------------
INSERT INTO `xt_auth_rule_copy1` VALUES (24, 'admin/admin_del', '删除', NULL, '', '', 0, '', 1, 0, 12, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (4, 'auth/index', '权限设置', NULL, '', '', 1, '', 0, 1, 0, 'icon-quanxian', 18);
INSERT INTO `xt_auth_rule_copy1` VALUES (5, 'auth/menu', '菜单列表', NULL, '', '', 1, '', 0, 2, 4, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (6, 'auth/menu_add', '新增', NULL, '', '', 1, '', 1, 0, 5, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (7, 'auth/menu_edit', '修改', NULL, '', '', 1, '', 1, 0, 5, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (8, 'auth/menu_delete', '删除', NULL, '', '', 1, '', 1, 0, 5, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (9, 'auth/powersave', '保存', NULL, '', '', 1, '', 1, 0, 5, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (11, 'auth/group_list', '权限组', NULL, '', '', 1, '', 0, 0, 4, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (12, 'admin/index', '管理员', NULL, '', '', 1, '', 0, 0, 4, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (13, 'admin/admin_add', '新增', NULL, '', '', 1, '', 1, 0, 12, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (14, 'auth/group_add', '新增', NULL, '', '', 1, '', 1, 0, 11, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (15, 'auth/group_edit', '修改', NULL, '', '', 1, '', 1, 0, 11, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (16, 'auth/groupsave', '保存', NULL, '', '', 1, '', 1, 0, 11, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (17, 'auth/group_del', '删除', NULL, '', '', 1, '', 1, 0, 11, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (18, 'auth/changepower', '规则修改', NULL, '', '', 1, '', 1, 0, 11, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (19, 'system/index', '系统设置', NULL, '', '', 1, '', 0, 0, 0, 'icon-dianpu', 19);
INSERT INTO `xt_auth_rule_copy1` VALUES (20, 'game/index', '游戏管理', NULL, '', '', 0, '', 0, 0, 0, '', 17);
INSERT INTO `xt_auth_rule_copy1` VALUES (21, 'game/game_list', '游戏列表', NULL, '', '', 0, '', 0, 0, 20, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (22, 'admin/admin_edit', '修改', NULL, '', '', 0, '', 1, 0, 12, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (23, 'system/email', '邮箱管理', NULL, '', '', 0, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (25, 'game/game_list_sun', '测试三级菜单', NULL, '', '', 0, '', 0, 0, 21, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (26, 'test/index', '测试菜单1级', NULL, '', '', 0, '', 0, 0, 0, '', 16);
INSERT INTO `xt_auth_rule_copy1` VALUES (27, 'test/index2', '测试菜单2级', NULL, '', '', 0, '', 0, 0, 26, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (28, 'test/index3', '测试菜单3级', NULL, '', '', 0, '', 0, 0, 27, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (29, 'test/index4', '测试菜单4级', NULL, '', '', 0, '', 0, 0, 28, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (30, 'test/test001', '测试001菜单', NULL, '', '', 0, '', 0, 0, 26, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (31, 'database/table_list', '数据库管理', NULL, '', '', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (32, 'system/set', '基本设置', NULL, '', '', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (33, 'system/column', '栏目设置', NULL, '', '', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (34, 'system/safe', '安全设置', NULL, '', '', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (35, 'system/log', '系统日志', NULL, '', '', 1, '', 0, 0, 19, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (36, 'knowledge/index', '知识库', NULL, '', '', 1, '', 0, 0, 0, 'icon-zhishiku', 15);
INSERT INTO `xt_auth_rule_copy1` VALUES (37, 'knowledge/list', '知识库列表', NULL, '', '', 1, '', 0, 0, 36, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (38, 'capacity/index', '容量管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-rongliang', 14);
INSERT INTO `xt_auth_rule_copy1` VALUES (39, 'capacity/overview', '容量总览', NULL, '', '', 1, '', 0, 0, 38, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (40, 'capacity/machine', '机房容量', NULL, '', '', 1, '', 0, 0, 38, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (41, 'efficiency/index', '能效管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-nengxiaocelve', 13);
INSERT INTO `xt_auth_rule_copy1` VALUES (42, 'efficiency/overview', '能效总览', NULL, '', '', 1, '', 0, 0, 41, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (43, 'efficiency/analysis', '机房能效分析', NULL, '', '', 1, '', 0, 0, 41, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (44, 'efficiency/auxiliary_analysis', '能效辅助分析工具', NULL, '', '', 1, '', 0, 0, 41, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (45, 'construction/index', '施工管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-shigong', 12);
INSERT INTO `xt_auth_rule_copy1` VALUES (46, 'construction/manage', '施工管理', NULL, '', '', 1, '', 0, 0, 45, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (47, 'spare/index', '备品备件管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-beipinbeijian', 11);
INSERT INTO `xt_auth_rule_copy1` VALUES (48, 'spare/ledger', '备件台账', NULL, '', '', 1, '', 0, 0, 47, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (49, 'spare/warehousing', '备件入库单', NULL, '', '', 1, '', 0, 0, 47, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (50, 'spare/receive', '备件领用单', NULL, '', '', 1, '', 0, 0, 47, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (51, 'warehouse/management', '仓库管理', NULL, '', '', 1, '', 0, 0, 47, '', 10);
INSERT INTO `xt_auth_rule_copy1` VALUES (52, 'equipment/index', '设备维修报修', NULL, '', '', 1, '', 0, 0, 0, 'icon-weixiu', 9);
INSERT INTO `xt_auth_rule_copy1` VALUES (53, 'equipment/list', '设备报修单', NULL, '', '', 1, '', 0, 0, 52, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (54, 'inspection/index', '设备点检巡查', NULL, '', '', 1, '', 0, 0, 0, 'icon-shebeidianjian', 8);
INSERT INTO `xt_auth_rule_copy1` VALUES (55, 'inspection/list', '设备巡检单', NULL, '', '', 1, '', 0, 0, 54, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (56, 'inspection/plan', '巡检计划', NULL, '', '', 1, '', 0, 0, 54, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (57, 'inspection/content', '巡检内容', NULL, '', '', 1, '', 0, 0, 54, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (58, 'supplier/manage', '供应商管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-gongyingshang', 7);
INSERT INTO `xt_auth_rule_copy1` VALUES (59, 'supply/record', '供应记录', NULL, '', '', 1, '', 0, 0, 58, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (60, 'contract/manage', '合同管理', NULL, '', '', 1, '', 0, 0, 58, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (61, 'maintenance/index', '设备保养', NULL, '', '', 1, '', 0, 0, 0, 'icon-shebeibaoyang', 6);
INSERT INTO `xt_auth_rule_copy1` VALUES (62, 'maintenance/equipment', '设备保养单', NULL, '', '', 1, '', 0, 0, 61, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (63, 'maintenance/plan', '保养计划', NULL, '', '', 1, '', 0, 0, 61, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (64, 'machineroom/index', '机房管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-jifang', 5);
INSERT INTO `xt_auth_rule_copy1` VALUES (65, 'machineroom/manage', '机房列表', NULL, '', '', 1, '', 0, 0, 64, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (66, 'machineroom/installation_location', '安装地点管理', NULL, '', '', 1, '', 0, 0, 64, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (67, 'equipment/all', '设备管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-shebei', 4);
INSERT INTO `xt_auth_rule_copy1` VALUES (68, 'equipment/all_list', '所有设备', NULL, '', '', 1, '', 0, 0, 67, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (69, 'equipment/type', '设备类型', NULL, '', '', 1, '', 0, 0, 67, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (70, 'equipment/map', '设备地图', NULL, '', '', 1, '', 0, 0, 67, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (71, 'duty/index', '值班管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-zhiban', 3);
INSERT INTO `xt_auth_rule_copy1` VALUES (72, 'duty/plan', '值班计划', NULL, '', '', 1, '', 0, 0, 71, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (73, 'duty/shift_manage', '班次管理', NULL, '', '', 1, '', 0, 0, 71, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (74, 'duty/calendar', '值班日历', NULL, '', '', 1, '', 0, 0, 71, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (75, 'duty/handover', '交接管理', NULL, '', '', 1, '', 0, 0, 71, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (76, 'personnel/index', '人员管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-renyuan', 2);
INSERT INTO `xt_auth_rule_copy1` VALUES (77, 'personnel/manage', '人员管理', NULL, '', '', 1, '', 0, 0, 76, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (78, 'personnel/department', '部门管理', NULL, '', '', 1, '', 0, 0, 76, '', 0);
INSERT INTO `xt_auth_rule_copy1` VALUES (79, 'alarm/index', '告警管理', NULL, '', '', 1, '', 0, 0, 0, 'icon-yujing-46-46', 1);

-- ----------------------------
-- Table structure for xt_bank_province_city
-- ----------------------------
DROP TABLE IF EXISTS `xt_bank_province_city`;
CREATE TABLE `xt_bank_province_city`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 377 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_bank_province_city
-- ----------------------------
INSERT INTO `xt_bank_province_city` VALUES (1, '北京', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (2, '天津', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (3, '河北省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (4, '山西省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (5, '内蒙古', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (6, '辽宁省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (7, '吉林省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (8, '黑龙江省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (9, '上海', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (10, '江苏省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (11, '浙江省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (12, '安徽省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (13, '福建省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (14, '江西省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (15, '山东省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (16, '河南省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (17, '湖北省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (18, '湖南省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (19, '广东省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (20, '广西', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (21, '海南省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (22, '重庆', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (23, '四川省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (24, '贵州省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (25, '云南省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (26, '西藏', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (27, '陕西省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (28, '甘肃省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (29, '青海省', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (30, '宁夏', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (31, '新疆', 0, NULL);
INSERT INTO `xt_bank_province_city` VALUES (32, '北京市', 1, '');
INSERT INTO `xt_bank_province_city` VALUES (33, '天津市', 2, '');
INSERT INTO `xt_bank_province_city` VALUES (34, '石家庄市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (35, '唐山市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (36, '秦皇岛市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (37, '邯郸市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (38, '邢台市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (39, '保定市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (40, '张家口市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (41, '承德市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (42, '沧州市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (43, '廊坊市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (44, '衡水市', 3, '');
INSERT INTO `xt_bank_province_city` VALUES (45, '太原市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (46, '大同市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (47, '阳泉市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (48, '长治市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (49, '晋城市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (50, '朔州市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (51, '晋中市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (52, '运城市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (53, '忻州市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (54, '临汾市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (55, '吕梁市', 4, '');
INSERT INTO `xt_bank_province_city` VALUES (56, '呼和浩特市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (57, '包头市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (58, '乌海市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (59, '赤峰市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (60, '通辽市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (61, '鄂尔多斯市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (62, '呼伦贝尔市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (63, '巴彦淖尔市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (64, '乌兰察布市', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (65, '兴安盟', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (66, '锡林郭勒盟', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (67, '阿拉善盟', 5, '');
INSERT INTO `xt_bank_province_city` VALUES (68, '沈阳市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (69, '大连市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (70, '鞍山市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (71, '抚顺市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (72, '本溪市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (73, '丹东市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (74, '锦州市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (75, '营口市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (76, '阜新市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (77, '辽阳市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (78, '盘锦市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (79, '铁岭市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (80, '朝阳市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (81, '葫芦岛市', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (82, '金普新区', 6, '');
INSERT INTO `xt_bank_province_city` VALUES (83, '长春市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (84, '吉林市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (85, '四平市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (86, '辽源市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (87, '通化市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (88, '白山市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (89, '松原市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (90, '白城市', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (91, '延边朝鲜族自治州', 7, '');
INSERT INTO `xt_bank_province_city` VALUES (92, '哈尔滨市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (93, '齐齐哈尔市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (94, '鸡西市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (95, '鹤岗市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (96, '双鸭山市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (97, '大庆市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (98, '伊春市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (99, '佳木斯市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (100, '七台河市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (101, '牡丹江市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (102, '黑河市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (103, '绥化市', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (104, '大兴安岭地区', 8, '');
INSERT INTO `xt_bank_province_city` VALUES (105, '上海市', 9, '');
INSERT INTO `xt_bank_province_city` VALUES (106, '南京市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (107, '无锡市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (108, '徐州市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (109, '常州市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (110, '苏州市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (111, '南通市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (112, '连云港市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (113, '淮安市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (114, '盐城市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (115, '扬州市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (116, '镇江市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (117, '泰州市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (118, '宿迁市', 10, '');
INSERT INTO `xt_bank_province_city` VALUES (119, '杭州市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (120, '宁波市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (121, '温州市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (122, '嘉兴市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (123, '湖州市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (124, '绍兴市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (125, '金华市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (126, '衢州市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (127, '舟山市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (128, '台州市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (129, '丽水市', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (130, '舟山群岛新区', 11, '');
INSERT INTO `xt_bank_province_city` VALUES (131, '合肥市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (132, '芜湖市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (133, '蚌埠市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (134, '淮南市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (135, '马鞍山市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (136, '淮北市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (137, '铜陵市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (138, '安庆市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (139, '黄山市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (140, '滁州市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (141, '阜阳市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (142, '宿州市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (143, '六安市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (144, '亳州市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (145, '池州市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (146, '宣城市', 12, '');
INSERT INTO `xt_bank_province_city` VALUES (147, '福州市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (148, '厦门市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (149, '莆田市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (150, '三明市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (151, '泉州市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (152, '漳州市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (153, '南平市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (154, '龙岩市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (155, '宁德市', 13, '');
INSERT INTO `xt_bank_province_city` VALUES (156, '南昌市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (157, '景德镇市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (158, '萍乡市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (159, '九江市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (160, '新余市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (161, '鹰潭市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (162, '赣州市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (163, '吉安市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (164, '宜春市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (165, '抚州市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (166, '上饶市', 14, '');
INSERT INTO `xt_bank_province_city` VALUES (167, '济南市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (168, '青岛市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (169, '淄博市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (170, '枣庄市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (171, '东营市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (172, '烟台市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (173, '潍坊市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (174, '济宁市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (175, '泰安市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (176, '威海市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (177, '日照市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (178, '莱芜市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (179, '临沂市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (180, '德州市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (181, '聊城市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (182, '滨州市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (183, '菏泽市', 15, '');
INSERT INTO `xt_bank_province_city` VALUES (184, '郑州市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (185, '开封市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (186, '洛阳市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (187, '平顶山市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (188, '安阳市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (189, '鹤壁市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (190, '新乡市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (191, '焦作市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (192, '濮阳市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (193, '许昌市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (194, '漯河市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (195, '三门峡市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (196, '南阳市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (197, '商丘市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (198, '信阳市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (199, '周口市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (200, '驻马店市', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (201, '直辖县级', 16, '');
INSERT INTO `xt_bank_province_city` VALUES (202, '武汉市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (203, '黄石市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (204, '十堰市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (205, '宜昌市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (206, '襄阳市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (207, '鄂州市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (208, '荆门市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (209, '孝感市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (210, '荆州市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (211, '黄冈市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (212, '咸宁市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (213, '随州市', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (214, '恩施土家族苗族自治州', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (215, '湖北直辖县级', 17, '');
INSERT INTO `xt_bank_province_city` VALUES (216, '长沙市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (217, '株洲市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (218, '湘潭市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (219, '衡阳市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (220, '邵阳市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (221, '岳阳市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (222, '常德市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (223, '张家界市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (224, '益阳市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (225, '郴州市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (226, '永州市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (227, '怀化市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (228, '娄底市', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (229, '湘西土家族苗族自治州', 18, '');
INSERT INTO `xt_bank_province_city` VALUES (230, '广州市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (231, '韶关市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (232, '深圳市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (233, '珠海市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (234, '汕头市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (235, '佛山市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (236, '江门市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (237, '湛江市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (238, '茂名市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (239, '肇庆市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (240, '惠州市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (241, '梅州市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (242, '汕尾市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (243, '河源市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (244, '阳江市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (245, '清远市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (246, '东莞市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (247, '中山市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (248, '潮州市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (249, '揭阳市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (250, '云浮市', 19, '');
INSERT INTO `xt_bank_province_city` VALUES (251, '南宁市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (252, '柳州市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (253, '桂林市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (254, '梧州市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (255, '北海市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (256, '防城港市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (257, '钦州市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (258, '贵港市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (259, '玉林市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (260, '百色市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (261, '贺州市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (262, '河池市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (263, '来宾市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (264, '崇左市', 20, '');
INSERT INTO `xt_bank_province_city` VALUES (265, '海口市', 21, '');
INSERT INTO `xt_bank_province_city` VALUES (266, '三亚市', 21, '');
INSERT INTO `xt_bank_province_city` VALUES (267, '三沙市', 21, '');
INSERT INTO `xt_bank_province_city` VALUES (268, '直辖县级', 21, '');
INSERT INTO `xt_bank_province_city` VALUES (269, '重庆市', 22, '');
INSERT INTO `xt_bank_province_city` VALUES (270, '两江新区', 22, '');
INSERT INTO `xt_bank_province_city` VALUES (271, '成都市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (272, '自贡市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (273, '攀枝花市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (274, '泸州市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (275, '德阳市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (276, '绵阳市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (277, '广元市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (278, '遂宁市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (279, '内江市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (280, '乐山市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (281, '南充市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (282, '眉山市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (283, '宜宾市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (284, '广安市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (285, '达州市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (286, '雅安市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (287, '巴中市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (288, '资阳市', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (289, '阿坝藏族羌族自治州', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (290, '甘孜藏族自治州', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (291, '凉山彝族自治州', 23, '');
INSERT INTO `xt_bank_province_city` VALUES (292, '贵阳市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (293, '六盘水市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (294, '遵义市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (295, '安顺市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (296, '毕节市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (297, '铜仁市', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (298, '黔西南布依族苗族自治州', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (299, '黔东南苗族侗族自治州', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (300, '黔南布依族苗族自治州', 24, '');
INSERT INTO `xt_bank_province_city` VALUES (301, '昆明市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (302, '曲靖市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (303, '玉溪市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (304, '保山市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (305, '昭通市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (306, '丽江市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (307, '普洱市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (308, '临沧市', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (309, '楚雄彝族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (310, '红河哈尼族彝族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (311, '文山壮族苗族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (312, '西双版纳傣族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (313, '大理白族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (314, '德宏傣族景颇族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (315, '怒江傈僳族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (316, '迪庆藏族自治州', 25, '');
INSERT INTO `xt_bank_province_city` VALUES (317, '拉萨市', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (318, '日喀则市', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (319, '昌都市', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (320, '山南地区', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (321, '那曲地区', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (322, '阿里地区', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (323, '林芝地区', 26, '');
INSERT INTO `xt_bank_province_city` VALUES (324, '西安市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (325, '铜川市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (326, '宝鸡市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (327, '咸阳市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (328, '渭南市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (329, '延安市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (330, '汉中市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (331, '榆林市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (332, '安康市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (333, '商洛市', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (334, '西咸新区', 27, '');
INSERT INTO `xt_bank_province_city` VALUES (335, '兰州市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (336, '嘉峪关市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (337, '金昌市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (338, '白银市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (339, '天水市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (340, '武威市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (341, '张掖市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (342, '平凉市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (343, '酒泉市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (344, '庆阳市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (345, '定西市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (346, '陇南市', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (347, '临夏回族自治州', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (348, '甘南藏族自治州', 28, '');
INSERT INTO `xt_bank_province_city` VALUES (349, '西宁市', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (350, '海东市', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (351, '海北藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (352, '黄南藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (353, '海南藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (354, '果洛藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (355, '玉树藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (356, '海西蒙古族藏族自治州', 29, '');
INSERT INTO `xt_bank_province_city` VALUES (357, '银川市', 30, '');
INSERT INTO `xt_bank_province_city` VALUES (358, '石嘴山市', 30, '');
INSERT INTO `xt_bank_province_city` VALUES (359, '吴忠市', 30, '');
INSERT INTO `xt_bank_province_city` VALUES (360, '固原市', 30, '');
INSERT INTO `xt_bank_province_city` VALUES (361, '中卫市', 30, '');
INSERT INTO `xt_bank_province_city` VALUES (362, '乌鲁木齐市', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (363, '克拉玛依市', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (364, '吐鲁番地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (365, '哈密地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (366, '昌吉回族自治州', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (367, '博尔塔拉蒙古自治州', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (368, '巴音郭楞蒙古自治州', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (369, '阿克苏地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (370, '克孜勒苏柯尔克孜自治州', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (371, '喀什地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (372, '和田地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (373, '伊犁哈萨克自治州', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (374, '塔城地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (375, '阿勒泰地区', 31, '');
INSERT INTO `xt_bank_province_city` VALUES (376, '直辖县级', 31, '');

-- ----------------------------
-- Table structure for xt_config
-- ----------------------------
DROP TABLE IF EXISTS `xt_config`;
CREATE TABLE `xt_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `update_time` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `key`(`key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '配置信息' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_config
-- ----------------------------
INSERT INTO `xt_config` VALUES (1, 'task_lock', '0', 0, 'site');
INSERT INTO `xt_config` VALUES (2, 'mail_id', '2', 0, 'site');
INSERT INTO `xt_config` VALUES (3, 'site_name', '通用后台', 0, 'site');
INSERT INTO `xt_config` VALUES (4, 'site_name_app', '通用后台', 0, 'site');

-- ----------------------------
-- Table structure for xt_error_log
-- ----------------------------
DROP TABLE IF EXISTS `xt_error_log`;
CREATE TABLE `xt_error_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `appid` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `device` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备号',
  `version` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `user_model` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户端手机型号',
  `ip` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP地址',
  `type` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '错误类别 如小说内容解密等等',
  `data` varchar(3000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '参数信息，错误信息等等',
  `create_time` int(10) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '错误日志' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_error_log
-- ----------------------------

-- ----------------------------
-- Table structure for xt_mail_config
-- ----------------------------
DROP TABLE IF EXISTS `xt_mail_config`;
CREATE TABLE `xt_mail_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `secure_account` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '安全邮箱',
  `password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '账户带的电话',
  `app_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'app密码',
  `bind_mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '绑定的电话',
  `type` tinyint(3) NOT NULL DEFAULT 0 COMMENT '0：发验证码 1：发广告',
  `security_code` tinytext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '安全密码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮箱配置' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_mail_config
-- ----------------------------
INSERT INTO `xt_mail_config` VALUES (1, 'henrygentlenmv87@gmail.com', 'henrygentlenmv@gmail.com', 'HPrtz45U96Yx', '‪(681) 539-0488‬', 'kwkedaygxuyuzlor', '‪(681) 539-0488‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (2, 'devorahlehner@gmail.com', 'rosswelchphd8203@outlook.com', '71WFE4huc8zX', '(864) 719-2462', '', '', 0, '备用');
INSERT INTO `xt_mail_config` VALUES (3, 'cariheitingeii27@gmail.com', 'cariheitingeii@gmail.com', '4rVua0jZL1P8', '‪(209) 701-3524‬', 'fzeyfpkdkkaamfxv', '(864) 719-2462', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (4, 'raleighsoapescfv56@gmail.com', 'raleighsoapescfv@gmail.com', 'H95qj3wWxOC7', '‪(224) 244-7327‬', '', '', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (5, 'kazukorostqmy60@gmail.com', 'kazukorostqmy@gmail.com', '4rVua0jZL1P8', '‪(424) 226-2656‬', 'zfrdyzzpfbbisstf', '‪(224) 244-7327‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (6, 'claytonmarchioriolg59@gmail.com', 'claytonmarchioriolg@gmail.com', '7156pQHfTauS', '‪(864) 869-8858‬', 'nehanweawigbfphb', '‪(424) 226-2656‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (7, 'johnathanklettveb15@gmail.com', 'johnathanklettveb@gmail.com', 'KlNp30Y8yCg5', '‪(256) 299-7975‬', 'mxsknqraehjpygvw', '‪(864) 869-8858‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (8, 'renitaschwanndh38@gmail.com', 'renitaschwanndh@gmail.com', 'nA2jR61iC5mT', '‪(803) 820-9181‬', 'dghepnvndmlanbzz', '‪(256) 299-7975‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (9, 'enriquehaugrudzak17@gmail.com', 'enriquehaugrudzak@gmail.com', 'NBj42w6ze5IF', '(262) 421-6013‬', 'vigfmsjzzlqetklb', '‪(803) 820-9181‬', 0, NULL);
INSERT INTO `xt_mail_config` VALUES (10, 'arturorehderhtm24@gmail.com', 'arturorehderhtm@gmail.com', 'rXo7M3k40KlC', '‪(662) 434-4646‬', 'zugnqtdfhpixtdhk', '(262) 421-6013‬', 0, NULL);

-- ----------------------------
-- Table structure for xt_online_customer_service
-- ----------------------------
DROP TABLE IF EXISTS `xt_online_customer_service`;
CREATE TABLE `xt_online_customer_service`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xt_online_customer_service
-- ----------------------------

-- ----------------------------
-- Table structure for xt_powerteam
-- ----------------------------
DROP TABLE IF EXISTS `xt_powerteam`;
CREATE TABLE `xt_powerteam`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `powerteam` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '权限组',
  `power` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限,以一个数组的形式保存',
  `describe` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '权限组说明',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_powerteam
-- ----------------------------
INSERT INTO `xt_powerteam` VALUES (1, '超级管理员', '[\"1,2,3,4,5\"]', '超级管理员');

-- ----------------------------
-- Table structure for xt_test
-- ----------------------------
DROP TABLE IF EXISTS `xt_test`;
CREATE TABLE `xt_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of xt_test
-- ----------------------------

-- ----------------------------
-- Table structure for xt_user
-- ----------------------------
DROP TABLE IF EXISTS `xt_user`;
CREATE TABLE `xt_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `third_token` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '第三方唯一标识',
  `third_type` tinyint(2) UNSIGNED NULL DEFAULT 0 COMMENT '1facebook2twitter3google',
  `email` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱',
  `user_type` tinyint(3) NULL DEFAULT 0 COMMENT '0:普通会员1:VIP',
  `passwd` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '密码',
  `nickname` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称',
  `realname` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '真实名字',
  `birthday` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '生日',
  `token` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '登录生成token验证',
  `gender` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '性别0:未知1:男2:女',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像',
  `invite_code` char(24) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邀请码',
  `register_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '注册时间',
  `register_ip` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '注册IP',
  `last_time` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '最后登录时间',
  `last_ip` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_num` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '登录次数',
  `site` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '1:安卓2:IOS',
  `user_lock` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '用户锁定1锁定0正常',
  `coupon` float(10, 2) UNSIGNED NULL DEFAULT 0.00 COMMENT '用户书券数',
  `auto_buy` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '1:开启了自动购买 0：未开启',
  `time_zone` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'GMT+8' COMMENT '默认中国时区东八区',
  `ip_zone` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT 'IP地区',
  `country` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '国家',
  `language` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '语言',
  `language_use` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '用户设置的语言',
  `channel` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'google' COMMENT '渠道',
  `google_device_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '谷歌推送token',
  `device` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '设备device',
  `appid` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT 'app表的id',
  `hare_user_id` int(11) NULL DEFAULT 0,
  `order_money` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '用户充值总金额',
  `google_ad_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '谷歌广告ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `invite_code`(`invite_code` ASC) USING BTREE,
  INDEX `mobile`(`email` ASC) USING BTREE,
  INDEX `nickname`(`nickname` ASC) USING BTREE,
  INDEX `language`(`language` ASC) USING BTREE,
  INDEX `channel`(`channel` ASC) USING BTREE,
  INDEX `country`(`country` ASC) USING BTREE,
  INDEX `google_device_token`(`google_device_token` ASC) USING BTREE,
  INDEX `gender`(`gender` ASC) USING BTREE,
  INDEX `register_time`(`register_time` ASC) USING BTREE,
  INDEX `last_time`(`last_time` ASC) USING BTREE,
  INDEX `appid`(`appid` ASC) USING BTREE,
  INDEX `hare_user_id`(`hare_user_id` ASC) USING BTREE,
  INDEX `device`(`device` ASC) USING BTREE,
  INDEX `order_money`(`order_money` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10017 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_user
-- ----------------------------
INSERT INTO `xt_user` VALUES (10000, '', 0, '', 0, '', 'HONOR  JSN-AL00', '', '', 'bc9ca783d104288f786a25b888064584', 0, '', 'CK573', 1606211626, '1.83.26.173', 1606980313, '36.46.163.196', 9, 1, 0, 74.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', '', 'b23960b403994366', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10001, '', 0, '', 0, '', 'samsung  SM-J400F', '', '', '7a9f6d6ca840db93936e8492929480f9', 0, '', '2R2VE', 1606213321, '1.83.26.230', 1606969123, '36.47.130.36', 8, 1, 0, 96.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', '', 'a3b9e08309e0e04f', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10002, '', 0, '', 0, '', '', '', '', 'ca46b69fe1afd1e1f072f9bce245f55e', 0, '', 'MEZ7S', 1606213548, '170.178.177.178', 1606978100, '36.46.163.196', 6, 1, 0, 7.00, 0, 'GMT+08:00', '美国 洛杉矶', '美国', 'english', 'english', 'google', 'd8TPjdUfTweEwIysTKhgRz:APA91bEaaNYfqUc7QyM6RZaMPWnBB8RygV-VoSdzNMspGtF_B-ZykRYqqCVojgt2InpzCV_VaB1VDUsPe24d-c0fkl_R20F1ieN8qSroPiQFLm_9t3B0A1oBw9gV9CUuG62-KmB9ECRd', '6c2fe77b42710649', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10003, '', 0, '', 0, '', '', '', '', '3f9312def57ca9f767c60ddb12f33970', 0, '', '8LR93', 1606214159, '45.76.170.52', 1606727134, '36.44.170.136', 4, 1, 0, 2.00, 0, 'GMT+08:00', '美国 洛杉矶', '美国', 'english', 'english', 'google', '', '59c3d4152b6f4477', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10004, '', 0, '', 0, '', '', '', '', '2965d9662ad43776f60ae4336ba9da33', 0, '', 'TSYBA', 1606214528, '1.83.26.173', 1606908475, '36.47.130.87', 5, 1, 0, 8.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', 'eAB6oMBySJCQvFzW5k3AdY:APA91bE_fIi9NsP_zad6te0Ab9SIy2qmCplk0DKS0pOHSGW_0p0PmRmlMJgyVqiGm76f-ioZTPM2RUj9zPohgR5QWvoWE6RJzWtCCpRM39VTauGYpoD59PiYLcOhxcpaIK11rRQKJ1zW', '6edf31c29970d78c', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10005, '', 0, '', 0, '', '', '', '', '185a3ef15cfefaa2c7d6e5e1c75da7e2', 0, '', '5PZ5V', 1606216016, '1.83.26.173', 1606965335, '36.44.168.81', 2, 1, 0, 25.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', 'dbkBVkliSs2QwPLp9Us9aL:APA91bHZlOmwjjrnOGXi79fICVsGP1Iuf7txVn85gKGSwOy4pDQ8mFp8G88tn7woNOMd0uhZuHJu1K1viUGjoCE6g-euPxpQhIOqpdN9pT95mjrfrfrs5l6wu-CCjs2K7HJHfTOHO1un', '1ca176eddc77700', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10006, '', 0, '', 0, '', '', '', '', 'ce0ab51fca1109c285d4ce53df6b6e12', 0, '', 'E4TVE', 1606272138, '47.240.102.98', 1606297632, '149.129.125.179', 1, 1, 0, 3.00, 0, 'GMT+08:00', '中国 北京', '中国', 'english', 'english', 'google', '', 'aba36943a95351ad', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10007, '', 0, '', 0, '', '', '', '', 'be534591cf9fbc16a1ca25a3f999a802', 0, '', 'ZW9KD', 1606466694, '74.125.210.76', 1606467496, '74.125.210.76', 1, 1, 0, 3.00, 0, 'GMT+00:00', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', '607264fa59b8c1df', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10008, '', 0, '', 0, '', '', '', '', 'bab38a753abd7dfe62b563a15c588558', 0, '', 'EE22H', 1606467964, '108.177.6.58', 1606467964, '108.177.6.58', 1, 1, 0, 0.00, 0, 'PST', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', '4366461f92513537', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10009, '', 0, '', 0, '', '', '', '', '5cb2b5ceb1b62ac254aae62c745aa4fd', 0, '', 'SBDV9', 1606468011, '108.177.7.94', 1606468011, '108.177.7.94', 1, 1, 0, 0.00, 0, 'PST', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', 'b70dc500088adf70', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10010, '', 0, '', 0, '', '', '', '', '3939866fa523356ceeff8c9e8d746f91', 0, '', '6RESM', 1606468233, '108.177.6.57', 1606468322, '108.177.6.57', 1, 1, 0, 3.00, 0, 'PST', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', 'd37f5a999f8823ef', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10011, '', 0, '', 0, '', '', '', '', 'de6ef2d174118d80a502a67f3fa2b1cb', 0, '', 'KKUZ4', 1606468375, '108.177.7.86', 1606468375, '108.177.7.86', 1, 1, 0, 0.00, 0, 'GMT+09:00', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', '8ec4ffb4a48cf32a', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10012, '', 0, '', 0, '', '', '', '', '00dbfd526c25100d384232ff7ff29fc5', 0, '', '5KMG4', 1606470559, '52.11.208.27', 1606920418, '52.11.208.27', 2, 1, 0, 0.00, 0, 'EST', '美国 波特蘭', '美国', 'english', 'english', 'google', '', '000000000000000', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10013, '', 0, '', 0, '', '', '', '', 'fb9647348994491db14ad6b2ce0afb56', 0, '', 'ER629', 1606721871, '36.46.160.62', 1606807927, '36.44.171.70', 2, 1, 0, 0.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', '', '9ebe8bc9498a5484', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10014, '', 0, '', 0, '', '', '', '', '3057178c2d2c2ef433b039a6ff79876d', 0, '', 'RLVFR', 1606817704, '49.36.41.211', 1606817705, '49.36.41.211', 1, 1, 0, 0.00, 0, 'IST', '印度 印多尔', '印度', 'english', 'english', 'google', '', '86a02a80ae5897f1', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10015, '', 0, '', 0, '', 'Xiaomi  Redmi 4A', '', '', 'e685ab9888ad1fc9a3b76291d30d60f9', 0, '', 'L3WGZ', 1606881626, '36.44.168.81', 1606881629, '36.44.168.81', 1, 1, 0, 3.00, 0, 'GMT+08:00', '中国 西安', '中国', 'english', 'english', 'google', '', '604babcec9c88442', 1, 0, 0.00, '0');
INSERT INTO `xt_user` VALUES (10016, '', 0, '', 0, '', 'Nexus 5X', '', '', '9c95276ddb3bafafb2eec8163a2ade43', 0, '', 'RCCEW', 1606915350, '66.249.80.249', 1606915973, '66.249.80.249', 1, 1, 0, 3.00, 0, 'GMT+00:00', '加拿大 蒙特利尔', '加拿大', 'english', 'english', 'google', '', '98cf1828337f99ca', 1, 0, 0.00, '0');

-- ----------------------------
-- Table structure for xt_user_login_log
-- ----------------------------
DROP TABLE IF EXISTS `xt_user_login_log`;
CREATE TABLE `xt_user_login_log`  (
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `third_token` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '第三方唯一标识',
  `third_type` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1facebook2twitter3google',
  `email` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `nickname` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `login_time` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后登录时间',
  `login_ip` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `channel` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'google' COMMENT '渠道',
  `device` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '设备device',
  `appid` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'app表的id',
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `third_token`(`third_token` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of xt_user_login_log
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
