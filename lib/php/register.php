<?php
    include "connection.php";

    $id_person = $post->id_person;
    $nom = $post->nom;
    $prenom = $post->prenom;
    $tel = $post->phone;
    $email = $post->email;
    $pwd = $post->pwd;
    $pass = sha1($_POST['pass']);

    try {
       if(isset($nom, $prenom, $tel, $email, $pwd)){
           $req = $db->prepare("SELECT (nom, prenom, phone, email, pwd) FROM pesonne WHERE email=?");
           $req->execute(array($email));
           $exist = $req->rowCount();
           if($exist == 0){
               $req = $db->prepare("INSERT INTO pesonne VALUES(?,?,?,?,?)");
                $req->execute(array($nom, $prenom, $tel, $email, $pwd));
                if($req){
                    $succes = 1;
                    $msg = "succes register";
                }else{
                    $succes = 0;
                    $msg = "error register";
                }
           }else{
               $msg = "email arealy exist";
               $succes = 0;
           }
       }else{
          $succes = 0;
          $msg = "error empty data"; 
       }
    } catch (\Throwable $th) {
       $succes = 0;
       $msg = "Error: ".$th->getMesage();
    }
    echo json_encode([
        "data"=>[
            $msg,
            $succes
        ]
    ]);
?>