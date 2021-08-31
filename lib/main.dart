import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/screens/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo App',
      home: Scaffold(
        body: splashScreen(),
      ),
    );
  }
}
