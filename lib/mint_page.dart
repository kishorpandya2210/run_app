import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strava_flutter/Models/token.dart';
import 'package:strava_flutter/strava.dart';
import './secret.dart';
import 'package:http/http.dart' as http;

class MintPage extends StatefulWidget {
  const MintPage({Key key}) : super(key: key);

  // MintPage({@required this.strava});

  @override
  _MintPageState createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  TextEditingController walletInput = TextEditingController();
  TextEditingController idInput = TextEditingController();
  TextEditingController apilog = TextEditingController();

  Future<Token> token;
  final strava = Strava(true, secret);

  var response;
  var responseString = "";

  Future<void> fetchData() async {
    var localToken = await strava.getStoredToken();
    String at = localToken.accessToken;

    if (walletInput.text == "" || idInput.text == "") {
      return;
    }

    final response = await http.post(
      Uri.parse("https://delta-runft.herokuapp.com/api/token/mint/" +
          walletInput.text +
          "/" +
          idInput.text),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{"accessToken": at}),
    );

    final responseJson = jsonDecode(response.body);
    print(responseJson);
    responseString = responseJson.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add NFT'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 25,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/connect-wallet');
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 70,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.blue],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: walletInput,
              decoration: InputDecoration(
                labelText: 'Enter your wallet address',
              ),
              // onChanged: (value) {
              //   setState(() {
              //     walletInput.text = value.toString();
              //   });
              // },
            ),
            TextField(
              controller: idInput,
              decoration: InputDecoration(
                labelText: 'Enter activity to mint (id)',
              ),
              // onChanged: (value) {
              //   setState(() {
              //     idInput.text = value.toString();
              //   });
              // },
            ),
            FlatButton(
              padding: const EdgeInsets.all(30),
              onPressed: () {
                fetchData();
                print("was cliekd");
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.redAccent, Colors.purpleAccent],
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
                    'Mint',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "show output here",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
