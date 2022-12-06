import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FYPII/constants.dart';
import 'package:FYPII/services/auth.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String error = '';
  dynamic result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('RESET PASSWORD'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Image.asset('images/stockvest.png',
                    width: double.infinity, height: 150),
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
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        margin: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an email!';
                              } else {
                                email = value;
                                return null;
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                icon: Icon(Icons.mail), hintText: 'Email')),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('SEND RESET LINK', style: buttonStyle),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final snackBar = SnackBar(
                          duration: Duration(seconds: 4),
                          content: Row(
                            children: [
                              Text('Successfully emailed the reset link!'),
                            ],
                          ),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        final snackBar2 = SnackBar(
                          duration: Duration(seconds: 4),
                          content: Row(
                            children: [
                              Text(
                                  'That email does not exist in our database!'),
                            ],
                          ),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        final snackBar3 = SnackBar(
                          duration: Duration(seconds: 2),
                          content: Row(
                            children: [
                              Text('Processing Credentials'),
                            ],
                          ),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                        // dynamic result = await _auth.resetPassword(email);

                        try {
                          result = await _auth.resetPassword(email);
                        } catch (error) {
                          print(error.code);
                          switch (error.code) {
                            case "user-not-found":
                              result = 'error';
                              break;
                            default:
                              result = null;
                          }
                        }
                        print(result);
                        if (result == null) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                        }
                      }
                    }),
              ),
            ],
          ),
        ));
  }
}
