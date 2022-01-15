import 'package:flutter/material.dart';

class StravaLogin extends StatefulWidget {
  @override
  _StravaLoginState createState() => _StravaLoginState();
}

class _StravaLoginState extends State<StravaLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Image.asset('lib/Images/big running icon.png'),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Run App',
                      style: TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.w500,
                          fontSize: 45),
                    )),
                FlatButton(
                  onPressed: (){
                    //Strava login screen
                    //Navigator.pushNamed(context, '/homepage');
                  },
                  child: Container(
                    width: 300,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.teal,
                          Colors.greenAccent
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                            offset: Offset(5, 5),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Center(
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
