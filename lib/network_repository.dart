import 'dart:convert';

import 'package:flutter_api/post.dart';
import 'package:flutter_api/user.dart';
import 'package:http/http.dart' as http;
class NetworkRepository{

  static final NetworkRepository instance = NetworkRepository();

  Future<List<Post>> getData() async {

    List<Post> postList = [];

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if(response.statusCode == 200){
      postList = postFromJson(response.body);
    }

    return postList;
  }

  Future<List<User>> userList() async{
    List<User> userList = [];
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      userList = userFromJson(response.body);
    }

    return userList;
  }


}