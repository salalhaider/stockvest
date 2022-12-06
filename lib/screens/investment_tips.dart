import 'package:flutter/material.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:FYPII/services/auth.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InvestmentTips extends StatefulWidget {
  @override
  _InvestmentTipsState createState() => _InvestmentTipsState();
}

class _InvestmentTipsState extends State<InvestmentTips> {
  final AuthService _auth = AuthService();
  final PageController ctrl = PageController();
  final List<String> imgList = [
    'https://firebasestorage.googleapis.com/v0/b/fyp-ii-5af8a.appspot.com/o/dasdasd.jpg?alt=media&token=ee685f75-e16b-400e-bc25-17408c82868e',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        automaticallyImplyLeading: true,
        title: Text('Investment Tips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20.0,
              width: double.infinity,
              color: Colors.blueGrey[100],
            ),
            Container(
              height: 60.0,
              width: double.infinity,
              color: Colors.blueGrey[100],
              child: Image.asset('images/tips.png',
                  height: 300, width: 100, fit: BoxFit.contain),
            ),
            Container(
              height: 50.0,
              alignment: Alignment.center,
              width: double.infinity,
              color: Colors.blueGrey[100],
              child: Text(
                'SWIPE FOR TIPS',
                style: TextStyle(
                    color: Colors.blueGrey[900],
                    fontSize: 20.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                height: 400.0,
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
                child: PageView(
                  children: [
                    buildCard(
                        '1',
                        'SUCCESS IN INVESTING DOESN’T CORRELATE WITH IQ. WHAT YOU NEED IS THE TEMPERAMENT TO CONTROL THE URGES THAT GET OTHER PEOPLE INTO TROUBLE IN INVESTING. THAT IS WISDOM FROM WARREN BUFFETT, CHAIRMAN OF BERKSHIRE HATHAWAY AND AN OFT-QUOTED INVESTING SAGE AND ROLE MODEL FOR INVESTORS SEEKING LONG-TERM, MARKET-BEATING, WEALTH-BUILDING RETURNS',
                        Colors.blueGrey[900]),
                    buildCard(
                        '2',
                        'IT’S EASY TO FORGET THAT BEHIND THE ALPHABET SOUP OF STOCK QUOTES CRAWLING ALONG THE BOTTOM OF EVERY CNBC BROADCAST IS AN ACTUAL BUSINESS. BUT DON’T LET STOCK PICKING BECOME AN ABSTRACT CONCEPT. REMEMBER: BUYING A SHARE OF A COMPANY\'S STOCK MAKES YOU A PART OWNER OF THAT BUSINESS.',
                        Colors.black),
                    buildCard(
                        '3',
                        'ALL INVESTORS ARE SOMETIMES TEMPTED TO CHANGE THEIR RELATIONSHIP STATUSES WITH THEIR STOCKS. BUT MAKING HEAT-OF-THE-MOMENT DECISIONS CAN LEAD TO THE CLASSIC INVESTING GAFFE: BUYING HIGH AND SELLING LOW.',
                        Colors.grey[900]),
                    buildCard(
                        '4',
                        'Time, not timing, is an investor’s superpower. The most successful investors buy stocks because they expect to be rewarded — via share price appreciation, dividends, etc. — over years or even decades. That means you can take your time in buying, too.',
                        Colors.blue[900]),
                    buildCard(
                        '5',
                        'Checking in on your stocks once per quarter — such as when you receive quarterly reports — is plenty. But it’s hard not to keep a constant eye on the scoreboard. This can lead to overreacting to short-term events, focusing on share price instead of company value, and feeling like you need to do something when no action is warranted.',
                        Colors.teal[400]),
                  ],
                )),
          ],
        ),
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
    );
  }
}

Widget buildCard(String text, String tipNum, Color color) {
  return Container(
    width: 200,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: color,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue'),
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                tipNum,
                style: TextStyle(
                    fontSize: 27.0,
                    color: Colors.white,
                    fontFamily: 'Bebas Neue'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
