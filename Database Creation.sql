# Max Zoubkov


# all prices and revenue are in cents
# can implement statuses as enums instead
# friend table could be implemented to be easier to manage/query
DROP DATABASE Rockfish;

CREATE DATABASE Rockfish;
USE Rockfish;


CREATE TABLE `country` (
  `id` smallint PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL UNIQUE
);

CREATE TABLE `user` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE,
  `first_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `country_id` smallint NOT NULL,
  `created` timestamp DEFAULT current_timestamp()
);

CREATE TABLE `friend` (
  `user1_id` bigint NOT NULL,
  `user2_id` bigint NOT NULL,
  `created` timestamp DEFAULT current_timestamp()
);

CREATE TABLE `post` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `parent_id` bigint DEFAULT NULL,
  `user_id` bigint,
  `content` varchar(255) NOT NULL,
  `created` timestamp DEFAULT current_timestamp()
);

CREATE TABLE `merchant` (
  `id` int AUTO_INCREMENT,
  `country_id` smallint,
  `name` varchar(255) NOT NULL UNIQUE,
  PRIMARY KEY (id, country_id)
);

CREATE TABLE `ad` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `merchant_id` int,
  `revenue_per_click` smallint NOT NULL
);

CREATE TABLE `ad_delivery` (
  `ad_id` bigint,
  `user_id` bigint,
  `clicked` boolean,
  `sent` timestamp DEFAULT current_timestamp()
);

CREATE TABLE `product` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `merchant_id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int DEFAULT null,
  `status` varchar(255) NOT NULL
);

CREATE TABLE `order` (
  `id` bigint PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `status` varchar(255) NOT NULL,
  `created` timestamp DEFAULT current_timestamp()
);

CREATE TABLE `order_content` (
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `amount` tinyint DEFAULT 1
);

CREATE TABLE `sales` (
  `merchant_id` int,
  `month_year` varchar(255) NOT NULL,
  `start_month_year` date NOT NULL,
  `end_month_year` date NOT NULL,
  `total_revenue` bigint DEFAULT 0,
  `last_updated` timestamp DEFAULT current_timestamp()
);

ALTER TABLE `user` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE;

ALTER TABLE `friend` ADD FOREIGN KEY (`user1_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `friend` ADD FOREIGN KEY (`user2_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `post` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `post` ADD FOREIGN KEY (`parent_id`) REFERENCES `post` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `merchant` ADD FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON UPDATE CASCADE;

ALTER TABLE `ad` ADD FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `product` ADD FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `order` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `order_content` ADD FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `order_content` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `ad_delivery` ADD FOREIGN KEY (`ad_id`) REFERENCES `ad` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `ad_delivery` ADD FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;

ALTER TABLE `sales` ADD FOREIGN KEY (`merchant_id`) REFERENCES `merchant` (`id`) ON UPDATE CASCADE ON DELETE SET NULL;


