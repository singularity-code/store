<?php
include 'ChromePhp.php';
include 'Database.php';

$mysqli = Database::connect();
$ajaxQuery = "SELECT count(*) FROM master_name WHERE f_name='" . $_POST["username"] . "'";
ChromePhp::log($ajaxQuery);
if (!empty($_POST["username"])) {
	$result = mysqli_query($mysqli, $ajaxQuery);
	$row = mysqli_fetch_row($result);
	$user_count = $row[0];
	if ($user_count > 0) {
		echo "<span class='status-not-available'> This User aleady exist.</span>";
	} else {
		echo "<span class='status-available'> This is new user.</span>";
	}
}

?>