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
INSERT INTO store_items VALUES ('7', '3', 'Jane Self-Help Book', '12.00', 'Jane gives advice.', 'selfhelpbook.gif');
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
	, order_state CHAR(3)
	, order_zip VARCHAR(10)
	, order_tel VARCHAR(25)
	, order_email VARCHAR(100)
	, item_total FLOAT(6,2)
	, shipping_total FLOAT(6,2)
	, authorization VARCHAR (50)
	, order_status VARCHAR(50)
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
	
--Chapter 3
CREATE TABLE master_name (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,date_added DATETIME
	,date_modified DATETIME
	,f_name VARCHAR (75)
	,l_name VARCHAR (75)
);

CREATE TABLE address (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL
	,date_added DATETIME
	,date_modified DATETIME
	,address VARCHAR (255)
	,city VARCHAR (30)
	,state CHAR (2)
	,zipcode VARCHAR (10)
	,type ENUM ('home', 'work', 'other'));
	
CREATE TABLE telephone (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL
	,date_added DATETIME
	,date_modified DATETIME
	,tel_number VARCHAR (25)
	,type ENUM ('home', 'work', 'other'));
	
CREATE TABLE fax (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL
	,date_added DATETIME
	,date_modified DATETIME
	,fax_number VARCHAR (25)
	,type ENUM ('home', 'work', 'other'));

CREATE TABLE email (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL
	,date_added DATETIME
	,date_modified DATETIME
	,email VARCHAR (150)
	,type ENUM ('home', 'work', 'other'));

CREATE TABLE personal_notes (
	id int NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL UNIQUE
	,date_added DATETIME
	,date_modified DATETIME,note TEXT);

-- Task1

CREATE TABLE store_item_stock (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, stock_item_id INT
	, stock_item_qty INT
	, item_color_id VARCHAR(10)
	, item_size_id VARCHAR(10)
)

INSERT INTO store_item_stock VALUES (1, 1, 40, 1, "");
INSERT INTO store_item_stock VALUES (2, 1, 20, 2, "");
INSERT INTO store_item_stock VALUES (3, 1, 50, 3, "");
INSERT INTO store_item_stock VALUES (4, 2, 30, 1, "");
INSERT INTO store_item_stock VALUES (5, 2, 50, 2, "");
INSERT INTO store_item_stock VALUES (6, 2, 50, 3, "");
INSERT INTO store_item_stock VALUES (7, 3, 30, 1, "");
INSERT INTO store_item_stock VALUES (8, 3, 50, 2, "");
INSERT INTO store_item_stock VALUES (9, 3, 90, 3, "");
INSERT INTO store_item_stock VALUES (10, 4, 30, "", 4);
INSERT INTO store_item_stock VALUES (11, 4, 20, "", 5);
INSERT INTO store_item_stock VALUES (12, 4, 50, "", 6);
INSERT INTO store_item_stock VALUES (13, 4, 40, "", 7);
INSERT INTO store_item_stock VALUES (14, 5, 50, "", 4);
INSERT INTO store_item_stock VALUES (15, 5, 80, "", 5);
INSERT INTO store_item_stock VALUES (16, 5, 50, "", 6);
INSERT INTO store_item_stock VALUES (17, 5, 30, "", 7);
INSERT INTO store_item_stock VALUES (18, 6, 50, "", 4);
INSERT INTO store_item_stock VALUES (19, 6, 60, "", 5);
INSERT INTO store_item_stock VALUES (20, 6, 20, "", 6);
INSERT INTO store_item_stock VALUES (21, 6, 50, "", 7);
INSERT INTO store_item_stock VALUES (22, 7, 100, "", "");
INSERT INTO store_item_stock VALUES (23, 8, 100, "", "");
INSERT INTO store_item_stock VALUES (24, 9, 100, "", "");

DROP TABLE `store_orders`;
DROP TABLE `address`;
CREATE TABLE store_orders ( 
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	, order_date DATETIME
	, order_name VARCHAR (100)
	, order_address VARCHAR (255)
	, order_city VARCHAR (50)
	, order_state VARCHAR(50)
	, order_zip VARCHAR(4)
	, order_tel VARCHAR(25)
	, order_email VARCHAR(100)
	, item_total FLOAT(6,2)
	, shipping_total FLOAT(6,2)
	, authorization VARCHAR (50)
	, order_status VARCHAR(50)
	, order_note VARCHAR(255)
);
CREATE TABLE address (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT
	,master_id INT NOT NULL
	,date_added DATETIME
	,date_modified DATETIME
	,address VARCHAR (255)
	,city VARCHAR (30)
	,state VARCHAR(3)
	,zipcode VARCHAR (10)
	,type ENUM ('home', 'work', 'other'));
INSERT INTO store_orders
SET
	order_date = '2019-05-25 23:50:33'
	,order_name = 'a'
	,order_address = 'add'
	,order_city = 'city'
	,order_state = 'NT'
	,order_zip = '2000'
	,order_tel = '2349023'
	,order_email = 'email@gmail.com'
	,item_total = 10.00
	,shipping_total = 10.00
	,authorization = 'test'
	,order_status = 'Processing'
	,order_note = 'note test';