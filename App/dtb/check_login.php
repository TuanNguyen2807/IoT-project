<?php 
    include "config.php";  

    $return["message"] = "";

    // CHECK LOGIN USER
    $username = mysqli_real_escape_string($connect, $_POST['username']);
    $password = mysqli_real_escape_string($connect, $_POST['password']);

 
    $sql = "SELECT * FROM users WHERE username = '$username'";
    $res = mysqli_query($link, $sql);
    $numrows = mysqli_num_rows($res);

    if($numrows > 0){
           $obj = mysqli_fetch_object($res);
           //get row as object
           if(md5($password) == $obj->password){
               $return["message"] = 'success'; 
           }else{
               $return["message"] = 'fail';
           }
       }else{
           $return["message"] = 'error';
       }
    }


    header('Content-Type: application/json');
    // tell browser that its a json data
    echo json_encode($return);
    //converting array to JSON string
?>