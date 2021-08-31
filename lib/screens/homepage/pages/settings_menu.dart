import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/screens/homepage/settings/abount_appp.dart';
import 'package:flutter_beacon_car/screens/homepage/settings/language_change.dart';
import 'package:flutter_beacon_car/screens/homepage/settings/profile_nedit.dart';
import 'package:flutter_beacon_car/screens/homepage/settings/sign_out.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_beacon_car/screens/homepage/settings/password_change.dart';

class onSettingsPage extends StatefulWidget {
  const onSettingsPage({Key key}) : super(key: key);

  @override
  _onSettingsPageState createState() => _onSettingsPageState();
}

class _onSettingsPageState extends State<onSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(0),
      appBar: AppBar(
        title: Text(
          'Setting',
          style: GoogleFonts.calistoga(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent[100],
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(70, 20))),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            leading: Icon(
              Icons.account_circle_rounded,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'Profile',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.normal, fontSize: 17),
            ),
            //subtitle: Text('Name:_____ \nOwn Car: __'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => editProfile()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            leading: Icon(
              Icons.vpn_key_rounded,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'Change Password',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.normal, fontSize: 17),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => passChange()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            leading: Icon(
              Icons.language_outlined,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'Language',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.normal, fontSize: 17),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => languageChange()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            leading: Icon(
              Icons.app_settings_alt_rounded,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'About',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.normal, fontSize: 17),
            ),
            subtitle: Text(
              'Version: Test.beta',
              style: GoogleFonts.gayathri(
                  fontWeight: FontWeight.normal, fontSize: 12),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AboutApp()));
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            leading: Icon(
              Icons.logout_rounded,
              size: 50,
              color: Colors.black,
            ),
            title: Text(
              'Sign Out',
              style: GoogleFonts.calistoga(
                  fontWeight: FontWeight.normal, fontSize: 17),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => signOut()));
            },
          )
        ],
      ),
    );
  }
}
