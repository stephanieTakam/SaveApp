import 'package:flutter/material.dart';

class Person {
   int id;
   String nom;
   String prenom;
   String phoneNumber;
   String email;
   String password;

  Person({
    this.id,
    this.nom,
    this.prenom,
    this.phoneNumber,
    this.email,
    this.password
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id_person'],
      nom: json['nom'],
      prenom: json['prenom'],
      phoneNumber: json['phone'],
      email: json['email'],
      password: json['pwd']
    );
  }
  
  Map<String, dynamic> toJson() => {
    'nom': nom,
    'prenom': prenom,
    'phone': phoneNumber,
    'email': email,
    'pwd': password
  };
}