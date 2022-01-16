import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:run_app/secret.dart';
import 'package:strava_flutter/Models/token.dart';
import 'package:strava_flutter/strava.dart';
import 'package:http/http.dart' as http;

class ReloadButton extends StatefulWidget {
  @override
  _ReloadButtonState createState() => _ReloadButtonState();
}

class _ReloadButtonState extends State<ReloadButton> {
  final strava = Strava(true, secret);
  var response;

  var leaderData = [];

  Future<void> getLeaderData(String path) async {
    final url = "https://delta-runft.herokuapp.com/api/leaders/" + path;
    try {
      final response = await http.get(Uri.parse(url));
      final responseJson = jsonDecode(response.body) as List;
      setState(() {
        leaderData = responseJson;
      });
      print(response.body);
      print(responseJson);
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RaisedButton(
            onPressed: () => getLeaderData,
            child: Text('Daily'),
          ),
          RaisedButton(
            onPressed: () => getLeaderData,
            child: Text('Weekly'),
          ),
          RaisedButton(
            onPressed: () => getLeaderData,
            child: Text('Global'),
          ),
        ],
      ),
    );
  }
}
