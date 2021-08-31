import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon_car/screens/login/components/background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_beacon_car/model/api.dart';
import 'package:nextflow_thai_personal_id/nextflow_thai_personal_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Background(),
          _loginFrom(),
        ],
      ),
    );
  }
}

class _loginFrom extends StatefulWidget {
  const _loginFrom({Key key}) : super(key: key);

  @override
  __loginFromState createState() => __loginFromState();
}

class __loginFromState extends State<_loginFrom> {
  TextEditingController _Persanal_id = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _pwHide = true;
  bool _rememberUser = false;
  String msgError = "";

  void initState() {
    super.initState();
  }

  //ตรวจบัตรประชาชน
  ThaiIdValidator validator = ThaiIdValidator(
      errorMessage: 'เลขประจำตัวประชาชนไม่ถูกต้อง กรุณาตรวจสอบใหม่');
  final _formKey = GlobalKey<FormState>();
  //login
  void getApiLogin(String Persanal_id, String password) async {
    Uri apiUrl = Uri.parse(API.urlLogin);
    final res = await http
        .post(apiUrl, body: {"Persanal_id": Persanal_id, "password": password});
    final data = jsonDecode(res.body);
    if (data['error'] == "FALSE") {
      print(data['error']);
      setState(() {
        msgError = " Persanal ID and Incorrect password ";
      });
    } else if (data['error'] == "TRUE") {
      await Firebase.initializeApp();
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      String token = await firebaseMessaging.getToken();
      print('token ====>>> $token');
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('Persanal_id', Persanal_id);
      preferences.setString('password', password);
      print(data['error']);
      Uri apiurladdToken = Uri.parse(API.urladdToken);
      final res = await http.post(apiurladdToken,
          body: {"isAdd": "true", "Persanal_id": Persanal_id, "Token": token});
      routeToService(HomeBody(0));
    }
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            backgroundColor: Colors.white.withAlpha(0),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFEDE7F6),
                                  Color(0xFFD1C4E9),
                                  Color(0xFFB39DDB),
                                  Color(0xFF9575CD),
                                ]),
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.symmetric(horizontal: BorderSide.none)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30, top: 20),
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.calistoga(
                                    fontSize: 36, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(msgError,
                                  style: TextStyle(color: Colors.red)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                controller: _Persanal_id,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'ID Card No.',
                                  //hintText: 'ID Card No.',
                                  prefixIcon: Icon(Icons.account_box,
                                      color: Colors.black),
                                ),
                                validator: validator.validate,
                                style:
                                    GoogleFonts.calistoga(color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                  obscureText: _pwHide,
                                  controller: _password,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    labelText: 'Password',
                                    // hintText: 'Password',
                                    prefixIcon: Icon(
                                      Icons.vpn_key,
                                      color: Colors.black,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _pwHide
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                      color: Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          _pwHide = !_pwHide;
                                        });
                                      },
                                    ),
                                  ),
                                  style: GoogleFonts.calistoga(
                                      color: Colors.black),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter your password ';
                                    } else if (value.length < 8) {
                                      return 'Password must be longer than 8 characters. ';
                                    }
                                    return null;
                                  }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(width: 1),
                                        backgroundColor:
                                            Colors.deepPurple.shade50,
                                        shadowColor: Colors.lime[200],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        fixedSize: Size(200, 60)),
                                    onPressed: () {
                                      setState(() {
                                        if (_formKey.currentState.validate()) {
                                          debugPrint('Login');
                                          getApiLogin(_Persanal_id.text,
                                              _password.text);
                                        }
                                      });
                                    },
                                    child: Text(
                                      'Sign In',
                                      style: GoogleFonts.calistoga(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
