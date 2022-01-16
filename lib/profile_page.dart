import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:run_app/secret.dart';
import 'package:strava_flutter/strava.dart';
import 'package:http/http.dart' as http;

class ProfileInfo extends StatefulWidget {
  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final strava = Strava(true, secret);
  var r;
  var activities;

  Future<void> fetchData() async {
    // String accessToken = strava.getStoredToken().toString();
    var localToken = await strava.getStoredToken();
    String at = localToken.accessToken;
    print(at);
    final response = await http.post(
      Uri.parse("https://delta-runft.herokuapp.com/api/strava/useractivity"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"accessToken": at}),
    );
    final responseJson = jsonDecode(response.body) as Map;
    print(responseJson);
    setState(() {
      r = responseJson;
      // activities = responseJson['activities'] as Map;
    });
    print(r);
    // final responseJson = jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 70,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
                colors: [Colors.cyan, Colors.blue],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter),
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RaisedButton(child: Text('Fetch Data'), onPressed: fetchData),
          r == null
              ? Text('Press the button above to retrieve data')
              : Column(
                  children: [
                    Text('Firstname: ' + r['firstname'].toString()),
                    Text('Lastname: ' + r['lastname'].toString()),
                    Text('Weight: ' + r['weight'].toString()),
                    Text('City: ' + r['city'].toString()),
                    Text('State: ' + r['state'].toString()),
                    Text('Country: ' + r['country'].toString()),
                    Text('Gender: ' + r['gender'].toString()),
                    Row(
                      children: [
                        Text('Activities: '),
                        Column(
                          children: r['activities'].length == 0
                              ? [Text('No activities')]
                              : [Text('Activities')],
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
