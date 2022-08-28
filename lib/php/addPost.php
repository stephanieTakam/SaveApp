<?php

include "connection.php";
include "crypto.php";

$post = json_decode(decrypt($_POST["data"]));
$id_person = $post->id_person;
$nom = $post->nom;
$prenom = $post->prenom;
$tel = $post->phone;
$email = $post->email;
$pwd = $post->pwd;
$isok=false;
$msg = "";
try {
    $req = $db->prepare("INSERT INTO pesonne(nom, prenom,phone, email, pwd) VALUES(?,?,?,?,?)");
    $req->execute(array($nom, $prenom, $tel, $email, $pwd));
    if($req){
        $isok = true; 
        $msg = "publier avec succès";
    }else{
        $msg = "échec de publication";
    }
} catch (\Throwable $th) {
    $msg = "échec de publication";
}

echo encrypt(
    json_encode([
        $isok,
        $msg
    ])
)
?>