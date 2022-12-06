import 'package:flutter/material.dart';
import 'package:FYPII/services/auth.dart';

class DisclaimerScreen extends StatefulWidget {
  @override
  _DisclaimerScreenState createState() => _DisclaimerScreenState();
}

class _DisclaimerScreenState extends State<DisclaimerScreen> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: Text('DISCLAIMER AGREEMENT'),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100.0),
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Text('DISCLAIMER',
                  style: TextStyle(
                      fontFamily: 'Nanum Gothic', fontWeight: FontWeight.bold)),
              content: Text(
                  'The developers of this app are not responsible for any potential losses you might have as this is purely a stock PREDICTION app',
                  style: TextStyle(fontFamily: 'Nanum Gothic')),
              actions: [
                FlatButton(
                  child: Text('Agree'),
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/dashboard'),
                ),
                FlatButton(
                  child: Text('Disagree'),
                  onPressed: () async {
                    await _auth.signOutFirebase();
                    Navigator.popAndPushNamed(context, '/login');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
