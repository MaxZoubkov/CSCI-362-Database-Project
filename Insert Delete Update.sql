# Max Zoubkov
# Delete Portion and Modify Portion are commented out, uncomment to test them! Modify Portion relies on originally inserted data.


# INSERTION PORTION

# country table
USE Rockfish;
INSERT INTO `country`
	(`name`)
VALUES
	("United States of America"),
    ("India"),
    ("United Kingdom"),
    ("Canada"),
    ("France"),
    ("Japan"),
	("International");

# user table
USE Rockfish;
INSERT INTO `user`
	(`email`, `first_name`, `last_name`, `country_id`)
VALUES
	("bob123@sample.com",
     "Bob",
	 "Johnson",
     (SELECT `id` FROM `country` WHERE `name` = "United States of America") ),

	("mdhar@sample.com",
     "Mohammed",
     "Dhar", 
	 (SELECT `id` FROM `country` WHERE `name` = "India") ),

	("nakamoto@sample.com",
     "Satoshi",
     "Nakamoto",
	 (SELECT `id` FROM `country` WHERE `name` = "Japan") ),

	("mikemccauley@sample.com",
     "Michael",
     "McCauley",
	 (SELECT `id` FROM `country` WHERE `name` = "Canada") ),

	("karthy@sample.com",
     "Jimmy",
     "Karth",
	 (SELECT `id` FROM `country` WHERE `name` = "United Kingdom") ),

	("louis@sample.com",
     "Louis",
	 "Garcia",
	 (SELECT `id` FROM `country` WHERE `name` = "France") );
     
     
# friend bridge table
USE Rockfish;
INSERT INTO `friend`
	(`user1_id`, `user2_id`)
VALUES
	((SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Bob") ),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Bob"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Satoshi") ),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Louis") ),
	
    ((SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Michael") ),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Jimmy"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Louis") );
    

# post table
USE Rockfish;
INSERT INTO `post`
	(`user_id`, `parent_id`, `content`)
VALUES
    ((SELECT `id` FROM `user` WHERE `first_name` = "Bob"),
     DEFAULT,
     "Hello World!"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
     DEFAULT,
     "This is my first post!"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
     DEFAULT,
     "Bitcoin Whitepaper"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Jimmy"),
     DEFAULT,
     "How do I reply to posts?");
	
# store post's parent_id in variable @v1
SELECT `id` INTO @v1 FROM `post` WHERE `content` = "Hello World!";
INSERT INTO `post`
	(`user_id`, `parent_id`, `content`)
VALUES    
	((SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
     @v1,
     "Hi Bob");
    
    
# merchant table
USE Rockfish;
INSERT INTO `merchant`
	(`id`, `country_id`, `name`)
VALUES
    (DEFAULT,
     (SELECT `id` FROM `country` WHERE `name` = "United States of America"),
     "Bill and Bill"),
     
	(DEFAULT,
     (SELECT `id` FROM `country` WHERE `name` = "India"),
     "Imran Export"),
     
	(DEFAULT,
     (SELECT `id` FROM `country` WHERE `name` = "Japan"),
     "Muji"),
     
	(DEFAULT,
     (SELECT `id` FROM `country` WHERE `name` = "France"),
     "Carte");

# store international company's merchant id in variable @v1
SELECT `id` INTO @v1 FROM `merchant` WHERE `name` = "Bill and Bill";
INSERT INTO `merchant`
	(`id`, `country_id`, `name`)
VALUES
	(@v1,
     (SELECT `id` FROM `country` WHERE `name` = "International"),
     "Bill and Bill International");
     

# ad table
USE Rockfish;
INSERT INTO `ad`
	(`content`, `merchant_id`, `revenue_per_click`)
VALUES
    ("We sell construction materials!",
     (SELECT `id` FROM `merchant` WHERE `name` = "Bill and Bill"),
     002),
     
	("Kitchen Tools Here",
     (SELECT `id` FROM `merchant` WHERE `name` = "Muji"),
     001),
     
	("Best Indian Food",
     (SELECT `id` FROM `merchant` WHERE `name` = "Imran Export"),
     004),
     
	("Handcrafted Jewelery",
     (SELECT `id` FROM `merchant` WHERE `name` = "Carte"),
     003),
     
	("We deliver to all countries!",
	 (SELECT `id` FROM `merchant` WHERE `name` = "Bill and Bill International"),
     001);


# ad_delivery table
USE Rockfish;
INSERT INTO `ad_delivery`
	(`ad_id`, `user_id`, `clicked`)
VALUES
    ((SELECT `id` FROM `ad` WHERE `content` = "Kitchen Tools Here"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
     true),
    
	((SELECT `id` FROM `ad` WHERE `content` = "Kitchen Tools Here"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
     false),
     
	((SELECT `id` FROM `ad` WHERE `content` = "Best Indian Food"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Jimmy"),
     true),
     
	((SELECT `id` FROM `ad` WHERE `content` = "Handcrafted Jewelery"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
     true),
     
	((SELECT `id` FROM `ad` WHERE `content` = "Handcrafted Jewelery"),
     (SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
     true);
     

# product table
USE Rockfish;
INSERT INTO `product`
	(`merchant_id`, `name`, `price`, `status`)
VALUES
    ((SELECT `id` FROM `merchant` WHERE `name` = "Bill and Bill"),
     "Plywood",
     214,
     "Available"),
    
    ((SELECT `id` FROM `merchant` WHERE `name` = "Imran Export"),
     "Rogan Josh Curry",
     399,
     "Available"),

	((SELECT `id` FROM `merchant` WHERE `name` = "Muji"),
     "Sharp Kitchen Knife",
     4000,
     "Out of Stock"),
     
	((SELECT `id` FROM `merchant` WHERE `name` = "Carte"),
     "Amethyst Ring",
     20000,
     "Unavailable"),

	((SELECT `id` FROM `merchant` WHERE `name` = "Imran Export"),
     "Garam Masala",
     800,
     "Available");


# order table
USE Rockfish;
INSERT INTO `order`
	(`user_id`, `status`)
VALUES
	((SELECT `id` FROM `user` WHERE `first_name` = "Mohammed"),
	 "Shipping"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Bob"),
	 "In Transit"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Satoshi"),
	 "Shipping"),

	((SELECT `id` FROM `user` WHERE `first_name` = "Jimmy"),
	 "Shipping"),
     
	((SELECT `id` FROM `user` WHERE `first_name` = "Louis"),
	 "Unknown");


# order_content table
USE Rockfish;
INSERT INTO `order_content`
	(`order_id`, `product_id`, `amount`)
VALUES
	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Mohammed" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Sharp Kitchen Knife"),
     2),
     
	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Mohammed" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Garam Masala"),
     5),


	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Bob" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Plywood"),
     DEFAULT),
     
	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Satoshi" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Amethyst Ring"),
     DEFAULT),
     
	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Jimmy" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Rogan Josh Curry"),
     2),
     
	((SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Louis" AND `order`.`user_id` = `user`.`id`),
	 (SELECT `id` FROM `product` WHERE `name` = "Amethyst Ring"),
     DEFAULT);
     
# sales table
USE Rockfish;
INSERT INTO `sales`
	(`merchant_id`, `month_year`, `start_month_year`, `end_month_year`, `total_revenue`, `last_updated`)
VALUES     
	((SELECT `id` FROM `merchant` WHERE `name` = "Muji"),
     "April 2021",
     '2021-04-01',
     '2021-04-30',
     DEFAULT,
     DEFAULT),
     
	((SELECT `id` FROM `merchant` WHERE `name` = "Imran Export"),
     "May 2021",
     '2021-05-01',
     '2021-05-31',
     DEFAULT,
     DEFAULT),
     
	((SELECT `id` FROM `merchant` WHERE `name` = "Bill and Bill"),
     "June 2021",
     '2021-06-01',
     '2021-06-30',
     DEFAULT,
     DEFAULT),
     
	((SELECT `id` FROM `merchant` WHERE `name` = "Carte"),
     "July 2021",
     '2021-07-01',
     '2021-07-31',
     DEFAULT,
     DEFAULT),

	((SELECT `id` FROM `merchant` WHERE `name` = "Bill and Bill International"),
     "August 2021",
     '2021-08-01',
     '2021-08-31',
     DEFAULT,
     DEFAULT);


/* START UNCOMMENT HERE

# MODIFY PORTION: Uncomment to test! Test with originally inserted data! (Do not execute delete portion before modify portion)

# country table
USE Rockfish;
UPDATE `country`
SET `name` = "New America"
WHERE `name` = "United States of America"; # Cascades new value


# user table
USE Rockfish;
UPDATE `user`
SET `last_name` = "Ross"
WHERE `first_name` = "Bob" AND `last_name` = "Johnson" AND `id` >= 0; # Cascades for most, sets Foreign Key to null for posts and ad_delivery; id>=0 to bypass safe update mode

     
# friend bridge table
USE Rockfish;
UPDATE `friend`
SET `user2_id` = (SELECT `id` FROM `user` WHERE `first_name` = "Louis")
WHERE `user1_id` = (SELECT `id` FROM `user` WHERE `first_name` = "Bob");


# post table
USE Rockfish;
UPDATE `post`
SET `content` = "Goodbye World!"
WHERE `content` = "Hello World!" AND `id` >= 0; 

    
# merchant table
USE Rockfish;
UPDATE `merchant`
SET `name` = "Imran International", `country_id` = (SELECT `id` FROM `country` WHERE `name` = "International")
WHERE `name` = "Imran Export" AND `id` >= 0;


# ad table
USE Rockfish;
UPDATE `ad`
SET `merchant_id` = (SELECT `id` FROM `merchant` WHERE `name` = "Imran International" OR `name` = "Imran Export")
WHERE `content` = "Kitchen Tools Here" AND `id` >=0; # Cascades to ad_delivery


# ad_delivery table
USE Rockfish;
UPDATE `ad_delivery`
SET `ad_id` = (SELECT `id` FROM `merchant` WHERE `name` = "Imran International" OR `name` = "Imran Export")
WHERE `ad_id` = (SELECT `id` FROM `merchant` WHERE `name` = "Muji");


# product table
USE Rockfish;
UPDATE `product`
SET `merchant_id` = (SELECT `id` FROM `merchant` WHERE `name` = "Muji")
WHERE `name` = "Plywood" AND `id` >= 0; # Cascades to order table


# order table
USE Rockfish;
UPDATE `order`
SET `status` = "Completed"
WHERE `user_id` = (SELECT `id` FROM `user` WHERE `first_name` = "Mohammed");


# order_content table
USE Rockfish;
UPDATE `order_content`
SET `product_id` = (SELECT `id` FROM `product` WHERE `name` = "Sharp Kitchen Knife")
WHERE `order_id` IN (SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Mohammed" AND `user`.`id` = `order`.`user_id`);


# sales table
USE Rockfish;
# Store merchant id in @v1
SELECT `id` INTO @v1 FROM `merchant` WHERE `name` = "Muji";
UPDATE `sales`
SET `total_revenue` = (SELECT SUM(`product`.`price`*`order_content`.`amount`) #Multiply amount and price for total revenue for each product
						FROM `merchant`
						INNER JOIN `product` ON `product`.`merchant_id` = `merchant`.`id`
                        INNER JOIN `order_content` ON `order_content`.`product_id` = `product`.`id`
                        INNER JOIN `order` ON `order`.`id` = `order_content`.`order_id` 
                        WHERE `merchant`.`id` = @v1 AND ( DATE(`order`.`created`) BETWEEN '2021-04-01' AND '2021-04-30')
                        GROUP BY `product`.`id`) # Group by each product for SUM to work on each product separately
WHERE `sales`.`merchant_id` >= 0 AND `sales`.`start_month_year` = '2021-04-01';

SELECT * FROM `sales` WHERE `merchant_id` = @v1; # Query to show that it worked

END UNCOMMENT HERE*/ 
/* START UNCOMMENT HERE

# DELETE PORTION: Uncomment to test!

# country table
USE Rockfish;
DELETE FROM `country`
WHERE `name` = "United States of America"; # Restricted; Comment out to execute entire script


# user table
USE Rockfish;
DELETE FROM `user`
WHERE `first_name` = "Bob" AND `id` >= 0; # Cascades for most, sets Foreign Key to null for posts and ad_delivery; id>=0 to bypass safe update mode

     
# friend bridge table
USE Rockfish;
SELECT `id` INTO @v1 FROM `user` WHERE `first_name` = "Satoshi";
DELETE FROM `friend`
WHERE `user1_id` = @v1;
DELETE FROM `friend`
WHERE `user2_id` = @v1; # Deletes all friendships of Satoshi; No Foreign Keys


# post table
USE Rockfish;
DELETE FROM `post`
WHERE `content` = "Hello World!" AND `id` >= 0; # Cascades to Foreign Keys (replies)

    
# merchant table
USE Rockfish;
DELETE FROM `merchant`
WHERE `name` = "Imran Export" AND `id` >= 0; # Cascades to products, sets Foreign Keys to null for ads
     

# ad table
USE Rockfish;
DELETE FROM `ad`
WHERE `content` = "Kitchen Tools Here" AND `id` >=0; # Sets Foreign Keys to null (ad_delivery)


# ad_delivery table
USE Rockfish;
SELECT `ad`.`id` INTO @v1 FROM `merchant`, `ad` WHERE `merchant`.`name` = "Carte" AND `merchant`.`id` = `ad`.`merchant_id`;
DELETE FROM `ad_delivery`
WHERE `ad_id` = @v1; # No Foreign Keys
     

# product table
USE Rockfish;
DELETE FROM `product`
WHERE `name` = "Plywood" AND `id` >= 0; # Cascades to order table


# order table
USE Rockfish;
SELECT `id` INTO @v1 FROM `user` WHERE `first_name` = "Jimmy";
DELETE FROM `order`
WHERE `user_id` = @v1; # Cascades to order_content


# order_content table
USE Rockfish;
DELETE FROM `order_content` # Deletes order_content of all of Mohammed's orders; no restriction
WHERE `order_id` IN (SELECT `order`.`id` FROM `order`, `user` WHERE `first_name` = "Mohammed" AND `user`.`id` = `order`.`user_id`);


# sales table
USE Rockfish;
DELETE FROM `sales`
WHERE `end_month_year` <= '2021-05-01' AND `merchant_id` >= 0; # Deletes all sales data before May; no restriction

END UNCOMMENT HERE*/




