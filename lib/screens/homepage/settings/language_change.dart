import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class languageChange extends StatefulWidget {
  const languageChange({Key key}) : super(key: key);

  @override
  _languageChangeState createState() => _languageChangeState();
}

class _languageChangeState extends State<languageChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Language',
          style: GoogleFonts.calistoga(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.elliptical(70, 20))),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            '   Test.Beta(English)\n   Maybe on future',
            style: GoogleFonts.gayathri(
                fontSize: 20, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
