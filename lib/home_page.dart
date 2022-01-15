import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              child: Text('Connect to Strava'),
              onPressed: () {},
            ),
            RaisedButton(
                child: Text('Check Leaderboard'),
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                }),
            RaisedButton(
                child: Text('Connect wallet'),
                onPressed: () {
                  Navigator.pushNamed(context, '/connect-wallet');
                })
          ],
        ),
      ),
    );
  }
}
