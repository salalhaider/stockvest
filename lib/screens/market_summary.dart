import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FYPII/services/auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketSummary extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          automaticallyImplyLeading: true,
          title: Text('Market Summary'),
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
                  onTap: () =>
                      Navigator.popAndPushNamed(context, '/dashboard')),
              ListTile(
                  leading: FaIcon(FontAwesomeIcons.chartBar),
                  title: Text('Stock Prediction'),
                  onTap: () =>
                      Navigator.popAndPushNamed(context, '/prediction')),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.pollH),
                title: Text('Market Summary'),
                onTap: () =>
                    Navigator.popAndPushNamed(context, '/marketSummary'),
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
                    Navigator.popAndPushNamed(context, '/updateProfile'),
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
        body: WebView(
            initialUrl: 'https://psx.com.pk/market-summary',
            javascriptMode: JavascriptMode.unrestricted));
  }
}
