import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FYPII/services/auth.dart';
import 'package:FYPII/screens/update-profile.dart';
//import 'package:FYPII/constants.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        automaticallyImplyLeading: true,
        title: Text('Home'),
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
                onTap: () =>
                    Navigator.popAndPushNamed(context, '/updateProfile')),
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
            // alignment: Alignment.center,
            width: double.infinity,
            color: Colors.blueGrey[100],
            child: Image.asset('images/dash.png',
                height: 400, width: 100, fit: BoxFit.contain),
          ),
          Container(
            height: 50.0,
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.blueGrey[100],
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
            margin: EdgeInsets.only(top: 40.0),
            child: Text(
              'WELCOME TO YOUR HOME PAGE !',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 5.0),
            child: Text(
              'TAP ON THE DRAWER ICON ON THE TOP LEFT !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                fontSize: 17.0,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
