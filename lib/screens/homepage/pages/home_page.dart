import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    aboutNotification();
  }

  Future<Null> aboutNotification() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp();
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      await FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("");
        normalDialog2(context, "Message", "Report form system.");
      });
      await FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) {
        print("m3");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeBody(0);
        }));
      });
    }
  }

  Future<void> normalDialog2(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          title: Text(
            title,
            style: GoogleFonts.gayathri(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
          subtitle: Text(
            message,
            style: GoogleFonts.gayathri(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: GoogleFonts.gayathri(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 30),
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME',
                  style: GoogleFonts.calistoga(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'To',
                  style: GoogleFonts.calistoga(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'CarBeacon APPLICATION',
                  style: GoogleFonts.calistoga(
                    fontSize: 20,
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
                Text(""),
                Image.asset('assets/images/Picture1.png'),
                Text(""),
                Text('\t\t\t แอพพลิเคชันตรวจสอบความปลอดภัยของยานพาหนะด้วย\nอุปกรณ์บีคอน โดยแอพพลิเคชันจะสามารถแสดงข้อมูลป้ายทะเบียนของยานพาหนะ ลักษณะภายนอกของยานพาหนะ สถานที่ที่มีการยืนยันว่าจอดล่าสุด และเวลาที่ทำการจอดล่าสุดของยานพาหนะ\nเป้าหมาย โดยแอพพลิเคชันตรวจสอบความปลอดภัยของยานพาหนะด้วยอุปกรณ์บีคอนจะสามารถบอกข้อมูลได้อย่ารวดเร็วเนื่องจากมีการติดตั้งอุปกรณ์เสริมที่ยานพาหนะ โดยยานพาหนะต้องลงทะเบียนอย่างถูกกฏหมายไว้แล้ว ซึ่งอาจจะทำให้การใช้เวลาในการตรวจสอบลดลง การโจรกรรมยานพาหนะลดลง และลดความเสี่ยงในการนำยานพาหนะที่ไม่ถูกต้องไปก่อเหตุต่าง ๆ ได้')
                ,
                Text('''\t\t\tประโยชน์ที่คาดว่าจะได้รับ
    \t\t\t1 ได้ความรู้จากการศึกษาและเรียนรู้เกี่ยวกับเทคโนโลยีบีคอน และการประยุกต์ใช้ร่วมกับฐานข้อมูลและแอพพลิเคชัน
    \t\t\t2 ลดการก่อเหตุจากยานพานะที่ถูกโจรกรรมหรือยานพาหนะที่ไม่ได้ขึ้นทะเบียน
    \t\t\t3 สามาถรลดเวลาในการตรวจสอบข้อมูลของยานพาหนะ และข้อมูลทะเบียน
    \t\t\t4 ลดขั้นตอนในการรตรวจสอบยานพาหนะ และเพิ่มความสะดวกในการตรวจสอบ ยานพาหนะ'''),
                Text(""),
                Text(""),
                Text(""),
                Text(""),
                SizedBox(
                  width: 30,
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
