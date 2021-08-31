import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_beacon_car/screens/login/login_screen.dart';

class splashScreen extends StatefulWidget {
  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  int sc = 2;
  Future<Null> checkPreferance() async {
    print("ss");
    await Firebase.initializeApp();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    String token = await firebaseMessaging.getToken();
    print('token ====>>> $token');

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Persanal_id = preferences.getString('Persanal_id');
    String password = preferences.getString('password');
    print('idLogin = $Persanal_id');
    print('password = $password');

    if (Persanal_id != null && Persanal_id.isNotEmpty && Persanal_id!="") {
      Uri apiurladdToken = Uri.parse(API.urladdToken);
      final res = await http.post(apiurladdToken,
          body: {"isAdd": "true", "Persanal_id": Persanal_id, "Token": token});

      setState(() {
        sc = 1;
      });
    } else {
      setState(() {
        sc = 2;
      });
    }
    print(sc);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedSplashScreen(
        centered: true,
        nextScreen: sc ==  1 ? HomeBody(0) : LoginScreen(),
        splash: Container(
          width: 250,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/BG1.png'),
              fit: BoxFit.fill,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        splashIconSize: 250,
        duration: 2000,
        splashTransition: SplashTransition.slideTransition,
        backgroundColor: Colors.lightBlue.shade100,
      ),
    );
  }
}
