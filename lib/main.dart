import 'package:flutter/material.dart';
import 'package:run_app/leaderboard_page.dart';
import './home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Run App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      // initialRoute: '/',
      routes: {
        // '/': (context) => HomePage(),
        '/leaderboard': (context) => LeaderBoardPage()
      },
    );
  }
}
