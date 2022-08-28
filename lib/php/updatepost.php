<?php
include "connection.php";
include "crypto.php";

$id = decrypt($_POST["id_person"]);
$type = decrypt($_POST["type"]);
$result = array();
try {
   if($type == 1){
     $sql = "SELECT (nom, prenom, phone, email, pwd) from pesonne p WHERE p.id_person = ? ";
      $req = $db->prepare($sql);
      $req->execute(array($id));
      while ($a = $req->fetch()) {
        $result[] = $a;
      }
   }else if ($type == 2) {
      $post = json_decode(decrypt($_POST["data"]));
      $id_person = $post->id_person;
      $nom = $post->nom;
      $prenom = $post->prenom;
      $tel = $post->phone;
      $email = $post->email;
      $pwd = $post->pwd;
      $isok=false;
      $msg = "";

      // $sql = "UPDATE post SET titre=?, detail=? WHERE id_post=?";
      // $req = $db->prepare($sql);
      // $req->execute(array($titre, $detail, $id_post));
      // if($req){
      //   $isok = true;
      //   $result = [
      //     $isok,
      //     "modifier aavec succès"
      //   ];
      // }
      print_r($post);
   }
} catch (PDOException $th) {
    
}
// echo encrypt(json_encode($result));

?>