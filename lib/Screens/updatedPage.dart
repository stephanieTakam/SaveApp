import 'package:SaveApp/Models/person.dart';
import 'package:SaveApp/api/api.dart';
import 'package:SaveApp/utils/customTextField.dart';
import 'package:SaveApp/utils/variables.dart';
import 'package:flutter/material.dart';

class UpdatedPage extends StatefulWidget {
  Person model;
  UpdatedPage({this.model});
  @override
  State<UpdatedPage> createState() => _UpdatedPageState();
}

class _UpdatedPageState extends State<UpdatedPage> {
  final _formKey = GlobalKey<FormState>();
  //final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  List<Person> postModel = [];
bool isok = false;
getPostUser() async{
  setState(() {
    isok = false;
  });
    var data = await Api.getPost();
    if(data != null){
      postModel.clear();
      for(Map i in data){
        setState(() {
          isok = true;
          postModel.add(Person.fromJson(i));
        });
      }
    }else{
      setState(() {
        isok = true;
      });
    }
  }
  @override
  void initState() { 
    super.initState();
    getPostUser();
  }
  final _key = GlobalKey<FormState>();
  CustomTextField nom = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Nom');
  CustomTextField prenom = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Prénom');
  CustomTextField phone = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Téléphone');
  CustomTextField email = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Email');
  CustomTextField password = new CustomTextField(placeholder: 'Entrer la nouvelle valeur', title: 'Password');
  Person newPerson = new Person();
  bool poste = false;

  @override
  Widget build(BuildContext context) {
    nom.initialValue = widget.model.nom;
    prenom.initialValue = widget.model.prenom;
    phone.initialValue = widget.model.phoneNumber;
    email.initialValue = widget.model.email;
    password.initialValue = widget.model.password;
    //error = "Please enter valid value";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: Icon(Icons.account_circle_rounded),
        title: Text("Register"),
      ),
      body: isok?ListView.builder(
        itemCount: postModel.length,
        itemBuilder: (context, i){
          //final post = postModel[i];
              return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                          child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    // TextFormField(
                    //   //controller: nom,
                    //   textCapitalization: TextCapitalization.words,
                    //   decoration: InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     filled: true,
                    //     icon: Icon(Icons.person),
                    //     hintText: 'Enter new value there',
                    //     labelText: post.nom
                    //   ),
                    //   onSaved:  (value) {
                    //     this.postModel.nom = value;
                    //   },
                    //   validator: (value) {
                    //     if(value.isEmpty || value == null) return 'Please fill this space';
                    //       final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
                    //       if (!nameExp.hasMatch(value)) {
                    //         return 'This value is unvalid';
                    //       }
                    //       return null;
                    //       }
                          
                    // ),
                    nom.textfrofield(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    prenom.textfrofield(),
                    // TextFormField(
                    //   controller: prenom,
                    //   textCapitalization: TextCapitalization.words,
                    //   decoration: InputDecoration(
                        
                    //     border: UnderlineInputBorder(),
                    //     filled: true,
                    //     icon: Icon(Icons.person),
                    //     hintText: 'Enter your surname there',
                    //     labelText: 'Surname '
                    //   ),
                    //   onSaved: (String value) {
                    //     this.personne.prenom = value;
                    //     //print('nom=$_prenom');
                    //   },
                    //   validator: _validateName,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    phone.textfrofield(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    email.textfrofield(),
                    // TextFormField(
                    //   controller: phone,
                    //   decoration: InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     filled: true,
                    //     icon: Icon(Icons.phone),
                      
                    //     hintText: 'Your phone number',
                    //     labelText: 'Phone Number ',
                    //     prefixText: '+237',
                    //   ),
                    //   validator: _phoneNumberValidate
                    //   ,
                    //   keyboardType: TextInputType.phone,
                    //   onSaved: (String value) {
                    //     this.personne.phoneNumber = value;
                    //    // print('phoneNumber=$_phoneNumber');
                    //   },
                      
                    //   inputFormatters: <TextInputFormatter>[
                    //     FilteringTextInputFormatter.digitsOnly
                    //   ],
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    password.textfrofield(),
                    // TextFormField(
                    //   controller: email,
                    //   cursorColor: Colors.purple.shade500,
                    //   decoration: InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     filled: true,
                    //     icon: Icon(Icons.email),
                    //     hintText: 'Your email address',
                    //     labelText: 'Email',
                    //   ),
                    //   keyboardType: TextInputType.emailAddress,
                    //   onSaved: (String value) {
                    //     this.personne.email = value;
                    //     //print('email=$_email');
                    //   },
                    //   validator: _emailValidate,
                    // ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / h
                    // ),
                    // PasswordField(
                    //   controller: password,
                    //   fieldKey: _passwordFieldKey,
                    //   helperText: 'No more than 25 characters',
                    //   labelText: 'Password ',
                    //   onFieldSubmitted: (String value) {
                    //     setState(() {
                    //       this.personne.password = value;
                    //     });
                    //   }
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
            
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 10
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      color: Colors.purple[200],
                      width: MediaQuery.of(context).size.width / 20,
                      //padding: EdgeInsets.only(bottom: ),
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                    onPressed: poste?null: () async {
                      if (_key.currentState.validate()) {
                        setState(() {
                          poste = true;
                        });
                        newPerson.nom = nom.value;
                        newPerson.prenom = prenom.value;
                        newPerson.id = widget.model.id;
                        newPerson.phoneNumber = phone.value;
                        newPerson.email = email.value;
                        newPerson.password = password.value;
                        
                        var result = await Api.updatePost(newPerson.toJson());
                        if(result != null && result[0]){
                          setState(() {
                            poste = false;
                          });
                          Navigator.of(context).pop();
                        }else if(result != null && !result[0]){
                          setState(() {
                            poste = false;
                          });
                        }else{
                          setState(() {
                            poste = false;
                          });
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Modifier",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.redAccent.withOpacity(.7)),
                          )],
                ),
              ),
            ],
          )
        );
  }):Center(
                child: CircularProgressIndicator(),
              ),
    );
  }
}