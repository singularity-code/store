<?php
session_start();
include 'ChromePhp.php';
include 'Database.php';
ChromePhp::log('Hello console!');

if (isset($_POST['sel_item_id'])) {
	//connect to database
	$mysqli = Database::connect();

	//create safe values for use
	$safe_sel_item_id = mysqli_real_escape_string($mysqli, $_POST['sel_item_id']);
	$safe_sel_item_qty = mysqli_real_escape_string($mysqli, $_POST['sel_item_qty']);
	$safe_sel_item_size = mysqli_real_escape_string($mysqli, $_POST['sel_item_size']);
	$safe_sel_item_color = mysqli_real_escape_string($mysqli, $_POST['sel_item_color']);

	//validate item and get title and price
	$get_iteminfo_sql = "SELECT item_title FROM store_items WHERE
                        id = '" . $safe_sel_item_id . "'";
	$get_iteminfo_res = mysqli_query($mysqli, $get_iteminfo_sql)
	or die(mysqli_error($mysqli));

	if (mysqli_num_rows($get_iteminfo_res) < 1) {

		//free result
		mysqli_free_result($get_iteminfo_res);

		//close connection to MySQL
		mysqli_close($mysqli);

		//invalid id, send away
		header("Location: seestore.php");
		exit;
	} else {
		//get info
		while ($item_info = mysqli_fetch_array($get_iteminfo_res)) {
			$item_title = stripslashes($item_info['item_title']);
		}

		//free result
		mysqli_free_result($get_iteminfo_res);
		//add info to cart table
		$addtocart_sql = "INSERT INTO store_shoppertrack
                         (session_id, sel_item_id, sel_item_qty,
                         sel_item_size, sel_item_color, date_added)
                         VALUES ('" . $_COOKIE['PHPSESSID'] . "',
                         '" . $safe_sel_item_id . "',
                         '" . $safe_sel_item_qty . "',
                         '" . $safe_sel_item_size . "', 
                         '" . $safe_sel_item_color . "', now())";
		$addtocart_res = mysqli_query($mysqli, $addtocart_sql)
		or die(mysqli_error($mysqli));

		//reduce the qty from stock table
		$get_order_sql = "SELECT st.id, si.id AS item_id, si.item_title, si.item_price, st.sel_item_qty, st.sel_item_size, st.sel_item_color
        FROM store_shoppertrack AS st 
        LEFT JOIN store_items AS si 
        ON si.id = st.sel_item_id
        WHERE session_id = '" . $_COOKIE['PHPSESSID'] . "'";

		ChromePhp::log("-----");
		ChromePhp::log($get_order_sql);
		$get_order_res = mysqli_query($mysqli, $get_order_sql)
		or die(mysqli_error($mysqli));

		while ($order_info = mysqli_fetch_array($get_order_res)) {
			ChromePhp::log("--- Order Info");
			ChromePhp::log($order_info);
			// Prepare sql for update stock
			$update_stock_sql = "UPDATE store_item_stock
                        SET stock_item_qty = (
                            SELECT stock_item_qty
                            FROM store_item_stock
                            WHERE stock_item_id = '" . $order_info['item_id'] . "'
                            AND item_color_id = IFNULL('" . $order_info['sel_item_color'] . "', '')
                            AND item_size_id = IFNULL('" . $order_info['sel_item_size'] . "', '')) - '" . $order_info['sel_item_qty'] . "'
                        WHERE stock_item_id = '" . $order_info['item_id'] . "'
                        AND item_color_id = IFNULL('" . $order_info['sel_item_color'] . "', '')
                        AND item_size_id = IFNULL('" . $order_info['sel_item_size'] . "', '')
                        ";
			ChromePhp::log($update_stock_sql);
			$update_stock_res = mysqli_query($mysqli, $update_stock_sql) or die(mysqli_error($mysqli));
		}
		//close connection to MySQL
		mysqli_close($mysqli);

		//redirect to showcart page
		header("Location: showcart.php");
		exit;
	}

} else {
	//send them somewhere else
	header("Location: seestore.php");
	exit;
}
?>