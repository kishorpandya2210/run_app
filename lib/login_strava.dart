import 'package:flutter/material.dart';

class StravaLogin extends StatefulWidget {
  @override
  _StravaLoginState createState() => _StravaLoginState();
}

class _StravaLoginState extends State<StravaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login with Strava'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text('Connect with Strava'),
          onPressed: () {},
        ),
      ),
    );
  }
}
