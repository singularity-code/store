<?php
session_start();
include 'ChromePhp.php';
include 'Database.php';
ChromePhp::log('Hello console!');

if (isset($_GET['id'])) {
	//connect to database
	$mysqli = Database::connect();

	//create safe values for use
	$safe_id = mysqli_real_escape_string($mysqli, $_GET['id']);

	//add quantity back to the stock table
	$update_stock_sql = "UPDATE store_item_stock t
    SET t.stock_item_qty = (
        SELECT stock_item_qty
        FROM store_item_stock
        WHERE stock_item_id = (SELECT sel_item_id FROM store_shoppertrack WHERE id = '" . $safe_id . "')
        AND item_color_id = (SELECT sel_item_color FROM store_shoppertrack WHERE id = '" . $safe_id . "')
        AND item_size_id = (SELECT sel_item_size FROM store_shoppertrack WHERE id = '" . $safe_id . "')) 
            + (SELECT sel_item_qty FROM store_shoppertrack WHERE id = '" . $safe_id . "') 
    WHERE t.id = (
        SELECT id
        FROM store_item_stock si
        WHERE si.stock_item_id = (SELECT sel_item_id FROM store_shoppertrack WHERE id = '" . $safe_id . "')
        AND si.item_color_id = ''
        AND si.item_size_id = '')
    AND item_color_id = (SELECT sel_item_color FROM store_shoppertrack WHERE id = '" . $safe_id . "')
    AND item_size_id = (SELECT sel_item_size FROM store_shoppertrack WHERE id = '" . $safe_id . "')
    ";
	$update_stcok_res = mysqli_query($mysqli, $update_stock_sql) or die(mysqli_error($mysqli));

	$delete_item_sql = "DELETE FROM store_shoppertrack 
                        WHERE id = '" . $safe_id . "'
                        AND session_id = '" . $_COOKIE['PHPSESSID'] . "'";


	$delete_item_res = mysqli_query($mysqli, $delete_item_sql) or die(mysqli_error($mysqli));

	//close connection to MySQL
	mysqli_close($mysqli);

	//redirect to showcart page
	header("Location: showcart.php");
	exit;
} else {
	//send them somewhere else
	header("Location: seestore.php");
	exit;
}
?>