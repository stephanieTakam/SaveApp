import 'package:SaveApp/Models/person.dart';
import 'package:SaveApp/api/api.dart';
import 'package:flutter/material.dart';

class DeletedPage extends StatefulWidget {
  const DeletedPage({ Key key }) : super(key: key);

  @override
  State<DeletedPage> createState() => _DeletedPageState();
}

class _DeletedPageState extends State<DeletedPage> {
  List<Person> postModel = [];
bool isok = false;
getPostUser() async{
  setState(() {
    isok = false;
  });
    var data = await Api.getPost();
    if(data != null){
      postModel.clear();
      setState(() {
          isok = true;
      });
      for(Map i in data){
        setState(() {
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
  List<bool> valueCheck = [];
  List idposts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Supprimer un Post"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){
            if(idposts.length > 0){
              showDialog(context: context,
              builder:(context){
                return AlertDialog(
                  title: Text("Supprimer"),
                  content: Text("Voulez-vous supprimer?"),
                  actions: [
                    FlatButton(onPressed: () async{
                      var isdelete = await Api.deletePost(idposts);
                      if (isdelete != null) {
                        if(isdelete[0]){
                          setState(() {
                            idposts.clear();
                            Navigator.of(context).pop();
                            getPostUser();
                          });
                        }
                      } else {
                        Navigator.of(context).pop();
                      }
                    }, child: Text("Oui")),
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: Text("Non")),
                  ],
                );
              }
              );
            }
          }),
        ],
      ),
      body: isok?ListView.builder(
                itemCount: postModel.length,
                itemBuilder: (context, i){
                  final post = postModel[i];
                  valueCheck.add(false);
                  return Card(
                    color: Colors.green[100],
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.nom, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(post.prenom),
                          Divider(),
                          Text(post.phoneNumber, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(post.email, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Text(post.password, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Divider(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Checkbox(
                              value: valueCheck[i],
                              onChanged: (bool value){
                                setState(() {
                                  valueCheck[i] = value;
                                  if(valueCheck[i]) idposts.add(post.id);
                                  else idposts.remove(post.id);
                                  print(idposts);
                                });
                              },
                            )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ):Center(
                child: CircularProgressIndicator(),
              ),
    );
  }
}