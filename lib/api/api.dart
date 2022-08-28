import 'dart:convert';

import '../crypt/encrypt.dart';
import 'package:http/http.dart' as http;

class Api {
  static addPost(Map data) async{
    final response = await http.post(Url.addPost, body: {
      "data": encrypt(jsonEncode(data))
    });

    if(response.statusCode == 200){
      var result = jsonDecode(decrypt(response.body));
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static getPost() async{
    final response = await http.get(Url.getpost);
    if(response.statusCode == 200){
      return jsonDecode(decrypt(response.body));
    } else{
      return null;
    }
  }

  static getList() async{
    final response = await http.get(Url.listpost);
    if(response.statusCode == 200){
      return jsonDecode(decrypt(response.body));
    } else{
      return null;
    }
  }

  static getPostUser(String id) async{
    final response = await http.post(Url.upost, body: {
      "id_person":encrypt(id),
      "type": encrypt("1")
    });

    if(response.statusCode == 200){
      return jsonDecode(decrypt(response.body));
    } else{
      return null;
    }
  }

  static updatePost(Map data) async{
    final response = await http.post(Url.upost, body: {
      "data": encrypt(jsonEncode(data)),
      "type": encrypt("2")
    });

    if(response.statusCode == 200){
      var result = jsonDecode(decrypt(response.body));
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }

  static deletePost(List data) async{
    final response = await http.post(Url.delete, body: {
      "id_posts": encrypt(jsonEncode(data)),
    });
    if(response.statusCode == 200){
      var result = jsonDecode(decrypt(response.body));
      print(result[0]);
      if(result[0]) return result;
      else return null;
    }else{
      return null;
    }
  }
}

class Url {
  static String addPost = "http://192.168.186.6:8000/addPost.php";
  static String getpost = "http://localhost:8000/getpost.php";
  static String upost = "http://localhost:8000/updatepost.php";
  static String delete = "http://localhost:8000/deletepost.php";
  static String listpost = "http://localhost/list.php";
}