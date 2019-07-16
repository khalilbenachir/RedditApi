import 'dart:async';
import 'dart:convert';


import 'package:reditapi/models/reddit.dart';
import 'package:reditapi/models/serializer.dart';

import 'package:http/http.dart' as http;


const String url="https://www.reddit.com/r/popular/new.json?count=25";

Future<List<Post>> getReddit() async{
  final response =await http.get(Uri.parse(url));
  Reddit reddit =serializers.deserializeWith(Reddit.serializer, json.decode(response.body));

  return reddit.data.children.map((Data data)=>data.data).toList();
}