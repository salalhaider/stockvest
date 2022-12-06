import 'package:flutter/material.dart';
import 'package:FYPII/constants.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Center(),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 50.0),
                    height: 140,
                    width: 140,
                    child: Image.asset('images/stockvest.png'),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Stock',
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 20.0,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Vest',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 60.0, 0, 10.0),
              child: Text(
                'WELCOME TO STOCKVEST !',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                  //color: Colors.blueGrey[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              child: Text(
                'THE STOCK PREDICTION APP',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  //color: Colors.blueGrey[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30.0),
              child: Text(
                'LET\'S GET STARTED!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                  //color: Colors.blueGrey[900],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      'LOG IN',
                      style: buttonStyle,
                    ),
                    onPressed: () => {Navigator.pushNamed(context, '/login')},
                    color: Colors.blueGrey[900],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text(
                    'REGISTER',
                    style: buttonStyle,
                  ),
                  onPressed: () => {
                    Navigator.pushNamed(context, '/register'),
                  },
                  color: Colors.blueGrey[900],
                )
              ],
            )
          ],
        ));
  }
}
