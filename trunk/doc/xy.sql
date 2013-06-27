/*
Navicat MySQL Data Transfer

Source Server         : connect
Source Server Version : 50519
Source Host           : localhost:3306
Source Database       : xy

Target Server Type    : MYSQL
Target Server Version : 50519
File Encoding         : 65001

Date: 2013-06-27 14:36:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `xy_actor`
-- ----------------------------
DROP TABLE IF EXISTS `xy_actor`;
CREATE TABLE `xy_actor` (
  `actor_id` int(11) NOT NULL COMMENT '角色id',
  `actor_user` varchar(32) NOT NULL COMMENT '所属用户',
  `actor_pname` varchar(64) NOT NULL COMMENT '角色昵称',
  `actor_job` varchar(32) NOT NULL COMMENT '身份',
  `actor_vocational` tinyint(4) NOT NULL COMMENT '角色职业',
  `actor_sex` tinyint(4) NOT NULL COMMENT '角色性别',
  `actor_grade` int(11) NOT NULL COMMENT '角色等级',
  `actor_attack_min` int(11) NOT NULL COMMENT ' 攻击力最小值',
  `actor_attack_max` int(11) NOT NULL COMMENT '攻击力最大值',
  `actor_mattack_min` int(11) NOT NULL COMMENT '魔法攻击力最小值',
  `actor_mattack_max` int(11) NOT NULL COMMENT '魔法攻击力最大值',
  `actor_defense` int(11) NOT NULL COMMENT '防御',
  `actor_mdefense` int(11) NOT NULL COMMENT '魔防',
  `actor_hit` int(11) NOT NULL COMMENT '命中',
  `actor_dodge` int(11) NOT NULL COMMENT '躲闪',
  `actor_batter` int(11) NOT NULL,
  `actor_crit` int(11) NOT NULL COMMENT '暴击',
  `actor_attack_speed` int(11) NOT NULL COMMENT '攻击速度',
  `actor_attack_addition` int(11) NOT NULL COMMENT '攻击加成',
  `actor_mattack_addition` int(11) NOT NULL COMMENT '魔法攻击加成',
  `actor_speed` int(11) NOT NULL COMMENT '角色行动速度',
  `actor_hp_max` int(11) NOT NULL COMMENT '角色血值',
  `actor_hp` int(11) NOT NULL COMMENT '角色当前血量',
  `actor_mp_max` int(11) NOT NULL COMMENT '角色魔值',
  `actor_mp` int(11) NOT NULL COMMENT '角色当前魔法',
  `actor_exp` int(11) NOT NULL COMMENT '角色经验值',
  `actor_money` varchar(32) NOT NULL COMMENT '角色金钱',
  `actor_screen` int(11) NOT NULL COMMENT '角色所在场景',
  `actor_x` int(11) NOT NULL COMMENT '角色位置X',
  `actor_y` int(11) NOT NULL COMMENT '角色位置y',
  `actor_faction` int(11) NOT NULL,
  PRIMARY KEY (`actor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_actor
-- ----------------------------

-- ----------------------------
-- Table structure for `xy_config`
-- ----------------------------
DROP TABLE IF EXISTS `xy_config`;
CREATE TABLE `xy_config` (
  `config_id` int(11) NOT NULL COMMENT '1角色sequence 2物品sequence 3宠物sequence',
  `config_value` varchar(64) NOT NULL,
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_config
-- ----------------------------
INSERT INTO `xy_config` VALUES ('1', '1');
INSERT INTO `xy_config` VALUES ('2', '1');
INSERT INTO `xy_config` VALUES ('3', '1');

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
-- Table structure for `xy_pet`
-- ----------------------------
DROP TABLE IF EXISTS `xy_pet`;
CREATE TABLE `xy_pet` (
  `pet_id` int(11) NOT NULL COMMENT '宠物ID',
  `pet_master_actor` varchar(32) NOT NULL COMMENT '宠物所属角色',
  `pet_fight` int(11) NOT NULL COMMENT '是否参战',
  `pet_grade` int(11) NOT NULL COMMENT '宠物等级',
  `pet_attack_min` int(11) NOT NULL COMMENT '最小攻击',
  `pet_attack_max` int(11) NOT NULL COMMENT '最大攻击',
  `pet_mattack_min` int(11) NOT NULL COMMENT '最小魔法攻击',
  `pet_mattack_max` int(11) NOT NULL COMMENT '最大魔法攻击',
  `pet_defense` int(11) NOT NULL COMMENT '防御',
  `pet_mdefense` int(11) NOT NULL COMMENT '魔防',
  `pet_loyalty` int(11) NOT NULL,
  `pet_hit` int(11) NOT NULL COMMENT '命中',
  `pet_dodge` int(11) NOT NULL COMMENT '躲闪',
  `pet_crit` int(11) NOT NULL COMMENT '暴击',
  `pet_batter` int(11) NOT NULL,
  `pet_attack_speed` int(11) NOT NULL COMMENT '攻击速度',
  `pet_hp_max` int(11) NOT NULL COMMENT '血槽',
  `pet_hp` int(11) NOT NULL COMMENT '血量',
  `pet_mp_max` int(11) NOT NULL COMMENT '魔槽',
  `pet_mp` int(11) NOT NULL COMMENT '魔量',
  `pet_exp` int(11) NOT NULL COMMENT '经验',
  `pet_attack_talent` int(11) NOT NULL COMMENT '攻击天赋',
  `pet_mattack_talent` int(11) NOT NULL COMMENT '魔法攻击天赋',
  `pet_defense_talent` int(11) NOT NULL COMMENT '防御天赋',
  `pet_mdefense_talent` int(11) NOT NULL COMMENT '魔法防御天赋',
  `pet_hp_talent` int(11) NOT NULL COMMENT '血量天赋',
  `pet_mp_talent` int(11) NOT NULL COMMENT '魔量天赋',
  `pet_attack_speed_talent` int(11) NOT NULL COMMENT '攻击速度天赋',
  PRIMARY KEY (`pet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_pet
-- ----------------------------

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

-- ----------------------------
-- Table structure for `xy_user`
-- ----------------------------
DROP TABLE IF EXISTS `xy_user`;
CREATE TABLE `xy_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) NOT NULL,
  `user_password` varchar(32) NOT NULL,
  `user_money` varchar(32) NOT NULL,
  `user_status` int(4) NOT NULL,
  `user_key` varchar(64) NOT NULL,
  `user_register_time` varchar(64) NOT NULL,
  `user_login_time` varchar(64) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of xy_user
-- ----------------------------
