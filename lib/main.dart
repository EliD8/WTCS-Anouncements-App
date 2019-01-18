import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'services/anouncementcode.dart';

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
  bool reviewFlag = false;
  var reviews;

  /*@override
  void initState(){
    super.initState();
    FetchAnouncements().getAnouncement(date).then((QuerySnapshot docs){
if (docs.documents.isNotEmpty){
  reviewFlag = true;
  reviews = docs.documents[0].data;
}

    });
  }*/

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
            SizedBox(height: 16.0),
            Text('$date', style: TextStyle(fontSize: 18.0)),
            Text(' \nAnnouncements \n', style: TextStyle(fontSize: 30.0)),
            StreamBuilder(
                stream: Firestore.instance.collection('asdf').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return FirestoreListView(documents: snapshot.data.documents);
                })
          ])));
}

class FirestoreListView extends StatelessWidget {
  final List<DocumentSnapshot> documents;

  FirestoreListView({this.documents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemExtent: 90.0,
      itemBuilder: (BuildContext context, int index) {
        String title = documents[index].data['title'].toString();

        return ListTile(
            title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.black),
                ),
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(title),
                    )
                  ],
                )));
      },
    );
  }
}
