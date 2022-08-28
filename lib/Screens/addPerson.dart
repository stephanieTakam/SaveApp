import 'package:SaveApp/Screens/authentification/logIn.dart';
import 'package:SaveApp/Screens/registerList.dart';
import 'package:SaveApp/Models/passWord.dart';
import 'package:SaveApp/api/api.dart';
import 'package:SaveApp/utils/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:SaveApp/Models/person.dart';
import 'package:flutter/services.dart';
import 'package:SaveApp/utils/variables.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPersonPage extends StatefulWidget {
  const AddPersonPage({ Key key }) : super(key: key);

  @override
  State<AddPersonPage> createState() => _AddPersonPageState();
}

class _AddPersonPageState extends State<AddPersonPage> {
  @override
  void initState(){
    super.initState();
  }

  CustomTextField nom = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Nom');
  CustomTextField prenom = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Prénom');
  CustomTextField phone = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Téléphone');
  CustomTextField email = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Email');
  CustomTextField password = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Password');
  Person newPerson = new Person();
  bool post = false;
  
  final _key = GlobalKey<FormState>();
  //final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  var h = 20;
  String _validateName(String value) {
    if(value.isEmpty) return 'Please enter your name';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'This value is unvalid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: Icon(Icons.account_circle_rounded),
        title: Text("Add a person"),
      ),
      body: Form(
        key: _key,
              child: ListView(
                children: <Widget> [Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                nom.textfrofield(),
                // TextFormField(
                //   textCapitalization: TextCapitalization.words,
                //   decoration: InputDecoration(
                //     border: UnderlineInputBorder(),
                //     filled: true,
                //     icon: Icon(Icons.person),
                //     hintText: 'Enter your name there',
                //     labelText: 'Name '
                //   ),
                //   onSaved: (String value) {
                //     this._nom = value;
                //     print('nom=$_nom');
                //   },
                //   validator: _validateName,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                prenom.textfrofield(),
                // TextFormField(
                //   textCapitalization: TextCapitalization.words,
                //   decoration: InputDecoration(
                //     border: UnderlineInputBorder(),
                //     filled: true,
                //     icon: Icon(Icons.person),
                //     hintText: 'Enter your surname there',
                //     labelText: 'Surname '
                //   ),
                //   onSaved: (String value) {
                //     this._prenom = value;
                //     print('nom=$_prenom');
                //   },
                //   validator: _validateName,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                phone.textfrofield(),
                // TextFormField(
                //   decoration: InputDecoration(
                //     border: UnderlineInputBorder(),
                //     filled: true,
                //     icon: Icon(Icons.phone),
                //     hintText: 'Your phone number',
                //     labelText: 'Phone Number ',
                //     prefixText: '+237',
                //   ),
                //   keyboardType: TextInputType.phone,
                //   onSaved: (String value) {
                //     this._phoneNumber = value;
                //     print('phoneNumber=$_phoneNumber');
                //   },
                //   inputFormatters: <TextInputFormatter>[
                //     FilteringTextInputFormatter.digitsOnly
                //   ],
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                email.textfrofield(),
                // TextFormField(
                //   decoration: InputDecoration(
                //     border: UnderlineInputBorder(),
                //     filled: true,
                //     icon: Icon(Icons.email),
                //     hintText: 'Your email address',
                //     labelText: 'Email',
                //   ),
                //   keyboardType: TextInputType.emailAddress,
                //   onSaved: (String value) {
                //     this._email = value;
                //     print('email=$_email');
                //   }
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                password.textfrofield(),
                // PasswordField(
                //   fieldKey: _passwordFieldKey,
                //   helperText: 'No more than 25 characters',
                //   labelText: 'Password ',
                //   onFieldSubmitted: (String value) {
                //     setState(() {
                //       this._password = value;
                //     });
                //   }
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / h
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  
                  width: MediaQuery.of(context).size.width / 20,
                  //padding: EdgeInsets.only(bottom: ),
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: post?null: () async {
                      if (_key.currentState.validate()) {
                        setState(() {
                          post = true;
                        });
                        newPerson.nom = nom.value;
                        newPerson.prenom = prenom.value;
                        newPerson.phoneNumber = phone.value;
                        newPerson.email = email.value;
                        newPerson.password = password.value;
                        var result = await Api.addPost(newPerson.toJson());
                        if(result != null && result[0]){
                          setState(() {
                            post = false;
                          });
                          Navigator.of(context).pop();
                        }else if(result != null && !result[0]){
                          setState(() {
                            post = false;
                          });
                        }else{
                          setState(() {
                            post = false;
                          });
                        }
                      }
                    },
                    elevation: 0.0,
                   
                        
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  color: Colors.purple[200]),
                  ),
                ])
              )]
            )
          ),
        );
      
    
  }
}