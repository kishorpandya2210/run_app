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

  Future<void> fetchData() async {
    Token accessToken = await strava.getStoredToken();
    String token = accessToken.accessToken.toString();
    // response = await http.post(
    //   Uri.parse('https://delta-runft.herokuapp.com/api/strava/activities',),
    //   // Send authorization headers to the backend.
    //   headers: {
    //     HttpHeaders.authorizationHeader: token,
    //   },
    // );
    // var uri = Uri(
    //   scheme: 'https',
    //   host: 'delta-runft.herokuapp.com',
    //   path: '/api/strava/activities',
    // );
    final response = await http.post(
      Uri.parse('https://delta-runft.herokuapp.com/api/strava/activities'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: token,
      },
      body: jsonEncode(<String, String>{
        "accessToken": "2854e33b76cf6f6dfae19376dc7d548de0b0d86a"
      }),
    );
    final responseJson = jsonDecode(response.body);
    print(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 15),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(), primary: Colors.blueAccent),
          child: Container(
            width: 70,
            height: 70,
            alignment: Alignment.center,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 40.0,
            ),
          ),
          onPressed: fetchData,
        ),
      ),
    );
  }
}
