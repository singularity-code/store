<?php
//connect to database


if ($mysqli->connect_errno) {
	die('Connection Error (' . $mysqli->connect_errno . '): ' .
		$mysqli->connect_error);
}

if (!$_POST) {
	//haven't seen the form, so show it
	$display_entry =

		<<<END_OF_TEXT
<div>
<p><h1>Checkout Details</h1></p>
<form method="post" action="$_SERVER[PHP_SELF]">
<fieldset>
    <legend>First/Last Names:</legend><br/>
    <input type="text" id="f_name" name="f_name" size="30" maxlength="75" required="required" onBlur="checkAvailability()"/><span id="user-availability-status"></span>
    <p><img src="LoaderIcon.gif" id="loaderIcon" style="display:none" /></p>
</fieldset>

<fieldset>
    <p><label for="address">Street Address:</label><br/>
    <input type="text" id="address" name="address" size="30" /></p>
    <legend>City/State/Zip:</legend><br/>
    <input type="text" name="city" size="30" maxlength="50" />
    <input type="text" name="state" size="5" maxlength="3" />
    <input type="text" name="zipcode" size="10" maxlength="4" />
    <legend>Address Type:</legend><br/>
    <input type="radio" id="add_type_h" name="add_type" value="home" checked />
    <label for="add_type_h">home</label>
    <input type="radio" id="add_type_w" name="add_type" value="work" />
    <label for="add_type_w">work</label>
    <input type="radio" id="add_type_o" name="add_type" value="other" />
    <label for="add_type_o">other</label>
</fieldset>
<fieldset>
    <legend>Telephone Number:</legend><br/>
    <input type="text" name="tel_number" size="30" maxlength="25" />
    <input type="radio" id="tel_type_h" name="tel_type" value="home" checked />
    <label for="tel_type_h">home</label>
    <input type="radio" id="tel_type_w" name="tel_type" value="work" /><label for="tel_type_w">work</label>
    <input type="radio" id="tel_type_o" name="tel_type" value="other" />
    <label for="tel_type_o">other</label>
</fieldset>
<fieldset>
    <legend>Fax Number:</legend><br/>
    <input type="text" name="fax_number" size="30" maxlength="25" />
    <input type="radio" id="fax_type_h" name="fax_type" value="home" checked />
    <label for="fax_type_h">home</label>
    <input type="radio" id="fax_type_w" name="fax_type" value="work" />
    <label for="fax_type_w">work</label>
    <input type="radio" id="fax_type_o" name="fax_type" value="other" />
    <label for="fax_type_o">other</label>
</fieldset>
<fieldset>
    <legend>Email Address:</legend><br/>
    <input type="email" name="email" size="30" maxlength="150" />
    <input type="radio" id="email_type_h" name="email_type" value="home" checked />
    <label for="email_type_h">home</label>
    <input type="radio" id="email_type_w" name="email_type" value="work" />
    <label for="email_type_w">work</label>
    <input type="radio" id="email_type_o" name="email_type" value="other" />
    <label for="email_type_o">other</label>
</fieldset>
    <p><label for="note">Personal Note:</label><br/>
    <textarea id="note" name="note" cols="35" rows="3"></textarea></p>
    <button type="submit" name="submit" value="send">Check Out</button>
</form>
</div>
END_OF_TEXT;

} else if ($_POST) {
	$mysqli = Database::connect();
	// time to add to tables, so check for required fields
	if ($_POST['f_name'] == "") {
		header("Location: addentry.php");
		exit;
	}
	//create clean versions of input strings
	$safe_f_name = mysqli_real_escape_string($mysqli, $_POST['f_name']);
	$safe_address = mysqli_real_escape_string($mysqli, $_POST['address']);
	$safe_city = mysqli_real_escape_string($mysqli, $_POST['city']);
	$safe_state = mysqli_real_escape_string($mysqli, $_POST['state']);
	$safe_zipcode = mysqli_real_escape_string($mysqli, $_POST['zipcode']);
	$safe_tel_number = mysqli_real_escape_string($mysqli, $_POST['tel_number']);
	$safe_fax_number = mysqli_real_escape_string($mysqli, $_POST['fax_number']);
	$safe_email = mysqli_real_escape_string($mysqli, $_POST['email']);
	$safe_note = mysqli_real_escape_string($mysqli, $_POST['note']);
	//add to master_name table
	$add_master_sql = "INSERT INTO master_name (date_added, date_modified, f_name) VALUES
        (now(), now(), '" . $safe_f_name . "')";
	$add_master_res = mysqli_query($mysqli, $add_master_sql)
	or die(mysqli_error($mysqli));
	//get master_id for use with other tables
	$master_id = mysqli_insert_id($mysqli);

	if (($_POST['address']) || ($_POST['city']) || ($_POST['state']) || ($_POST['zipcode'])) {
		//something relevant, so add to address table
		$add_address_sql = "INSERT INTO address (master_id,
            date_added, date_modified, address, city, state,
            zipcode, type)  VALUES
            ('" . $master_id . "', now(), now(),
            '" . $safe_address . "', '" . $safe_city . "',
            '" . $safe_state . "' , '" . $safe_zipcode . "' ,
            '" . $_POST['add_type'] . "')";
		$add_address_res = mysqli_query($mysqli, $add_address_sql)
		or die(mysqli_error($mysqli));

		if ($_POST['tel_number']) {
			//something relevant, so add to telephone table
			$add_tel_sql = "INSERT INTO telephone (master_id, date_added,
                date_modified, tel_number, type)  VALUES
                ('" . $master_id . "', now(), now(),
                '" . $safe_tel_number . "', '" . $_POST['tel_type'] . "')";
			$add_tel_res = mysqli_query($mysqli, $add_tel_sql)
			or die(mysqli_error($mysqli));
		}
		if ($_POST['fax_number']) {
			//something relevant, so add to fax table
			$add_fax_sql = "INSERT INTO fax (master_id, date_added,
                date_modified, fax_number, type)  VALUES
                ('" . $master_id . "', now(), now(), '" . $safe_fax_number . "',
                '" . $_POST['fax_type'] . "')";
			$add_fax_res = mysqli_query($mysqli, $add_fax_sql)
			or die(mysqli_error($mysqli));
		}
		if ($_POST['email']) {
			//something relevant, so add to email table
			$add_email_sql = "INSERT INTO email (master_id, date_added,
                date_modified, email, type)  VALUES
                ('" . $master_id . "', now(), now(), '" . $safe_email . "',
                '" . $_POST['email_type'] . "')";
			$add_email_res = mysqli_query($mysqli, $add_email_sql)
			or die(mysqli_error($mysqli));
		}

		if ($_POST['note']) {
			//something relevant, so add to notes table
			$add_notes_sql = "INSERT INTO personal_notes (master_id, date_added, date_modified, note)  
                                VALUES ('" . $master_id . "', now(), now(), '" . $safe_note . "')";
			$add_notes_res = mysqli_query($mysqli, $add_notes_sql) or die(mysqli_error($mysqli));
		}

		//check for cart items based on user session id
		$get_final_order_sql = "SELECT st.id, si.item_title, si.item_price, st.sel_item_qty, st.sel_item_size, st.sel_item_color
        FROM store_shoppertrack AS st 
        LEFT JOIN store_items AS si 
        ON si.id = st.sel_item_id
        WHERE session_id = '" . $_COOKIE['PHPSESSID'] . "'";

		//recrod the final order
		$get_final_order_res = mysqli_query($mysqli, $get_final_order_sql) or die(mysqli_error($mysqli));
		while ($cart_info = mysqli_fetch_array($get_final_order_res)) {
			$total_price = sprintf("%.02f", $cart_info['item_price'] * $cart_info['sel_item_qty']);

			$submit_order_query = "INSERT INTO store_orders
            SET order_date = '2019-05-25 23:50:33'
                ,order_name = '" . $safe_f_name . "'
                ,order_address = '" . $safe_address . "'
                ,order_city = '" . $safe_city . "'
                ,order_state = '" . $safe_state . "'
                ,order_zip = '" . $safe_zipcode . "'
                ,order_tel = '" . $safe_tel_number . "'
                ,order_email = '" . $safe_email . "'
                ,item_total = '" . $total_price . "'
                ,shipping_total = '" . $total_price . "'
                ,authorization = 'test'
                ,order_status = 'Processing'
                ,order_note = '" . $safe_note . "'";
			ChromePhp::log($submit_order_query);
			$order_query_res = mysqli_query($mysqli, $submit_order_query) or die(mysqli_error($mysqli));
		}
		//empty the cart
		$empty_cart_sql = "DELETE FROM store_shoppertrack WHERE session_id = '" . $_COOKIE['PHPSESSID'] . "'";
		ChromePhp::log($empty_cart_sql);
		$order_query_res = mysqli_query($mysqli, $empty_cart_sql) or die(mysqli_error($mysqli));

		// Record the order to the table
		mysqli_close($mysqli);
		$display_entry = "<p>Your order has been submitted. <a href=\"seestore.php\"</a>Back to main page ?</p>";
	}
}
?>
<script>
    function checkAvailability() {
        $("#loaderIcon").show();
        jQuery.ajax({
            url: "check_availability.php",
            data: 'username=' + $("#f_name").val(),
            type: "POST",
            success: function (data) {
                $("#user-availability-status").html(data);
                $("#loaderIcon").hide();
            },
            error: function () {
            }
        });
    }
</script>
