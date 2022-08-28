<?php
include "connection.php";
include "crypto.php";

$result = array();
$idp = json_decode(decrypt($_POST["id_posts"]));
try {
  for ($i=0; $i < count($idp); $i++) { 
    $sql = $db->prepare("SELECT * from pesonne p WHERE p.id_person = ?;");
    $req->execute(array($idp));
    while ($a = $req->fetch()) {
      $result[] = $a;
    }
  }
} catch (PDOException $th) {
    
}

echo encrypt(json_encode($result));

?>