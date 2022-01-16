// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:strava_flutter/strava.dart';
import './secret.dart';

// ignore: use_key_in_widget_constructors
class StravaLogin extends StatefulWidget {
  @override
  _StravaLoginState createState() => _StravaLoginState();
}

class _StravaLoginState extends State<StravaLogin> {
  final strava = Strava(true, secret);
  bool isAuthOk = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Image.asset('lib/Images/big running icon.png'),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'ruNFT',
                    style: TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.w500,
                      fontSize: 45,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    //Strava login screen
                    // Navigator.pushNamed(context, '/homepage');
                    print("reached");
                    isAuthOk = await strava.oauth(
                        clientID,
                        'activity:write,activity:read_all,profile:read_all,profile:write',
                        secret,
                        'auto');
                    // print(isAuthOk.toString());
                    if (isAuthOk) {
                      Navigator.pushReplacementNamed(context, '/leaderboard',
                          arguments: strava);
                    } else {
                      strava.deAuthorize();
                      // Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.teal, Colors.greenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Connect to Strava',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
