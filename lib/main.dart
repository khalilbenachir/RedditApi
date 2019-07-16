import 'package:flutter/material.dart';
import 'package:reditapi/models/reddit.dart';
import 'package:reditapi/models/serializer.dart';

import 'models/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddit App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  List<Post> _posts = [];
  @override
  void initState(){
    super.initState();
    getReddit().then((posts) {
      setState(() {
        _posts = posts;
      });
    });
  }

  List<Widget> builListTiles() {
    return _posts
        .map((post) => ListTile(
      leading: CircleAvatar(
        child: Image.network(
          '${!post.thumbnail.contains(".jpg") ? "http://via.placeholder.com/300" : post.thumbnail}',
          scale: 0.2,
        ),
      ),
      title: Text("Title : ${post.title} by ${post.author}" ),
      subtitle: Text("subreddit :${post.subreddit} with ${post.ups}"),
    ))
        .toList();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Reddit Top'),
      ),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
            child: AnimatedCrossFade(
                firstChild: Center(
                  child: CircularProgressIndicator(),
                ),
                secondChild: ListView(
                  children: builListTiles(),
                ),
                crossFadeState: _posts != null
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300)),
            onRefresh: () async {
              getReddit().then((posts) {
                setState(() {
                  _posts = posts;
                });
              });
            }),
      ),
    );
  }
}
