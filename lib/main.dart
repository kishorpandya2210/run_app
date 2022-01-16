import 'package:flutter/material.dart';
import 'package:run_app/connect_wallet.dart';
import 'package:run_app/leaderboard_page.dart';
import 'package:run_app/login_strava.dart';
import 'package:run_app/profile_page.dart';
import './home_page.dart';
import 'mint_page.dart';

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
      // home: StravaLogin(),
      initialRoute: '/',
      routes: {
        '/': (context) => StravaLogin(),
        // '/homepage': (context) => HomePage(),
        '/leaderboard': (context) => LeaderBoardPage(),
        '/connect-wallet': (context) => ConnectWallet(),
        '/minting': (context) => MintPage(),
        '/profile': (context) => ProfileInfo(),
      },
    );
  }
}
