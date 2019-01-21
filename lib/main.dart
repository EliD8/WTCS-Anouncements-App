import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
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
      appBar: AppBar(title: Text(appName), backgroundColor: Colors.green),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Text('Select a date to view anouncements',
                style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            DateTimePickerFormField(
              format: dateFormat,
              decoration: InputDecoration(labelText: 'Date'),
              onChanged: (dt) => setState(() => date = dt),
              dateOnly: (true),
              maxLengthEnforced: true,
            ),
            Text("\n"),
            StreamBuilder(
                stream: Firestore.instance.collection('days').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  if (snapshot.data.documents[0][date.toString()] == null) {
                    return Text(
                      "No Anouncements Today",
                      style: TextStyle(fontSize: 20.0),
                    );
                  }
                  return Text(snapshot.data.documents[0][date.toString()].replaceAll("\\n", "\n") ?? '',
                      style: TextStyle(fontSize: 20));
                })
          ])));
}
