import 'package:flutter/material.dart';
import 'package:flutter_api/network_repository.dart';
import 'package:flutter_api/post.dart';
import 'package:flutter_api/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum action { DEFAULT, POST_LIST, USER_LIST }

class _HomeState extends State<Home> {
  List<Post> _postList = [];
  List<User> _userList = [];

  var data = action.DEFAULT;

  @override
  void initState() {
    super.initState();
    NetworkRepository.instance.getData().then((posts) {
      setState(() {
        _postList = posts;
      });
    });

    NetworkRepository.instance.userList().then((value) {
      _userList = value;
      print(userToJson(_userList));
    });
  }

  Widget getText(String text) {
    return Text(text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
    );
  }

  Widget getPostListView() {
    switch (data) {
      case action.POST_LIST:
        {
          return ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Id : ${_postList[index].userId}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Id : ${_postList[index].id}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Title : ${_postList[index].title}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Body : ${_postList[index].body}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              });
        }

      case action.USER_LIST:
        {
          return ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getText(_userList[index].name),
                      getText(_userList[index].username),
                      getText(_userList[index].email),
                      getText(_userList[index].address.city),
                    ],
                  ),
                );
              });
        }

      default:
        {
          return const Text('Nothing to Show');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  data = action.POST_LIST;
                });
              },
              child: const Text('Post List')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  data = action.USER_LIST;
                });
              },
              child: const Text('User List')),
          Expanded(child: getPostListView()),
        ],
      ),
    );
  }
}
