import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

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
  final dateFormat = DateFormat("EEEE, MMMM d, yyyy");
  DateTime date;
  @override
  Widget build(BuildContext context) => Scaffold(
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
            ),
            SizedBox(height: 16.0),
            Text('$date', style: TextStyle(fontSize: 18.0)),
          ],
        ),
      ));
}