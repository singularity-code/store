CREATE TABLE store_shoppertrack (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    session_id VARCHAR (32),
    sel_item_id INT,
    sel_item_qty SMALLINT,
    sel_item_size VARCHAR(25), 
    sel_item_color VARCHAR(25),
    date_added DATETIME
);

CREATE TABLE store_orders (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME,
    order_name VARCHAR (100),
    order_address VARCHAR (255),
    order_city VARCHAR (50),
    order_state CHAR(2),
    order_zip VARCHAR(10),
    order_tel VARCHAR(25), 
    order_email VARCHAR(100),
    item_total FLOAT(6,2),
    shipping_total FLOAT(6,2),
    authorization VARCHAR(50),
    status ENUM('processed', 'pending')
);

CREATE TABLE store_orders_items (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    sel_item_id INT,
    sel_item_qty SMALLINT,
    sel_item_size VARCHAR(25),
    sel_item_color VARCHAR(25),
    sel_item_price FLOAT(6,2)
);