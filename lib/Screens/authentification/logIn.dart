import 'package:SaveApp/Screens/authentification/acceuil.dart';
import 'package:SaveApp/Screens/registerList.dart';
import 'package:SaveApp/Models/passWord.dart';
import 'package:SaveApp/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:SaveApp/Models/person.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  var h = 20;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    void _showSnack() => Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Saved successfully'),
        duration: Duration(milliseconds: 500)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Acceuil(),));
        }),
        title: Text("Log In"),
      ),
      body:
          ListView(padding: EdgeInsets.symmetric(horizontal: 16.0), children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / h),
            TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.email),
                  hintText: 'Your email address',
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (String value) {
                  this._email = value;
                  print('email=$_email');
                }),
            SizedBox(height: MediaQuery.of(context).size.height / h),
            PasswordField(
                fieldKey: _passwordFieldKey,
                labelText: 'Password ',
                onFieldSubmitted: (String value) {
                  setState(() {
                    this._password = value;
                  });
                }),
            SizedBox(height: MediaQuery.of(context).size.height / h),
            Container(
              margin: EdgeInsets.only(top: 420),
              color: Colors.purple[200],
              width: MediaQuery.of(context).size.width / 20,
              //padding: EdgeInsets.only(top: 100),
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                
                elevation: 0,
                color: Colors.purple[200],
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterListPage(),));
                },
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        )
      ]),
    );
  }
}
