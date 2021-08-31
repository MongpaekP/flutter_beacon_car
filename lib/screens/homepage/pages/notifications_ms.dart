import 'dart:async';
import 'dart:convert';
import 'package:flutter_beacon_car/model/getnotifcation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class screensNotification extends StatefulWidget {
  screensNotification({Key key, this.title}) : super(key: key);
  final String title;
  @override
  screensNotificationState createState() => new screensNotificationState();
}

class screensNotificationState extends State<screensNotification> {
  List<Getnotifcation> _dataApiGetnotifcation = [];
  CameraPosition position;
  GetApinotifcation() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Persanal_id = preferences.getString('Persanal_id');
    print('Persanal_id = $Persanal_id');
    Uri apiUrl = Uri.parse(API.urlgetnotifcation);
    final res = await http.post(apiUrl, body: {"Personal_id": Persanal_id});
    var responseList = json.decode(res.body);
    for (var data in responseList) {
      _dataApiGetnotifcation.add(new Getnotifcation(
          data['Personal_id'],
          data['Beacon_id'],
          data['License_plat'],
          data['Brand'],
          data['Models'],
          data['Color'],
          data['latitude_checkin'],
          data['longitude_checkin'],
          data['id'],
          DateTime.parse(data['date']),
          data['status'],
          data['latitude'],
          data['longitude']));
    }
    setState(() {
    });
  }
  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container showMap(double lat, double lng) {
    if (lat != null) {
      LatLng latLng1 = LatLng(lat, lng);
      position = CameraPosition(
        target: latLng1,
        zoom: 16.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('user'),
        position: LatLng(lat, lng),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow:
            InfoWindow(title: 'จุดแจ้งเตือน', snippet: "${lat} , ${lng}"),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker()].toSet();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      GetApinotifcation();
    });
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.blueAccent[100],
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(70, 20))),
          automaticallyImplyLeading: false,
          centerTitle: true,

          title: Text(
            'Notification',
            style: GoogleFonts.calistoga(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white.withAlpha(0),
        body: ListView.builder(
          itemCount: _dataApiGetnotifcation == null
              ? 0
              : _dataApiGetnotifcation.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20)), //<--custom shape
                  color: Colors.white,
                  // elevation: 2.0,
                  child: directWidgetMessages(index)),
            );
          },
        ));
  }

  Widget directWidgetMessages(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _dataApiGetnotifcation[index].status == "checkin"
            ? Colors.lightBlueAccent
            : Colors.redAccent,
        child: _dataApiGetnotifcation[index].status == "checkin"
            ? Icon(
                Icons.where_to_vote_outlined,
                color: Colors.black,
              )
            : Icon(Icons.announcement_outlined, color: Colors.black),
      ),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _dataApiGetnotifcation[index].status == "checkin"
              ? Text(
                  'Check In',
                  style: GoogleFonts.calistoga(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
              : Text(
                  'Warning',
                  style: GoogleFonts.calistoga(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
          Text(
            'License Plat:${_dataApiGetnotifcation[index].licensePlat}',
            style: GoogleFonts.calistoga(
                fontWeight: FontWeight.normal, fontSize: 18),
          )
        ],
      ),
      subtitle: Text(
        "${_dataApiGetnotifcation[index].date.toString()}",
        style: GoogleFonts.calistoga(fontWeight: FontWeight.normal),
      ),
      trailing: GestureDetector(
          child: SizedBox(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Icon(Icons.location_on_outlined,color: Colors.lightGreen,size: 35,),
                Text('See',style: GoogleFonts.gayathri(fontWeight: FontWeight.bold,fontSize: 8),),
              Text('Location.',style: GoogleFonts.gayathri(fontWeight: FontWeight.bold,fontSize: 8),)],
            )
          ),
          onTap: () {
            ShowAlertDialog(
                double.parse(_dataApiGetnotifcation[index].latitude),
                double.parse(_dataApiGetnotifcation[index].longitude));
          }),
    );
  }

  Future<Null> ShowAlertDialog(double lat, double lng) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => SingleChildScrollView(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            insetPadding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "LOCATION",
                  style: GoogleFonts.calistoga(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 300,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [showMap(lat, lng)],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 110,
                      child: RaisedButton(
                        color: Colors.blueAccent[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.calistoga(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
