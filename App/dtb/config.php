<?php
	$username="root";
	$password=""; 
	$host="localhost";
	$db_name="cys"; 

	$connect=mysqli_connect($host,$username,$password,$db_name);

	if(!$connect)
	{
		echo json_encode("Connection Failed");
	}
?>