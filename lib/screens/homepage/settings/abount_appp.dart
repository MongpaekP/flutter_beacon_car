import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(70, 20))),
        title: Text(
          'About',
          style: GoogleFonts.calistoga(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Version: Test(Beta)',
              style: GoogleFonts.gayathri(
                  fontSize: 18, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
