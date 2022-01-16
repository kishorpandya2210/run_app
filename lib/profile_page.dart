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
    // print(responseJson);
    setState(() {
      r = responseJson;
      // activities = responseJson['activities'] as Map;
    });
    print(r);
    // final responseJson = jsonDecode(response.body);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
      body: r == null
          ? Container(
              alignment: Alignment.center, child: const Text('Loading...'))
          : ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Firstname: ' + r['firstname'].toString()),
                ),
                ListTile(
                  title: Text('Lastname: ' + r['lastname'].toString()),
                ),
                ListTile(
                  title: Text('Gender: ' + r['gender'].toString()),
                ),
                ListTile(
                  title: Text('Weight: ' + r['weight'].toString()),
                ),
                ListTile(
                  title: Text('City: ' + r['city'].toString()),
                ),
                ListTile(
                  title: Text('State: ' + r['state'].toString()),
                ),
                ListTile(
                  title: Text('Country: ' + r['country'].toString()),
                ),
              ],
            ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Text('Firstname: ' + r['firstname'].toString()),
      //     Text('Lastname: ' + r['lastname'].toString()),
      //     Text('Weight: ' + r['weight'].toString()),
      //     Text('City: ' + r['city'].toString()),
      //     Text('State: ' + r['state'].toString()),
      //     Text('Country: ' + r['country'].toString()),
      //     Text('Gender: ' + r['gender'].toString()),
      //     Row(
      //       children: [
      //         const Text('Activities: '),
      //         Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: r['activities'].length == 0
      //               ? [const Text('No activities')]
      //               : [const Text('Activities')],
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
