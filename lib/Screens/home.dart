import 'package:SaveApp/Models/person.dart';
import 'package:SaveApp/Screens/addPerson.dart';
import 'package:SaveApp/Screens/deletePage.dart';
import 'package:SaveApp/Screens/detailsPage.dart';
import 'package:SaveApp/Screens/registerList.dart';
import 'package:SaveApp/Screens/updatedPage.dart';
import 'package:SaveApp/api/api.dart';
import 'package:SaveApp/utils/variables.dart';
import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
 with SingleTickerProviderStateMixin {
  FancyDrawerController _controller;
  List <Person> person = [];
  //final _items = List<Person>.generate(20, (i) => "Items");

  getdata() async{
    var data = await Api.getList();
    if(data != null){
      person.clear();
      for(Map i in data){
        setState(() {
          person.add(Person.fromJson(i));
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
    _controller = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: FancyDrawerWrapper(
      controller: _controller,
      drawerItems: <Widget>[
        TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
            },
            icon: Icon(
              Icons.home,
              color: Colors.purple.shade700,
            ),
            label: Text(
              "Go to home",
              style: TextStyle(
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            )),
        TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPersonPage(),
                  ));
            },
            icon: Icon(
              Icons.person_add_sharp,
              color: Colors.purple.shade700,
            ),
            label: Text(
              "Add a person",
              style: TextStyle(
                  color: Colors.purple.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ))
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _controller.toggle();
            },
          ),
          title: Text("Register List "),
        ),
        body: ListView.builder(
            
            itemCount: person.length,
            itemBuilder: (context, index) {
              final post = person[index];
             // final String item = _items[index];
             if(person.length == 0){
              return Center(
                child: Text(
                  'Empty'
                ));
             }else{
              getdata();
              return FlatButton(
                onPressed: () {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => SimpleDialog(
                                    title: Text('About it'),
                                    children: <Widget>[
                                      ListView(
                                        children: <Widget>[
                                          Row(children: [
                                            Text('Nom'),
                                            Text(post.nom)
                                          ],),
                                          Row(
                                            children: [
                                              Text('Prénom'),
                                              Text(post.prenom)
                                            ]
                                          ),
                                          Row(children: [
                                            Text('Téléphone'),
                                            Text(post.phoneNumber)
                                          ],),
                                          Row(children: [
                                            Text('Email'),
                                            Text(post.email)
                                          ],),
                                          Row(children: [
                                            Text('Password'),
                                            Text(post.password)
                                          ],)
                                        ]
                                      )
                                    ]
                                  ));
                                  },
                              child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.purple[200],
                          child: Text('$index',
                              style: TextStyle(
                                color: Colors.purple.shade700,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        title: Text(post.nom),
                        trailing:
                            PopupMenuButton(itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem(
                                child: TextButton(
                              child: Text('Update',
                                  style: TextStyle(
                                      color: Colors.purple.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdatedPage(),
                                    ));
                              },
                            )),
                            PopupMenuItem(
                                child: TextButton(
                                    child: Text('Delete',
                                        style: TextStyle(
                                            color: Colors.purple.shade700,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    onPressed: () => DeletedPage()))
                          ];
                        },  
                        )),
              );}
            }
            ),
      ),
    ));
  }
}
