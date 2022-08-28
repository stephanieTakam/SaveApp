//import 'dart:html';
import 'dart:async';
import 'dart:convert';
//import 'package:mysql1/mysql1.dart';
import 'package:http/http.dart' as http;
import 'package:SaveApp/Screens/authentification/logIn.dart';
import 'package:SaveApp/Screens/registerList.dart';
import 'package:SaveApp/Models/passWord.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SaveApp/Models/person.dart';
import 'package:SaveApp/utils/variables.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({ Key key }) : super(key: key);

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  Person personne;
  var h = 20;

  String _validateName(String value) {
    if(value.isEmpty || value == null) return 'Please fill this space';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'This value is unvalid';
    }
    return null;
  }

  String _phoneNumberValidate(String value) {
    //Pattern pattern = r'/^\(?\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
    Pattern pattern2 = r'^(?:[+237])?[0-9]{9}$';
    RegExp regExp = new RegExp(pattern2);
    if (!regExp.hasMatch(value))
    return 'Enter valid phone number';
    else return null;
  }

  String _emailValidate(String value) {
    Pattern pattern2 = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern2);
    if (!regExp.hasMatch(value))
    return 'Enter valid mail';
    else return null;
  }

TextEditingController nom = new TextEditingController();
TextEditingController prenom = new TextEditingController();
TextEditingController email = new TextEditingController();
TextEditingController phone = new TextEditingController();
TextEditingController password = new TextEditingController();
  
Future<List>senddata() async {
  final response = await http.post("http://localhost:8000/addPost.php",
  body: {
    "nom": nom.text,
    "prenom": prenom.text,
    "phone": phone.text,
    "email": email.text,
    "password": password.text
  });
   var datauser = json.decode(response.body);
   return datauser;
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: Icon(Icons.account_circle_rounded),
        title: Text("Register"),
      ),
      body: ListView(
              children: <Widget> [Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                TextFormField(
                  controller: nom,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Enter your name there',
                    labelText: 'Name '
                  ),
                  onSaved:  (value) {
                    this.personne.nom = value;
                  },
                  validator: (value) {
                    if(value.isEmpty || value == null) return 'Please fill this space';
                      final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                      if (!nameExp.hasMatch(value)) {
                        return 'This value is unvalid';
                      }
                      return null;
                      }
                      
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                TextFormField(
                  controller: prenom,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.person),
                    hintText: 'Enter your surname there',
                    labelText: 'Surname '
                  ),
                  onSaved: (String value) {
                    this.personne.prenom = value;
                    //print('nom=$_prenom');
                  },
                  validator: _validateName,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.phone),
                  
                    hintText: 'Your phone number',
                    labelText: 'Phone Number ',
                    prefixText: '+237',
                  ),
                  validator: _phoneNumberValidate
                  ,
                  keyboardType: TextInputType.phone,
                  onSaved: (String value) {
                    this.personne.phoneNumber = value;
                   // print('phoneNumber=$_phoneNumber');
                  },
                  
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                TextFormField(
                  controller: email,
                  cursorColor: Colors.purple.shade500,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    icon: Icon(Icons.email),
                    hintText: 'Your email address',
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (String value) {
                    this.personne.email = value;
                    //print('email=$_email');
                  },
                  validator: _emailValidate,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                PasswordField(
                  controller: password,
                  fieldKey: _passwordFieldKey,
                  helperText: 'No more than 25 characters',
                  labelText: 'Password ',
                  onFieldSubmitted: (String value) {
                    setState(() {
                      this.personne.password = value;
                    });
                  }
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an account ?', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    }, child: Text('Log in', style: TextStyle(color: Colors.blue)))
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  color: Colors.purple[200],
                  width: MediaQuery.of(context).size.width / 20,
                  //padding: EdgeInsets.only(bottom: ),
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.purple[200],
                    onPressed: () {
                      if (_formKey.currentState.validate() != false) {
                        senddata();
                      
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterListPage()));
                      } 
                    }, child: Text('Save', style: TextStyle(fontSize: 18, color: Colors.white),),),
                )
              ],
            ),
          )
        )],
      )
    );
  }
}