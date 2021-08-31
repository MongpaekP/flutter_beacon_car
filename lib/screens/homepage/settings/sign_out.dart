import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/screens/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signOut extends StatefulWidget {
  const signOut({Key key}) : super(key: key);

  @override
  _signOutState createState() => _signOutState();
}

class _signOutState extends State<signOut> {


  out()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Persanal_id', "");
    preferences.setString('password', "");

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    out();
  }
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
