import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_beacon_car/model/modeldetal.dart';
import 'dart:convert';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NoteDetail extends StatefulWidget {
  String str;
  NoteDetail(this.str);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.str);
  }
}

class NoteDetailState extends State<NoteDetail> {
  double lat, lng, lat1, lng1;
  var Token, License_plat, beaconG;
  CameraPosition position;
  List<Modeldetal> _dataApidetal = [];
  @override
  void initState() {
    super.initState();
    _Location();
    GetApiDetel(str);
  }

  void routeToService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    @override
    void dispose() {
      Navigator.pushAndRemoveUntil(context, route, (route) => false);
      super.dispose();
    }

    setState(() {});
  }

  String str;
  NoteDetailState(this.str);
  void _Location() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("${position.latitude} ${position.longitude}");
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container showMap() {
    if (lat != null) {
      LatLng latLng1 = LatLng(lat, lng1);
      position = CameraPosition(
        target: latLng1,
        zoom: 5.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('user'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow:
            InfoWindow(title: 'คุณอยู่ที่นี่', snippet: "${lat} , ${lng}"),
      );
    }

    Marker checkinMarker() {
      return Marker(
        markerId: MarkerId('car'),
        position: LatLng(lat1, lng1),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
        infoWindow: InfoWindow(title: "ที่จอด", snippet: "${lat} , ${lng}"),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), checkinMarker()].toSet();
    }

    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
      // color: Colors.grey,
      height: 250,
      child: lat == null
          ? showProgress()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mySet(),
            ),
    );
  }

  GetApiDetel(String beacon) async {
    print(" bbb ${beacon}");
    Uri apiUrl = Uri.parse(API.urldatal);
    final res = await http.post(apiUrl, body: {"beacon_id": beacon});
    var responseList = json.decode(res.body);
    for (var data in responseList) {
      print("ttt ${data}");

      _dataApidetal.add(new Modeldetal(
          data['Beacon_id'],
          data['Personal_id'],
          data['License_plat'],
          data['License_exp'],
          data['Brand'],
          data['Models'],
          data['Color'],
          data['latitude_checkin'],
          data['longitude_checkin'],
          data['Token']));
      setState(() {
        print(data['Token']);
        lat1 = double.parse(data['latitude_checkin']);
        lng1 = double.parse(data['longitude_checkin']);
        Token = data['Token'];
        License_plat = data['License_plat'];
        beaconG = data['Beacon_id'];
      });
    }
    setState(() {
      print(_dataApidetal.length);
    });
  }

  postApinotifcation(String beacon, String token, String License_plat,
      String latitude, String longitude) async {
    Uri apiUrl = Uri.parse(API.urlapinotifcation);
    final res = await http.post(apiUrl, body: {
      "isAdd": "true",
      "token": token,
      "title": "มีรายงานของเลขทะเบียน ${License_plat}",
      "body": "คลิกเพื่อดูรายละเอียด",
      "Beacon_id": beacon,
      "latitude": latitude,
      "longitude": longitude
    });
    Uri apiurlportnotifcation = Uri.parse(API.urlportnotifcation);
    final res1 = await http.post(apiurlportnotifcation, body: {
      "isAdd": "true",
      "Beacon_id": beacon,
      "latitude": latitude,
      "longitude": longitude,
      "status": "report"
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 5,
          backgroundColor: Colors.blueAccent[100],
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.elliptical(70, 20))),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            "$License_plat",
            style: GoogleFonts.k2d(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: _dataApidetal == null ? 0 : _dataApidetal.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15)), //<--custom shape
                      color: Colors.white,
                      // elevation: 2.0,
                      child: Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${_dataApidetal[index].brand}',
                                          style: GoogleFonts.forum(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${_dataApidetal[index].licensePlat}',
                                          style: GoogleFonts.k2d(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Model: ${_dataApidetal[index].models}  Color: ${_dataApidetal[index].color}',
                                          style: GoogleFonts.forum(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 5,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LOCATION',
                                      style: GoogleFonts.forum(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    lat == null ? showProgress() : showMap(),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 5,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              print("ss");
                                              ShowAlertDialog(5);
                                            },
                                            child: Text(
                                              "Report !!!",
                                              style: GoogleFonts.forum(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.redAccent,
                                            )),
                                      )
                                    ]),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ));
  }

  Future<Null> ShowAlertDialog(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Do you want to report?",
                style: GoogleFonts.gayathri(),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.warning_amber_rounded,
                  size: 80,
                  color: Colors.red,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Colors.greenAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            textStyle: GoogleFonts.calistoga(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            backgroundColor: Colors.lightBlueAccent[100],
                            message: "Report Done",
                          ),
                        );

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeBody(1);
                        }));
                        postApinotifcation(beaconG, Token, License_plat,
                            lat.toString(), lng.toString());
                      },
                      child: Text(
                        'Submit',
                        style: GoogleFonts.calistoga(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Colors.redAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.calistoga(color: Colors.black),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
