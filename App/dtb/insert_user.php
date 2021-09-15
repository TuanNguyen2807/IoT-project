<?php 
    include "config.php";

    $return["message"] = "";

    // REGISTER USER
    $userid = mysqli_real_escape_string($connect, $_POST['userid']);
    $name = mysqli_real_escape_string($connect, $_POST['name']);
    $username = mysqli_real_escape_string($connect, $_POST['username']);
    $password = mysqli_real_escape_string($connect, $_POST['password']);
  
    $query = "INSERT INTO users (userid, name, username, password)
  			VALUES('$userid', '$name', '$username','$password')";
    $results = mysqli_query($connect, $query);
    if($results > 0)
    {
        $return["message"] = 'success'; 
    } else
    {
        $return["message"] = 'fail';
    }

    header('Content-Type: application/json');
    // tell browser that its a json data
    echo json_encode($return);
    //converting array to JSON string
?>