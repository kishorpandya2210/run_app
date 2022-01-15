import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_app/secret.dart';
import 'package:strava_flutter/strava.dart';
import './models/person.dart';
import 'package:http/http.dart' as http;

class LeaderBoardPage extends StatefulWidget {
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final strava = Strava(true, secret);

  final persons = [
    Person(name: 'Kishor', totalMiles: 3000),
    Person(name: 'Adarsh', totalMiles: 3000),
    Person(name: 'Mit', totalMiles: 3000),
    Person(name: 'Het', totalMiles: 3000),
  ];

  var response;

  Future<void> fetchData() async {
    // String accessToken = strava.getStoredToken().toString();
    // response = await http.post(
    //   Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    //   // Send authorization headers to the backend.
    //   headers: {
    //     HttpHeaders.authorizationHeader: accessToken,
    //   },
    // );
    // final responseJson = jsonDecode(response.body);
    // print(response.body);
    // print(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Image.asset('lib/Images/logout.png'),
          iconSize: 10,
          onPressed: () async {
            strava.deAuthorize();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('lib/Images/leaderboard.png'),
            iconSize: 10,
            tooltip: 'Check Leaderboards',
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('lib/Images/view-icon.png'),
            iconSize: 10,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/connect-wallet');
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.blue],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        children: [
          RaisedButton(child: Text('Get data'), onPressed: fetchData),
          Container(
            width: double.infinity,
            child: Column(
              children: persons.map((e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(e.name),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(e.totalMiles.toString()),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
