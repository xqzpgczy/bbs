/*
 Navicat Premium Data Transfer

 Source Server         : 本机mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : flask_demo

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 28/05/2022 20:28:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `body` text COLLATE utf8mb4_general_ci,
  `body_html` text COLLATE utf8mb4_general_ci,
  `timestamp` datetime DEFAULT NULL,
  `author_id` int DEFAULT NULL,
  `author_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `author_email` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notify` tinyint(1) DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  `reply_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  KEY `post_id` (`post_id`),
  KEY `reply_id` (`reply_id`),
  KEY `parent_id` (`parent_id`),
  KEY `ix_comments_timestamp` (`timestamp`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`reply_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_ibfk_4` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`),
  CONSTRAINT `comments_chk_1` CHECK ((`notify` in (0,1))),
  CONSTRAINT `comments_chk_2` CHECK ((`approved` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
BEGIN;
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (1, '测试评论', '<p>测试评论</p>', '2022-05-23 13:54:13', 1, NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (2, '测试评论2', '<p>测试评论2</p>', '2022-05-23 13:54:32', 1, NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (3, '用户2 测试', '<p>用户2 测试</p>', '2022-05-23 13:57:42', 2, NULL, NULL, 1, 1, 1, 2, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (4, '用户2 继续测试', '<p>用户2 继续测试</p>', '2022-05-23 13:58:11', 2, NULL, NULL, 1, 1, 1, 1, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (5, '测试  测试', '<p>测试  测试</p>', '2022-05-23 13:58:33', 1, NULL, NULL, 1, 1, 1, 3, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (6, '用户2 测试', '<p>用户2 测试</p>', '2022-05-23 14:00:18', 2, NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (7, '测试评论', '<p>测试评论</p>', '2022-05-24 05:04:49', 2, NULL, NULL, 1, 1, 5, NULL, NULL);
INSERT INTO `comments` (`id`, `body`, `body_html`, `timestamp`, `author_id`, `author_name`, `author_email`, `notify`, `approved`, `post_id`, `reply_id`, `parent_id`) VALUES (8, '测试评论', '<p>测试评论</p>', '2022-05-24 05:08:18', 2, NULL, NULL, 1, 1, 6, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  `unread` tinyint(1) NOT NULL,
  `sender` int DEFAULT NULL,
  `sender_email` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `receiver` int DEFAULT NULL,
  `target_id` int DEFAULT NULL,
  `target_type` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sender` (`sender`),
  KEY `receiver` (`receiver`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`sender`) REFERENCES `user` (`id`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`receiver`) REFERENCES `user` (`id`),
  CONSTRAINT `message_chk_1` CHECK ((`unread` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of message
-- ----------------------------
BEGIN;
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (1, 'add comment', '2022-05-23 13:54:13', 1, 1, NULL, 1, 1, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (2, 'add comment', '2022-05-23 13:54:32', 1, 1, NULL, 1, 1, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (3, 'reply comment', '2022-05-23 13:57:42', 1, 2, NULL, 1, 2, 'comment');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (4, 'approve comment', '2022-05-23 13:57:47', 1, 2, NULL, 1, 2, 'comment');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (5, 'reply comment', '2022-05-23 13:58:11', 1, 2, NULL, 1, 1, 'comment');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (6, 'add comment', '2022-05-23 13:58:33', 1, 1, NULL, 1, 1, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (7, 'reply comment', '2022-05-23 13:58:33', 1, 1, NULL, 2, 3, 'comment');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (8, 'approve post', '2022-05-23 14:00:08', 1, 2, NULL, 1, 1, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (9, 'add comment', '2022-05-23 14:00:18', 1, 2, NULL, 1, 1, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (10, 'add comment', '2022-05-24 05:04:49', 1, 2, NULL, 2, 5, 'post');
INSERT INTO `message` (`id`, `action`, `timestamp`, `unread`, `sender`, `sender_email`, `receiver`, `target_id`, `target_type`) VALUES (11, 'add comment', '2022-05-24 05:08:18', 1, 2, NULL, 2, 6, 'post');
COMMIT;

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(128) COLLATE utf8mb4_general_ci NOT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `user_id` int DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of post
-- ----------------------------
BEGIN;
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (1, '测试文章1', '<p>测试文章测试文章测试文章测试文章测试文章测试文章</p>\r\n', 1, '2022-05-23 13:53:58');
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (2, '测试文章2', '<p><strong>测试文章测试文章测试文章测试文章测试文章</strong></p>\r\n', 1, '2022-05-23 13:59:28');
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (3, '测试富文本', '<p>测试文档&nbsp; &nbsp;</p>', 2, '2022-05-23 16:59:19');
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (4, '测试图片上传', '<p><img alt=\"\" src=\"/images/files/D092A707-AB3C-475F-B793-56B88ECFD630.png\" style=\"height:47px; width:60px\" />&nbsp;测试图片上传</p>\r\n', 2, '2022-05-24 04:36:35');
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (5, '测试图片3', '<p><img alt=\"\" src=\"/images/files/D092A707-AB3C-475F-B793-56B88ECFD630.png\" style=\"height:718px; width:914px\" /></p>\r\n', 2, '2022-05-24 05:04:34');
INSERT INTO `post` (`id`, `title`, `description`, `user_id`, `date`) VALUES (6, '测试上传图片4', '<p><img alt=\"\" src=\"/images/files/D092A707-AB3C-475F-B793-56B88ECFD630.png\" style=\"height:79px; width:100px\" />www www</p>\r\n', 2, '2022-05-24 05:08:10');
COMMIT;

-- ----------------------------
-- Table structure for post_tag
-- ----------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag` (
  `tag_id` int DEFAULT NULL,
  `post_id` int DEFAULT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `post_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `post_tag_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of post_tag
-- ----------------------------
BEGIN;
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 1);
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 2);
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 3);
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 4);
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 5);
INSERT INTO `post_tag` (`tag_id`, `post_id`) VALUES (1, 6);
COMMIT;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  `creator_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `creator_id` (`creator_id`),
  CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `user` (`id`),
  CONSTRAINT `tag_chk_1` CHECK ((`is_valid` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of tag
-- ----------------------------
BEGIN;
INSERT INTO `tag` (`id`, `name`, `description`, `created_time`, `is_valid`, `creator_id`) VALUES (1, '测试', NULL, '2022-05-23 13:53:58', 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `username` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
  `is_admin` tinyint(1) DEFAULT NULL,
  `password_hash` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `location` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bio` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `member_since` datetime DEFAULT NULL,
  `avatar_hash` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ix_user_username` (`username`),
  UNIQUE KEY `ix_user_email` (`email`),
  CONSTRAINT `user_chk_1` CHECK ((`is_admin` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `email`, `username`, `is_admin`, `password_hash`, `name`, `location`, `bio`, `member_since`, `avatar_hash`) VALUES (1, '625124155@qq.com', 'root', 0, 'pbkdf2:sha256:150000$NE77JbN4$2c3259b982a6031c7e80bb449a4c1f7e9fdd63059696005785d64031f26d10c9', NULL, NULL, NULL, '2022-05-23 13:43:13', 'e236d8a642295e914a2ac64c41d558d0');
INSERT INTO `user` (`id`, `email`, `username`, `is_admin`, `password_hash`, `name`, `location`, `bio`, `member_since`, `avatar_hash`) VALUES (2, '625124156@qq.com', 'root1', 0, 'pbkdf2:sha256:150000$YeLLnf7Y$d37e4118eaed4633317e2bd5a3d3223ffefdecd4fad7cd29d6b927cc58b87e2f', NULL, NULL, NULL, '2022-05-23 13:55:43', '174f1cd8abd4a32a70c63d8cdc7e4717');
INSERT INTO `user` (`id`, `email`, `username`, `is_admin`, `password_hash`, `name`, `location`, `bio`, `member_since`, `avatar_hash`) VALUES (3, '625124157@qq.com', 'root2', NULL, 'pbkdf2:sha256:150000$w7eW3mHE$09650eb6b237af5a4e3321be96bec230f934b215256195f594e4001598053aad', NULL, NULL, NULL, '2022-05-24 05:10:01', 'a375ead244bc2af183b48588a9d24bac');
COMMIT;

-- ----------------------------
-- Table structure for user_approve
-- ----------------------------
DROP TABLE IF EXISTS `user_approve`;
CREATE TABLE `user_approve` (
  `id` int NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `approved` tinyint(1) DEFAULT NULL,
  `target_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `ix_user_approve_timestamp` (`timestamp`),
  CONSTRAINT `user_approve_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_approve_chk_1` CHECK ((`approved` in (0,1)))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user_approve
-- ----------------------------
BEGIN;
INSERT INTO `user_approve` (`id`, `timestamp`, `user_id`, `approved`, `target_type`, `target_id`) VALUES (1, '2022-05-23 13:57:47', 2, 1, 'comment', 2);
INSERT INTO `user_approve` (`id`, `timestamp`, `user_id`, `approved`, `target_type`, `target_id`) VALUES (2, '2022-05-23 14:00:08', 2, 1, 'post', 1);
COMMIT;

-- ----------------------------
-- Table structure for user_follow
-- ----------------------------
DROP TABLE IF EXISTS `user_follow`;
CREATE TABLE `user_follow` (
  `follower_id` int DEFAULT NULL,
  `followee_id` int DEFAULT NULL,
  KEY `follower_id` (`follower_id`),
  KEY `followee_id` (`followee_id`),
  CONSTRAINT `user_follow_ibfk_1` FOREIGN KEY (`follower_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_follow_ibfk_2` FOREIGN KEY (`followee_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user_follow
-- ----------------------------
BEGIN;
INSERT INTO `user_follow` (`follower_id`, `followee_id`) VALUES (1, 1);
INSERT INTO `user_follow` (`follower_id`, `followee_id`) VALUES (2, 2);
INSERT INTO `user_follow` (`follower_id`, `followee_id`) VALUES (3, 3);
COMMIT;

-- ----------------------------
-- Table structure for user_tag
-- ----------------------------
DROP TABLE IF EXISTS `user_tag`;
CREATE TABLE `user_tag` (
  `tag_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  KEY `tag_id` (`tag_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_tag_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`),
  CONSTRAINT `user_tag_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of user_tag
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
