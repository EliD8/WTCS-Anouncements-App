import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const appName = 'WTCS Anouncements';

void main() => runApp(MaterialApp(
      title: appName,
      home: MyHomePage(),
      theme: ThemeData.light().copyWith(
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder())),
    ));

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime date;

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Today's Anouncements"), backgroundColor: Colors.green),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('days').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Text(
                    snapshot.data.documents[0]['anouncement'].replaceAll("\\n", "\n") ?? '',
                    style: TextStyle(fontSize: 18),
                  );
                })
          ])));
}
