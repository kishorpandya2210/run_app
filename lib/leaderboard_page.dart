import 'package:flutter/material.dart';
import './models/person.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final persons = [
    Person(name: 'Kishor', totalMiles: 3000),
    Person(name: 'Adarsh', totalMiles: 3000),
    Person(name: 'Mit', totalMiles: 3000),
    Person(name: 'Het', totalMiles: 3000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'),
      ),
      body: Container(
        child: Column(
          children: persons.map((e) {
            return Text(e.name);
          }).toList(),
        ),
      ),
    );
  }
}
