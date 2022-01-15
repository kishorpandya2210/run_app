import 'package:flutter/material.dart';
import 'package:strava_flutter/Models/token.dart';
import 'package:strava_flutter/strava.dart';
import './secret.dart';

class HomePage extends StatefulWidget {
  // HomePage({@required this.strava});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Token> token;
  final strava = Strava(true, secret);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Run app'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RaisedButton(
                child: Text('Check Leaderboard'),
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                }),
            RaisedButton(
                child: Text('Connect wallet'),
                onPressed: () {
                  Navigator.pushNamed(context, '/connect-wallet');
                }),
            RaisedButton(
                child: Text('Logout'),
                onPressed: () async {
                  strava.deAuthorize();
                  Navigator.pushReplacementNamed(context, '/');
                })
          ],
        ),
      ),
    );
  }
}
