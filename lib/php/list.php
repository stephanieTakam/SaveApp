<?php

include "connection.php";
include "crypto.php";

$result = array();
//$idp = json_decode(decrypt($_POST["id_posts"]));
try {
    $sql = $db->prepare("SELECT * from pesonne GROUP BY id_person");
    $sql->execute(array());
    while ($a = $sql->fetch()) {
      $result[] = $a;
      echo "selected";
    }
    echo "\n " . serialize($result);
} catch (PDOException $th) {
    echo "error: ".$th->getMessage();
}

echo "\n " .encrypt(json_encode($result));

?>