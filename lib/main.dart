import 'dart:core';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const appName = 'WTCS Anouncements';

void main() {     
      runApp(new MaterialApp(
      home: Bigboyscreen(),
      routes: <String, WidgetBuilder>{
      "/SecondPage": (BuildContext context) => new MyHomePage(),
      }
    ));
}

class Bigboyscreen extends StatefulWidget {
  @override

  _BigboyscreenState createState() => _BigboyscreenState();
}
class _BigboyscreenState extends State<Bigboyscreen> {

  final background = Container(
    decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/background.jpg'),
        fit: BoxFit.cover,
    ),
  ),
);

final whiteOpacity = Container(
color:Color(0xAA69),
);
  
  Widget build(BuildContext context) {
    return Scaffold(
       body: Stack(
        fit:StackFit.expand, 
        children: <Widget>[
          background, 
          Column (
            children: <Widget>[
            Expanded (flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.play_arrow, color: Colors.redAccent),
                iconSize: 70.0,
                onPressed: () {Navigator.of(context).pushNamed("/SecondPage");}
                ),
              ]
            ),
            
            
            ),
            ],
          ),
        ],
       ),
    );
    
  }
}
class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {


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
