import 'package:flutter/material.dart';
import 'package:run_app/secret.dart';
import 'package:strava_flutter/strava.dart';
import 'package:flutter/services.dart';

class ConnectWallet extends StatefulWidget {
  const ConnectWallet({Key key}) : super(key: key);

  @override
  _ConnectWalletState createState() => _ConnectWalletState();
}

class _ConnectWalletState extends State<ConnectWallet> {
  final strava = Strava(true, secret);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Collections'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.logout),
          color: Colors.white,
          iconSize: 25,
          onPressed: () async {
            strava.deAuthorize();
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.leaderboard),
            color: Colors.white,
            iconSize: 25,
            tooltip: 'Check Leaderboards',
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/leaderboard');
            },
          ),
          IconButton(
            // icon: Image.asset('lib/Images/view-icon.png'),
            icon: const Icon(Icons.account_balance_wallet),
            color: Colors.white,
            iconSize: 25,
            onPressed: () {},
          ),
        ],
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // ignore: sized_box_for_whitespace
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
            ),
            FlatButton(
              onPressed: () {
                //Go to wallet with all your NFTS
              },
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Colors.cyan],
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
                    'View Wallet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/minting');
              },
              child: Container(
                width: 300,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.teal, Colors.cyan],
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
                    'Add new NFTs',
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
