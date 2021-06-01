import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.blue),
    title: "Prova API web",
    home: HomePage(title: "Dashboard"),
  ));
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String month;
  void getJson() async {
    /*var url = Uri.parse("https://xkcd.com/info.0.json");
    Future<Map<String, dynamic>> fetchLastComic() async =>
        jsonDecode(await http.read(url));*/
    http.Response res = await http.get('https://xkcd.com/info.0.json');
    //print(res.body);
    Map<String, dynamic> data = json.decode(res.body);
    month = data["month"];
  }

  @override
  Widget build(BuildContext context) {
    getJson();
    //String month = fetchLastComi()
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Text("HomePage"));
  }
}
/*
String month;
  void getJson() async {
    /*var url = Uri.parse("https://xkcd.com/info.0.json");
    Future<Map<String, dynamic>> fetchLastComic() async =>
        jsonDecode(await http.read(url));*/
    http.Response res = await http.get('https://xkcd.com/info.0.json');
    print(res.body);
    Map<String, dynamic> data = json.decode(res.body);
    month = data["month"];
  }

  @override
  Widget build(BuildContext context) {
    getJson();
    //String month = fetchLastComi()
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Text("$month"),
    );
*/
