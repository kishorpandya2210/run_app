import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_app/secret.dart';
import 'package:strava_flutter/Models/token.dart';
import 'package:strava_flutter/globals.dart';
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

  // Future<void> fetchData() async {
  //   var localToken = await strava.getStoredToken();
  //   String at = localToken.accessToken;
  //   print(at);
  //   final response = await http.post(
  //     Uri.parse("https://delta-runft.herokuapp.com/api/strava/activities"),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{"accessToken": at}),
  //   );
  //   final responseJson = jsonDecode(response.body) as List;
  //   // final responseJson = jsonDecode(response.body);
  //   print(response.body);
  //   print(responseJson);
  // }

  var leaderData = [];

  Future<void> getLeaderData(String path) async {
    final url = "https://delta-runft.herokuapp.com/api/leaders/" + path;
    try {
      final response = await http.get(Uri.parse(url));
      final responseJson = jsonDecode(response.body) as List;
      setState(() {
        leaderData = responseJson;
      });
      // print(response.body);
      // print(responseJson);
      // print(leaderData[0]['attributes']);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.logout),
          color: Colors.white,
          iconSize: 25,
          onPressed: () async {
            strava.deAuthorize();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.leaderboard),
            color: Colors.white,
            iconSize: 25,
            tooltip: 'Check Leaderboards',
            onPressed: () {},
          ),
          IconButton(
            // icon: Image.asset('lib/Images/view-icon.png'),
            icon: Icon(Icons.account_balance_wallet),
            color: Colors.white,
            iconSize: 25,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/connect-wallet');
            },
          ),
          IconButton(
            icon: Icon(Icons.info),
            color: Colors.white,
            iconSize: 25,
            tooltip: 'Profile info',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RaisedButton(
                        child: Text('Daily'),
                        onPressed: () => getLeaderData("daily")),
                    RaisedButton(
                        child: Text('Weekly'),
                        onPressed: () => getLeaderData("weekly")),
                    RaisedButton(
                        child: Text('Global'),
                        onPressed: () => getLeaderData("global"))
                  ]),
            ),
            Container(
              width: double.infinity,
              child: Column(
                  children: leaderData.map((index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(index['attributes'][3]['value'].toString() + " "),
                    Text(index['attributes'][4]['value'].toString()),
                    SizedBox(
                      width: 20,
                    ),
                    Text(index['attributes'][0]['value'].toString()),
                  ],
                );
              }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
