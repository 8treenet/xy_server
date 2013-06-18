/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50162
Source Host           : localhost:3306
Source Database       : xy

Target Server Type    : MYSQL
Target Server Version : 50162
File Encoding         : 65001

Date: 2013-06-18 12:07:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xy_actor`
-- ----------------------------
DROP TABLE IF EXISTS `xy_actor`;
CREATE TABLE `xy_actor` (
  `actor_id` varchar(32) NOT NULL,
  `actor_user` varchar(32) NOT NULL,
  `actor_pname` varchar(32) NOT NULL,
  `actor_vocational` tinyint(4) NOT NULL,
  `actor_sex` tinyint(4) NOT NULL,
  `actor_grade` int(11) NOT NULL,
  `actor_hp` int(11) NOT NULL,
  `actor_mp` int(11) NOT NULL,
  `actor_exp` int(11) NOT NULL,
  `actor_money` varchar(32) NOT NULL,
  `actor_screen` int(11) NOT NULL,
  `actor_x` int(11) NOT NULL,
  `actor_y` int(11) NOT NULL,
  `actor_speed` int(11) NOT NULL,
  PRIMARY KEY (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_actor
-- ----------------------------

-- ----------------------------
-- Table structure for `xy_ip`
-- ----------------------------
DROP TABLE IF EXISTS `xy_ip`;
CREATE TABLE `xy_ip` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip_addr` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_ip
-- ----------------------------
INSERT INTO `xy_ip` VALUES ('5', '127.0.0.1');
INSERT INTO `xy_ip` VALUES ('6', '127.0.0.2');

-- ----------------------------
-- Table structure for `xy_server`
-- ----------------------------
DROP TABLE IF EXISTS `xy_server`;
CREATE TABLE `xy_server` (
  `server_id` int(11) NOT NULL,
  `server_name` varchar(64) CHARACTER SET latin1 NOT NULL,
  `server_address` varchar(64) CHARACTER SET latin1 NOT NULL,
  `server_actors_number` int(11) NOT NULL,
  PRIMARY KEY (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_server
-- ----------------------------
INSERT INTO `xy_server` VALUES ('1', '王者大陆(网通)', '127.0.0.1', '0');
INSERT INTO `xy_server` VALUES ('2', '水帘洞(电信)', '123,234,123,45', '800');

-- ----------------------------
-- Table structure for `xy_user`
-- ----------------------------
DROP TABLE IF EXISTS `xy_user`;
CREATE TABLE `xy_user` (
  `user_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) CHARACTER SET latin1 NOT NULL,
  `user_password` varchar(32) CHARACTER SET latin1 NOT NULL,
  `user_money` varchar(32) CHARACTER SET latin1 NOT NULL,
  `user_status` int(4) NOT NULL,
  `user_key` varchar(64) CHARACTER SET latin1 NOT NULL,
  `user_register_time` varchar(64) CHARACTER SET latin1 NOT NULL,
  `user_login_time` varchar(64) CHARACTER SET latin1 NOT NULL,
  `user_online` varchar(8) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_user
-- ----------------------------
