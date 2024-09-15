<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$customerId = $_GET['customerId'];
		$address = $_GET['address'];
		$customerName = $_GET['customerName'];
		$lastName = $_GET['lastName'];
		$phoneNumber = $_GET['phoneNumber'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
		$email = $_GET['email'];
		$password = $_GET['password'];
		$status = $_GET['status'];
		
		
							
		$sql = "INSERT INTO `ung_few_user`(`id`, `customerId`, `address`, `customerName`, `lastName`, `phoneNumber`, `lat`, `lng`, `status`, `email`, `password`) VALUES (Null,'$customerId','$address','$customerName','$lastName','$phoneNumber','$lat','$lng','$status','$email','$password')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Master UNG";
   
}
	mysqli_close($link);
?>