import 'package:FYPII/screens/market_summary.dart';
import 'package:flutter/material.dart';
import 'screens/get_started.dart';
import 'screens/login.dart';
import 'screens/registration.dart';
import 'screens/forgot_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/disclaimer_screen.dart';
import 'screens/dashboard.dart';
import 'screens/prediction_screen.dart';
import 'screens/investment_tips.dart';
import 'screens/data-portal.dart';
import 'screens/contact-us.dart';
import 'screens/update-profile.dart';
import 'screens/market_news.dart';
import 'screens/mboFB.dart';
import 'screens/sharjeelFB.dart';
import 'screens/psx-announcements.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await firebase_core.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GetStarted(),
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/forgotPassword': (context) => ForgotPassword(),
        '/home': (context) => DisclaimerScreen(),
        '/dashboard': (context) => Dashboard(),
        '/prediction': (context) => PredictionScreen(),
        '/marketSummary': (context) => MarketSummary(),
        '/investmentTips': (context) => InvestmentTips(),
        '/updateProfile': (context) => UpdateProfile(),
        '/contactUs': (context) => ContactUs(),
        '/dataPortal': (context) => DataPortal(),
        '/marketNews': (context) => MarketNews(),
        '/mboFB': (context) => MBOFB(),
        '/sharjeelFB': (context) => SharjeelFB(),
        '/announcements': (context) => Announcements(),
      },
    );
  }
}
