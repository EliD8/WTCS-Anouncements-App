import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
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
  

  Widget displayAnouncementText(DateTime date) {
    String anouncementText = "No Anouncements Today";
    Firestore.instance
        .collection("days")
        .where("date", isEqualTo: "hello")
        //.snapshots()
       // .listen((data) =>
        //    anouncementText = "It works!"); // data.documents[0]['generic'].toString());
    //return Text(anouncementText);
    .getDocuments()
    .then((date) {
   date.documents.forEach((generic) => anouncementText = generic.data.toString());
    });
     return Text('$anouncementText');  
  }

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
           // displayAnouncementText(date),

            /* StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection('days')
                    .where("date", isEqualTo: date.toString())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return new Text('No Anoncements today');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text('Loading');
                    default:
                      return new Text('${snapshot.data.documents[0]['generic']}');
                  }
})*/
          ])));

  /* List<Widget> buildChildren(){

  }*/
}
