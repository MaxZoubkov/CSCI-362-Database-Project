# Retrieve a user's (Mohammed's) ordered products and amount
USE Rockfish;
SELECT `user`.`first_name` AS `first name`, `user`.`last_name` AS `last name`, `product`.`id` AS `item id`, `product`.`name` AS `item`, SUM(`order_content`.`amount`) AS `amount purchased`
FROM `user`
	INNER JOIN `order` ON `order`.`user_id` = `user`.`id`
	INNER JOIN `order_content` ON `order_content`.`order_id` = `order`.`id`
	INNER JOIN `product` ON `product`.`id` = `order_content`.`product_id`
WHERE
	`user`.`first_name` = "Mohammed"
GROUP BY `product`.`id`;	# if there are multiple orders containing the same product, the summed amount of that product will be shown


# Show how many times a user (Satoshi) clicked each ad they received
USE Rockfish;
SELECT `user`.`first_name` AS `first name`, `user`.`last_name` AS `last name`, `ad`.`id` AS `advertisement id`, `merchant`.`name` AS `advertiser`, SUM(`ad_delivery`.`clicked`) AS `times clicked`
FROM `user`
	INNER JOIN `ad_delivery` ON `ad_delivery`.`user_id` = `user`.`id`
	INNER JOIN `ad` ON `ad`.`id` = `ad_delivery`.`ad_id`
	INNER JOIN `merchant` ON `merchant`.`id` = `ad`.`merchant_id`
WHERE
	`user`.`first_name` = "Satoshi"
GROUP BY `ad`.`id`;


# Show a user's (Bob's) friends
USE Rockfish;
# Get user's id first
SELECT `user`.`id` INTO @v1 FROM `user` WHERE `first_name` = "Bob";
SELECT `u1`.`first_name` AS `user1 first name`, `u2`.`first_name` AS `user2 first name`
FROM `friend` AS `f`
	INNER JOIN `user` AS `u1` ON `u1`.`id` = `f`.`user1_id`
	INNER JOIN `user` AS `u2` ON `u2`.`id` = `f`.`user2_id`
WHERE
	(`f`.`user1_id` = @v1 OR `f`.`user2_id` = @v1);



# Show how much of a merchant's products are sold and the revenue generated
USE Rockfish;
SELECT `merchant`.`name` AS `seller`, `product`.`name` AS `item`, SUM(`order_content`.`amount`) AS `amount sold`, `product`.`price`*SUM(`order_content`.`amount`)/100.00 AS `total sales`
FROM `merchant`
	INNER JOIN `product` ON `product`.`merchant_id` = `merchant`.`id`
    INNER JOIN `order_content` ON `order_content`.`product_id` = `product`.`id`
WHERE
	`merchant`.`name` = "Imran Export" OR `merchant`.`name` = "Imran International"
GROUP BY `product`.`id`;
