import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
class passChange extends StatefulWidget {
  const passChange({Key key}) : super(key: key);

  @override
  _passChangeState createState() => _passChangeState();
}

class _passChangeState extends State<passChange> {
  bool _pwHide0 = true;
  bool _pwHide1 = true;
  bool _pwHide2 = true;
  String msgError1="";
  String msgError2="";
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPassController = new TextEditingController();
  TextEditingController confirmPassController = new TextEditingController();
  TextEditingController newPassController = new TextEditingController();
  String isPasswordValid(String password) {
    if (password.length < 8) return "Password should have at least 8 characters";
    if (!password.contains(RegExp(r"[a-z]"))) return "at least 1 lower case letter(s)";
    if (!password.contains(RegExp(r"[A-Z]"))) return "at least 1 upper case letter(s)";
    if (!password.contains(RegExp(r"[0-9]"))) return "at numeric least 1 digit(s)";
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return "nat least 1 non-alphanumeric character(s)";
    return null;
  }
  void getChangPassword(String newPassController, String confirmPassController,String oldPassController) async {
    if(newPassController == confirmPassController){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String Persanal_id = preferences.getString('Persanal_id');
      String password = preferences.getString('password');
      if(oldPassController==password){
        print("1 W");
        Uri apiUrl = Uri.parse(API.Urlchangepassword);
        final res = await http.post(apiUrl, body: {"Persanal_id":Persanal_id,"password": newPassController});

        preferences.setString('password', newPassController);

       Navigator.pop(context);
      var s=  showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "password change success",
          ),
        );
      }else{
        setState(() {
          msgError2 = " oldPassController ไม่ถูกต้อง";
        });

        print("1 L");
      }
    }else{
      setState(() {
        msgError1 = " ไม่เหมือนกัน ";
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Change Password',
            style: GoogleFonts.calistoga(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent[100],
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.elliptical(70, 20))),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              newPassword(),
              SizedBox(
                height: 15,
              ),
              Text("${msgError1}"),
              confirmPassword(),
              SizedBox(
                height: 15,
              ),
              Text('Tip: Password should have at least 8 characters, '
                  '\nat least 1 digit(s), '
                  '\nat least 1 lower case letter(s), '
                  '\nat least 1 upper case letter(s), '
                  '\nat least 1 non-alphanumeric character(s) '),
              SizedBox(
                height: 15,
              ),
              Text("${msgError2}"),
              oldPassword(),
              SizedBox(
                height: 15,
              ),
              confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget newPassword() {
    return TextFormField(
      controller: newPassController,
      obscureText: _pwHide0,
      validator: (value) {
        return isPasswordValid(value);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        labelText: 'New Password',
        labelStyle: GoogleFonts.calistoga(),
        suffixIcon: IconButton(
          icon: Icon(
            _pwHide0
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          color: Colors.black,
          onPressed: () {
            setState(() {
              _pwHide0 = !_pwHide0;
            });
          },
        ),
      ),
      style: GoogleFonts.calistoga(color: Colors.black),
    );
  }

  Widget confirmPassword() {
    return TextFormField(
      controller: confirmPassController,
      obscureText: _pwHide1,
      validator: (value) {
        return isPasswordValid(value);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        labelText: 'Confirm Password',
        labelStyle: GoogleFonts.calistoga(),
        suffixIcon: IconButton(
          icon: Icon(
            _pwHide1
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          color: Colors.black,
          onPressed: () {
            setState(() {
              _pwHide1 = !_pwHide1;
            });
          },
        ),
      ),
      style: GoogleFonts.calistoga(color: Colors.black),
    );
  }

  Widget oldPassword() {
    return TextFormField(
      controller: oldPassController,
      obscureText: _pwHide2,
      validator: (value) {
        return isPasswordValid(value);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 5,
          ),
        ),
        labelText: 'Old Password',
        labelStyle: GoogleFonts.calistoga(),
        suffixIcon: IconButton(
          icon: Icon(
            _pwHide2
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
          ),
          color: Colors.black,
          onPressed: () {
            setState(() {
              _pwHide2 = !_pwHide2;
            });
          },
        ),
      ),
      style: GoogleFonts.calistoga(color: Colors.black),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent[100]),
        onPressed: () {
    setState(() {
    if (_formKey.currentState.validate()) {
    debugPrint('change password');
    getChangPassword(newPassController.text, confirmPassController.text, oldPassController.text);

    }}
        );},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Change Password',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black),
            )
          ],
        ));
  }
}
