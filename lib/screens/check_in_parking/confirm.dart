import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:flutter_beacon_car/model/modeldetal.dart';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Result extends StatefulWidget {
  var Resultbarcode;
  Result(this.Resultbarcode);
  @override
  State<StatefulWidget> createState() {
    return _ResultState(this.Resultbarcode);
  }
}

class _ResultState extends State<Result> {
  var resultbarcode;
  _ResultState(this.resultbarcode);
  double lat, lng;

  List<Modeldetal> _dataApidetal = [];
  @override
  void initState() {
    super.initState();
    _Location();
    GetApiDetel(resultbarcode);
  }

  GetApiDetel(String beacon) async {
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
          data['latitude'],
          data['longitude'],
          data['Token']));
    }
    setState(() {});
  }

  void _Location() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("${position.latitude} ${position.longitude}");
    setState(() {
      lat = position.latitude;
      lng = position.longitude;
    });
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('my'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
          title: 'จุดของคุณ',
          snippet: 'ละติจูด = $lat, ลองติจูต = $lng',
        ),
      )
    ].toSet();
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container showMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(
      height: 300.0,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Confirm Check In',
            style: GoogleFonts.calistoga(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.blueAccent[100],
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.elliptical(70, 20))),
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
                                  title: Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.lightBlueAccent,
                                      child: Icon(
                                        Icons.directions_car_outlined,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_dataApidetal[index].brand}",
                                          style: GoogleFonts.forum(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "${_dataApidetal[index].licensePlat}",
                                          style: GoogleFonts.k2d(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Model: ${_dataApidetal[index].models}  Color: ${_dataApidetal[index].color}',
                                          style: GoogleFonts.forum(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 5,
                                ),
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      lat == null ? showProgress() : showMap(),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      lat == null
                                          ? Text("loading...")
                                          : Text("")
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  thickness: 5,
                                ),
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            ShowAlertDialog();
                                          },
                                          child: Text(
                                            "Confirm",
                                            style: GoogleFonts.calistoga(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.greenAccent[100],
                                          ))
                                    ],
                                  ),
                                ),
                              ]))
                            ],
                          ))
                    ],
                  );
                })));
  }

  Future<Null> ShowAlertDialog() async {
    print("ss");
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Are you sure",
                style: GoogleFonts.gayathri(fontWeight: FontWeight.bold),
              ),
              Text(
                'to check in this location?',
                style: GoogleFonts.gayathri(fontWeight: FontWeight.bold),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 180,
                  height: 130,
                  child: Icon(
                    Icons.edit_location_outlined,
                    size: 80,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 110,
                    child: RaisedButton(
                      color: Colors.lightGreenAccent[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.success(
                            backgroundColor: Colors.lightBlueAccent[100],
                            textStyle: GoogleFonts.calistoga(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            message: "Check In Done",
                          ),
                        );

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HomeBody(0);
                        }));
                        postApinotifcation(
                            resultbarcode, lat.toString(), lng.toString());
                      },
                      child: Text(
                        'Confirm',
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

  postApinotifcation(String beacon, String latitude, String longitude) async {
    Uri apiurlportnotifcation = Uri.parse(API.urlportnotifcation);
    final res = await http.post(apiurlportnotifcation, body: {
      "isAdd": "true",
      "Beacon_id": beacon,
      "latitude": latitude,
      "longitude": longitude,
      "status": "checkin"
    });
    Uri apiurleditlocation = Uri.parse(API.urleditlocation);
    final res1 = await http.post(apiurleditlocation, body: {
      "isAdd": "true",
      "Beacon_id": beacon,
      "latitude_checkin": latitude,
      "longitude_checkin": longitude
    });

    setState(() {});
  }
}
