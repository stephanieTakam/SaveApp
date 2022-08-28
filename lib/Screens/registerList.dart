//import 'package:SaveApp/Screens/acceuil.dart';
//import 'package:SaveApp/Models/person.dart';
import 'package:SaveApp/Screens/addPerson.dart';
import 'package:SaveApp/Screens/deletePage.dart';
import 'package:SaveApp/Screens/detailsPage.dart';
import 'package:SaveApp/Screens/updatedPage.dart';
import 'package:SaveApp/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:fancy_drawer/fancy_drawer.dart';

class RegisterListPage extends StatefulWidget {
  const RegisterListPage({Key key}) : super(key: key);

  @override
  State<RegisterListPage> createState() => _RegisterListPageState();
}

class _RegisterListPageState extends State<RegisterListPage>
    with SingleTickerProviderStateMixin {
  FancyDrawerController _controller;
  final _items = List<String>.generate(20, (i) => "Items");

  @override
  void initState() {
    super.initState();
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
                    builder: (context) => RegisterListPage(),
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
            itemCount: _items.length,
            itemBuilder: (context, index) {
             // final String item = _items[index];
              return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple[200],
                        child: Text('$index',
                            style: TextStyle(
                              color: Colors.purple.shade700,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      title: Text('Items'),
                      trailing:
                          PopupMenuButton(itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: TextButton(
                            child: Text('More',
                                style: TextStyle(
                                    color: Colors.purple.shade700,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(),
                                  ));
                            },
                          )),
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
                      ));
            }
            ),
      ),
    ));
  }
}
