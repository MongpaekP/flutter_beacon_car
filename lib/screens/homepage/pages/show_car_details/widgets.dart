import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/show_car_details/detail_lists.dart';

class IBeaconCard extends StatelessWidget {
  final IBeacon iBeacon;

  IBeaconCard({@required this.iBeacon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text("iBeacon"),
          Text("name :${iBeacon.name}"),
          Text("uuid: ${iBeacon.uuid}"),
          Text("major: ${iBeacon.major}"),
          Text("minor: ${iBeacon.minor}"),
          Text("tx: ${iBeacon.tx}"),
          Text("rssi: ${iBeacon.rssi}"),
          Text("distance: ${iBeacon.distance}"),
        ],
      ),
    );
  }
}

class EddystoneUIDCard extends StatelessWidget {
  final EddystoneUID eddystoneUID;
  EddystoneUIDCard({
    @required this.eddystoneUID,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: 5,),
              Column(
                children: [Icon(Icons.directions_car_outlined,size: 70,color: Colors.indigoAccent[400],),
                Text('${eddystoneUID.beaconId}',style: GoogleFonts.forum(fontSize: 8, color: Colors.grey),)
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  " License Plate ",
                  style: GoogleFonts.forum(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "${eddystoneUID.name}",
                  style: GoogleFonts.k2d(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 8,
                ),
              ]),
              SizedBox(width: 15,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(height: 25,),
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Colors.lightBlue[100]),
                    child: Text(
                      "More Detail",
                      style: GoogleFonts.forum(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return NoteDetail(eddystoneUID.beaconId);
                        }))),
                //SizedBox(height: 40,)],),
            ],
          ),
        ])));
  }
}

class EddystoneEIDCard extends StatelessWidget {
  final EddystoneEID eddystoneEID;
  EddystoneEIDCard({@required this.eddystoneEID});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("EddystoneEID"),
          Text("name :${eddystoneEID.name}"),
          Text("ephemeralId: ${eddystoneEID.ephemeralId}"),
          Text("tx: ${eddystoneEID.tx}"),
          Text("rssi: ${eddystoneEID.rssi}"),
          Text("distance: ${eddystoneEID.distance}"),
        ],
      ),
    );
  }
}
