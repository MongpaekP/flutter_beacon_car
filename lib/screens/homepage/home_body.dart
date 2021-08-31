import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/home_page.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/settings_menu.dart';
import 'package:flutter_beacon_car/screens/homepage/components/background.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/show_car_details/scanbeacon.dart';
import 'package:flutter_beacon_car/screens/check_in_parking/check_in.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/notifications_ms.dart';
import 'package:flutter_beacon_car/screens/homepage/components/bottom_tab_widget.dart';

class HomeBody extends StatefulWidget {
  int index;
  HomeBody(this.index);
  @override
  _HomeBodyState createState() => _HomeBodyState(this.index);
}

class _HomeBodyState extends State<HomeBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int index;
  int _indexItems = 0;
  final List page = [
    HomeScreen(),
    Scanbeacon(),
    screensNotification(),
    onSettingsPage(),
  ];
  _HomeBodyState(this.index);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    _indexItems = index;
    print(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Background(),
          SingleChildScrollView(),
          Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              mini: false,
              shape: CircleBorder(
                  side: BorderSide(color: Colors.blueAccent[100], width: 1)),
              elevation: 5,
              backgroundColor: Colors.lightBlueAccent[100],
              onPressed: () {
                Navigator.push(this.context,
                    MaterialPageRoute(builder: (context) {
                  return Checkin();
                }));
              },
              child: Icon(
                Icons.qr_code_scanner_rounded,
                color: Colors.black,
                size: 43,
              ),
            ),
            backgroundColor: Colors.white.withAlpha(0),
            bottomNavigationBar: BottomTabWidget(
              index: _indexItems,
              onChangedTab: onChangedTab,
            ),
            body: page[_indexItems],
          ),
        ],
      ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this._indexItems = index;
    });
  }
}
