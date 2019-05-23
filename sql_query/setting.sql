CREATE TABLE store_categories (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	cat_title VARCHAR (50) UNIQUE, 
	cat_desc TEXT 
);
CREATE TABLE store_items (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	cat_id INT NOT NULL, 
	item_title VARCHAR (75), 
	item_price FLOAT (8,2), 
	item_desc TEXT, 
	item_image VARCHAR (50) 
);
CREATE TABLE store_item_size (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	item_id INT NOT NULL, 
	item_size VARCHAR (25)
);
CREATE TABLE store_item_color (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
	item_id INT NOT NULL, 
	item_color VARCHAR (25) 
);
INSERT INTO store_categories 
	VALUES ('1'
	, 'Hats'
	, 'Funky hats IN ALL shapes AND sizes!'
);
INSERT INTO store_categories 
	VALUES ('2'
	, 'Shirts'
	, 'FROM t-shirts TO sweatshirts TO polo shirts AND beyond.'
);
INSERT INTO store_categories 
	VALUES ('3'
	, 'Books'
	, 'Paperback, hardback, books FOR school OR play.'
);
INSERT INTO store_items VALUES ('1', '1', 'Baseball Hat', '12.00', 'Fancy, low-profile baseball hat.', 'baseballhat.gif');
INSERT INTO store_items VALUES ('2', '1', 'Cowboy Hat', '52.00', '10 gallon variety', 'cowboyhat.gif');
INSERT INTO store_items VALUES ('3', '1', 'Top Hat', '102.00', 'Good for costumes.', 'tophat.gif');
INSERT INTO store_items VALUES ('4', '2', 'Short-Sleeved T-Shirt', '12.00', '100% cotton, pre-shrunk.', 'sstshirt.gif');
INSERT INTO store_items VALUES ('5', '2', 'Long-Sleeved T-Shirt', '15.00', 'Just like the short-sleeved shirt, with longer sleeves.', 'lstshirt.gif');
INSERT INTO store_items VALUES ('6', '2', 'Sweatshirt', '22.00', 'Heavy and warm.', 'sweatshirt.gif');
INSERT INTO store_items VALUES ('7', '3', 'Jane\'s Self-Help Book', '12.00', 'Jane gives advice.', 'selfhelpbook.gif');
INSERT INTO store_items VALUES ('8', '3', 'Generic Academic Book', '35.00', 'Some required reading for school, will put you to sleep.', 'boringbook.gif');
INSERT INTO store_items VALUES ('9', '3', 'Chicago Manual of Style', '9.99', 'Good for copywriters.', 'chicagostyle.gif');

INSERT INTO store_item_size (item_id, item_size) VALUES (1,'One Size Fits All'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (2,'One Size Fits All'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (3,'One Size Fits All'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (4,'S'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (4,'M'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (4,'L'); 
INSERT INTO store_item_size (item_id, item_size) VALUES (4,'XL');

INSERT INTO store_item_color (item_id, item_color) VALUES (1,'red'); 
INSERT INTO store_item_color (item_id, item_color) VALUES (1,'black');
INSERT INTO store_item_color (item_id, item_color) VALUES (1,'blue');

-- Chapter 2
CREATE TABLE store_shoppertrack ( 
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, session_id VARCHAR (32)
	, sel_item_id INT
	, sel_item_qty SMALLINT
	, sel_item_size VARCHAR(25)
	, sel_item_color VARCHAR(25)
	, date_added DATETIME 
);

CREATE TABLE store_orders ( 
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, order_date DATETIME
	, order_name VARCHAR (100)
	, order_address VARCHAR (255)
	, order_city VARCHAR (50)
	, order_state CHAR(2)
	, order_zip VARCHAR(10)
	, order_tel VARCHAR(25)
	, order_email VARCHAR(100)
	, item_total FLOAT(6,2)
	, shipping_total FLOAT(6,2)
	, authorization VARCHAR (50)
	, status ENUM('processed', 'pending') 
);

CREATE TABLE store_orders_items (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, order_id INT
	, sel_item_id INT
	, sel_item_qty SMALLINT
	, sel_item_size VARCHAR(25)
	, sel_item_color VARCHAR(25)
	, sel_item_price FLOAT(6,2) 
);
	
