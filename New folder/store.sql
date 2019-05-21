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

INSERT INTO store_items VALUES ('1', '1', 'Baseball Hat', '12.00', 'Fancy, low-profile baseball hat.', 'baseballhat.gif');
INSERT INTO store_items VALUES ('2', '1', 'Cowboy Hat', '52.00', '10 gallon variety', 'cowboyhat.gif');
INSERT INTO store_items VALUES ('3', '1', 'Top Hat', '102.00', 'Good for costumes.', 'tophat.gif');
INSERT INTO store_items VALUES ('4', '2', 'Short-Sleeved T-Shirt', '12.00', '100% cotton, pre-shrunk.', 'sstshirt.gif');
INSERT INTO store_items VALUES ('5', '2', 'Long-Sleeved T-Shirt', '15.00', 'Just like the short-sleeved shirt, with longer sleeves.', 'lstshirt.gif');
INSERT INTO store_items VALUES ('6', '2', 'Sweatshirt', '22.00', 'Heavy and warm.', 'sweatshirt.gif');
INSERT INTO store_items VALUES ('7', '3', 'Jane\’s Self-Help Book', '12.00', 'Jane gives advice.', 'selfhelpbook.gif');
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