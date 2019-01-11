import 'dart:core';

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
 


  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(appName),
        backgroundColor: Colors.green
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text('Select a date to view anouncements', style: TextStyle(fontSize: 18.0)),
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
            

          StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('days').where("date", isEqualTo:
        date.toString()).snapshots(),
        builder: (BuildContext context, 
              AsyncSnapshot<QuerySnapshot> snapshot) {
                if(!snapshot.hasData){
                  return Text('ya YEET');
                }
              return Text('${snapshot.data.documents[0]['generic']}');
              }
              
        
)
      
        /*  
         Firestore.instance.collection('days').where("date", isEqualTo: date.toString())
            .snapshots().listen((data) =>
              data.documents.forEach((doc) => Text(doc['generic'])))
          */
       
       
       
       
    
         /* StreamBuilder(
  stream: Firestore.instance.collection("days").snapshots(),
  builder: (BuildContext context, snapshot) {
    if (snapshot.hasError)
      return Text('Error: ${snapshot.error}');
    switch (snapshot.connectionState) {
      case ConnectionState.none: return Text('Select a date');
      case ConnectionState.waiting: return Text('Loading');
      case ConnectionState.active: 
      Firestore.instance.collection('days').where("date", isEqualTo: date.toString())
            .snapshots().listen((data) =>
              data.documents.forEach((doc) => Text(doc['generic'])));
     // return Text('\$${snapshot.data}');
      break;
      case ConnectionState.done: return Text('\$${snapshot.data} (closed)');
    }
    return null; // unreachable
  },
          )
*/
          ]
        )));
}


    



/*
            StreamBuilder(
              stream: Firestore.instance.collection('days').document(date.toString()).snapshots(),
              builder: (context, snapshot){
                
                
                print(date);
                if(!snapshot.hasData) 
                  {
                    return Text('Loading Data');
                }

                if (date == null)
                {
                  return Text ('No Data available');
                }

                if ('[]' == null)
                {
                  return Text ('No Data available');
                }
              else{
                  //Something here
              }
              },*/
