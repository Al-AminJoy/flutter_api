import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_api/comment.dart';
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

  Future<Post?> getPostById(int id) async{
    Post? post ;

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$id"));

    if(response.statusCode == 200){
      post = Post.fromJson(jsonDecode(response.body.toString()));
    }

    return post;

  }

  Future<List<Comment>> getCommentByPostId(int id) async {

    List<Comment> commentList = [];

    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=$id"));

    if(response.statusCode == 200){
      commentList = commentFromJson(response.body);
    }

    return commentList;

  }

  Future<dynamic> postData()async{
    Post post = Post(userId: 1, id: 5, title: "No Title", body: "No Body");

    var postData = json.encode(post.toJson());

    Map<String,String> header = {
      'Content-Type': 'application/json',
      'Data': 'data'
    };

    http.Response response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),headers: header,body: postData);
    if(response.statusCode == 201){
      Post post = Post.fromJson(json.decode(response.body));
     // debugPrint(response.headers.toString());
      debugPrint(post.toJson().toString());
    }

  }

}