import 'package:FYPII/screens/update-profile.dart';
import 'package:FYPII/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:FYPII/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueGrey[900],
          title: Center(child: Text('LOG IN')),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //  Row(children: []),
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
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter an email!";
                              } else {
                                email = val;
                                return null;
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                icon: Icon(Icons.mail), hintText: 'Email')),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value.length < 6) {
                                return "Please enter at least 6 characters!";
                              } else {
                                password = value;
                                return null;
                              }
                            },
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock), hintText: 'Password')),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/forgotPassword'),
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 180.0,
                  child: FlatButton(
                      color: Colors.blueGrey[900],
                      child: Text('LOG IN', style: buttonStyle),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final snackBar = SnackBar(
                            duration: Duration(seconds: 10),
                            content: Row(
                              children: [
                                Text('Logging in. Wait for a few seconds!'),
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
                            duration: Duration(seconds: 3),
                            content: Text(
                                'There was an error with your credentials! Please login again.'),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          dynamic result = await _auth
                              .loginWithEmailAndPassword(email, password);

                          //var result = 'yes';
                          if (result == null) {
                            {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar2);
                            }
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            Navigator.popAndPushNamed(context, '/home');
                          }
                        }
                      }),
                ),
                Container(
                  width: 180.0,
                  child: FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('REGISTRATION PAGE', style: buttonStyle),
                    onPressed: () =>
                        Navigator.popAndPushNamed(context, '/register'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 15.0,
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
