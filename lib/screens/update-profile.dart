import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FYPII/services/auth.dart';
import 'package:FYPII/constants.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  final User user = FirebaseAuth.instance.currentUser;

  String error = '';
  String passwordCheck = '';
  String updatePassword = '';
  String password = '';
  String email = '';
  String formEmail = '';
  String oldPassword = '';

  createAlertBox(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                'CONFIRMATION',
                style: TextStyle(
                    fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Text(
                'ARE YOU SURE YOU WANT TO DELETE YOUR ACCOUNT?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              actions: [
                FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('DELETE MY ACCOUNT'),
                    onPressed: () async {
                      await user.delete();
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 3),
                        content: Text('Account successfully deleted!'),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {},
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.popAndPushNamed(context, '/login');
                    }),
                FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('EXIT'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

// 2

  createDeleteBox(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                'CONFIRM DETAILS',
                style: TextStyle(
                    fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              content: Form(
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
                            icon: Icon(Icons.mail), hintText: 'Confirm Email'),
                      ),
                    ),
                    Container(
                      width: 300,
                      child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            if (value.length < 6) {
                              return "Please enter at least 6 characters!";
                            } else {
                              oldPassword = value;
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
              actions: [
                FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('DELETE MY ACCOUNT'),
                    onPressed: () async {
                      await _auth.loginWithEmailAndPassword(email, oldPassword);
                      createAlertBox(context);
                    }),
                FlatButton(
                    color: Colors.blueGrey[900],
                    child: Text('EXIT'),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        automaticallyImplyLeading: true,
        title: Text('Update Profile'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[900],
                ),
                child: Center(
                  child: Text(
                    'Drawer',
                    style: TextStyle(
                      fontFamily: 'Comfortaa',
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.home),
                title: Text('Home'),
                onTap: () => Navigator.popAndPushNamed(context, '/dashboard')),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.chartBar),
                title: Text('Stock Prediction'),
                onTap: () => Navigator.popAndPushNamed(context, '/prediction')),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.pollH),
              title: Text('Market Summary'),
              onTap: () => Navigator.popAndPushNamed(context, '/marketSummary'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.database),
              title: Text('Data Portal'),
              onTap: () => Navigator.popAndPushNamed(context, '/dataPortal'),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.bullhorn),
                title: Text('PSX Announcements'),
                onTap: () =>
                    Navigator.popAndPushNamed(context, '/announcements')),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.newspaper),
              title: Text('Stock Market News'),
              onTap: () => Navigator.popAndPushNamed(context, '/marketNews'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.guilded),
              title: Text('Investment Tips'),
              onTap: () =>
                  Navigator.popAndPushNamed(context, '/investmentTips'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.penAlt),
              title: Text('Update Profile'),
              onTap: () => Navigator.popAndPushNamed(context, '/updateProfile'),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.idCard),
              title: Text('Contact Us'),
              onTap: () => Navigator.popAndPushNamed(context, '/contactUs'),
            ),
            ListTile(
                leading: FaIcon(FontAwesomeIcons.signOutAlt),
                title: Text('Sign Out'),
                onTap: () async {
                  await _auth.signOutFirebase();
                  Navigator.popAndPushNamed(context, '/login');
                }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 30.0,
            width: double.infinity,
            color: Colors.blueGrey[100],
          ),
          Container(
            height: 100.0,
            width: double.infinity,
            color: Colors.blueGrey[100],
            child: Image.asset('images/edit-profile.png',
                height: 400, width: 100, fit: BoxFit.contain),
          ),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.blueGrey[100],
            child: Text(
              'UPDATE YOUR PROFILE',
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 20.0,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 40.0),
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
                          formEmail = val;
                          return null;
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail), hintText: 'Confirm Email')),
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
                          oldPassword = value;
                          return null;
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock), hintText: 'Old Password')),
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
                          passwordCheck = value;
                          return null;
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock), hintText: 'New Password')),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val != passwordCheck) {
                          return "The passwords don't match";
                        } else if (val.length < 6) {
                          return "Please enter at least 6 characters!";
                        } else {
                          return null;
                        }
                      },
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          hintText: 'Confirm Password')),
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      color: Colors.blueGrey[900],
                      child: Text('UPDATE', style: buttonStyle),
                      onPressed: () async {
                        final snackBar = SnackBar(
                          duration: Duration(seconds: 10),
                          content: Text('Updating your profile. Please wait'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        final snackBar2 = SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text('Profile successfully updated!'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          EmailAuthProvider.credential(
                              email: 'email', password: 'password');

                          print(email);
                          print(password);
                          await _auth.loginWithEmailAndPassword(
                              email, password);
                          await user.updatePassword(password);

                          if (formEmail != email) {
                            error = 'Wrong Email';
                          }
                          if (passwordCheck == null) {
                            error = 'Please enter valid credentials!';
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar2);
                          }
                        }
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: FlatButton(
                      color: Colors.blueGrey[900],
                      child: Text('DELETE ACCOUNT', style: buttonStyle),
                      onPressed: () {
                        createDeleteBox(context);
                        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
