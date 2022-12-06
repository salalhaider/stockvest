import 'package:FYPII/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:FYPII/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state

  String name = '';
  String email = '';
  String password = '';
  String passwordCheck = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    void changeErrorState(String errorText) {
      setState(() {
        error = errorText;
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: Text('REGISTER'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 40.0, 0, 0),
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
                            return "Enter an email!";
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
                        validator: (val) {
                          passwordCheck = val;
                          if (val.length < 6) {
                            return "Enter a password that's at least 6 characters!";
                          } else {
                            password = val;
                            return null;
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock), hintText: 'Password')),
                  ),
                  Container(
                    width: 300,
                    child: TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val != passwordCheck) {
                            return "The passwords don't match";
                          } else if (val.length < 6) {
                            return "Enter a password that's at least 6 characters!";
                          } else {
                            return null;
                          }
                        },
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            hintText: 'Confirm Password')),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: 150.0,
              child: FlatButton(
                  color: Colors.blueGrey[900],
                  child: Text('REGISTER', style: buttonStyle),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 10),
                        content: Text('Registering. Wait for a few seconds!'),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      final snackBar2 = SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text(
                            'Successfully registered! You may now log in.'),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        changeErrorState('Please enter a valid email!');
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                        Navigator.popAndPushNamed(context, '/login');
                      }
                    }
                  }),
            ),
            Container(
              width: 150.0,
              child: FlatButton(
                color: Colors.blueGrey[900],
                child: Text('LOGIN PAGE', style: buttonStyle),
                onPressed: () => Navigator.popAndPushNamed(context, '/login'),
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
    );
  }
}
