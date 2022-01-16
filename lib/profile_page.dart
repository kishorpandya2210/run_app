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
    setState(() {
      r = responseJson;
    });
    print(r);
  }

  List<Map<String, Object>> ans = [];

  Future<void> fetchDataActivity() async {
    var localToken2 = await strava.getStoredToken();
    String at2 = localToken2.accessToken;
    print(at2);
    final response = await http.post(
      Uri.parse(
          "https://delta-runft.herokuapp.com/api/strava/useractivitylist"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"accessToken": at2}),
    );
    final responseJson2 = jsonDecode(response.body);
    setState(() {
      activities = responseJson2;
    });
    print(activities.toString());
    while (activities == null) {}
    getList();
  }

  void getList() {
    if (activities.length == 0) {
      return;
    }
    for (int i = 0; i < activities.length; i++) {
      Map<String, Object> temp;
      // print(activities[i]['name'].toString());
      String id = activities[i]['id'].toString();
      String name = activities[i]['name'].toString();
      String distance = activities[i]['distance'].toString();
      String type = activities[i]['type'].toString();
      // temp.putIfAbsent('name', () => activities[i]['name'].toString());
      // temp.putIfAbsent('distance', () => activities[i]['distance'].toString());
      // temp.putIfAbsent('type', () => activities[i]['type'].toString());
      temp = {'id': id, 'name': name, 'distance': distance, 'type': type};
      // print(temp.toString());
      ans.add(temp);
    }

    // print(ans.toString());
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchDataActivity();
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
                ans.length == 0
                    ? ListTile(
                        title: Text('No activities'),
                      )
                    : ListTile(
                        title: Text('Activities: '),
                      ),
                Column(
                  children: ans.map((index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text('ID: ' + index['id'].toString()),
                        ),
                        ListTile(
                          title: Text('Name: ' + index['name'].toString()),
                        ),
                        ListTile(
                          title:
                              Text('Distance: ' + index['distance'].toString()),
                        ),
                        ListTile(
                          title: Text('Type: ' + index['type'].toString()),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  }).toList(),
                )
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
