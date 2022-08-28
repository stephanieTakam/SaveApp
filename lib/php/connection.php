<?php
    $host = "localhost";
    $dbname = "save_app3";
    $user = "root";
    $pass = "";
    
    try {
        $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
        echo "connected";
    } catch (\Throwable $th) {
        echo "Error: ".$th->getMessage();
    }
?>