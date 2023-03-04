
import 'package:flutter/material.dart';
import 'package:flutter_api/network_repository.dart';
import 'package:flutter_api/post.dart';
import 'package:flutter_api/user.dart';
import 'package:flutter_api/comment.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

enum action { DEFAULT, POST_LIST, USER_LIST, COMMENT_LIST }

class _HomeState extends State<Home> {
  List<Post> _postList = [];
  List<User> _userList = [];
  List<Comment> _commentList = [];
  Post? _post;

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
    });
  }

  void getPostById(int postId) {
    NetworkRepository.instance.getPostById(postId).then((value) {
      setState(() {
        _post = value;
      });
    });
  }

  void postData() {

    NetworkRepository.instance.postData().then((value) {

    });
  }



  void getCommentByPostId(int id){
    NetworkRepository.instance.getCommentByPostId(id).then((value) {
      setState(() {
        _commentList = value;
      });
    });
  }

  Widget getText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget getCommentText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget postContainer(Post? post) {
    if (post == null) {
      return const Text(
        'No Post Found',
        style: TextStyle(color: Colors.red),
      );
    } else {
      return Container(
        color: Colors.blue,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'User Id : ${post.userId}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Id : ${post.id}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Title : ${post.title}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Body : ${post.body}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
  }

  Widget getPostListView() {
    switch (data) {
      case action.POST_LIST:
        {
          return ListView.builder(
              itemCount: _postList.length,
              itemBuilder: (context, index) {
                return postContainer(_postList[index]);
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
      case action.COMMENT_LIST:
        {
          return ListView.builder(
              itemCount: _commentList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getCommentText("Id : ${_commentList[index].id.toString()}"),
                      getCommentText("Post ID : ${_commentList[index].postId}"),
                      getCommentText("Email : ${_commentList[index].email}"),
                      getCommentText(_commentList[index].body),
                    ],
                  ),
                );
              });
        }

      default:
        {
          return const Text('Nothing to Show in List');
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
          ElevatedButton(
              onPressed: () {
                setState(() {
                  data = action.DEFAULT;
                  getPostById(1);
                });
              },
              child: const Text('Post By Id')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  getCommentByPostId(1);
                  data = action.COMMENT_LIST;
                });
              },
              child: const Text('Post Query By Id')),

          ElevatedButton(
              onPressed: () {
                setState(() {
                  postData();
                });
              },
              child: const Text('Post Data')),
          const SizedBox(
            height: 10,
          ),
          const Text('Element'),
          const SizedBox(
            height: 10,
          ),
          postContainer(_post),
          const SizedBox(
            height: 10,
          ),
          const Text('List'),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: getPostListView()),
        ],
      ),
    );
  }


}
