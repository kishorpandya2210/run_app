import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strava_flutter/Models/token.dart';
import 'package:strava_flutter/strava.dart';
import './secret.dart';

class MintPage extends StatefulWidget {
  const MintPage({Key key}) : super(key: key);

  // MintPage({@required this.strava});

  @override
  _MintPageState createState() => _MintPageState();
}

class _MintPageState extends State<MintPage> {
  Future<Token> token;
  final strava = Strava(true, secret);

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
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your wallet address',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter activity to mint (id)',
              ),
            ),
            FlatButton(
              padding: const EdgeInsets.all(30),
              onPressed: () {
                //Add new NFT to wallet
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
          ],
        ),
      ),
    );
  }
}
