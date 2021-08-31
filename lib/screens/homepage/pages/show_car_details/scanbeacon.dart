import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_beacon_car/screens/homepage/pages/show_car_details/widgets.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:google_fonts/google_fonts.dart';

class Scanbeacon extends StatefulWidget {
  Scanbeacon({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ScanbeaconState createState() => new _ScanbeaconState();
}

class _ScanbeaconState extends State<Scanbeacon> {
  FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  var Persanal_id;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<int, Beacon> beacons = new Map();
  bool isScanning = false;
  var ck;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    super.dispose();
  }

  _clearAllBeacons() {
    setState(() {
      beacons = Map<int, Beacon>();
    });
  }

  _startScan() {
    print("Scanning now");
    _scanSubscription = flutterBlueBeacon
        .scan(timeout: const Duration(seconds: 1))
        .listen((beacon) {
      print('localName: ${beacon.scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${beacon.scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${beacon.scanResult.advertisementData.serviceData}');
      setState(() {
        beacons[beacon.hash] = beacon;
      });
    }, onDone: _stopScan);

    setState(() {
      isScanning = true;
    });
  }

  _stopScan() {
    print("Scan stopped");
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  Widget _buildScanningButton() {
    if (state != BluetoothState.on) {
      return null;
    }
    if (isScanning) {
      return new IconButton(
        icon: new Icon(
          Icons.stop,
          color: Colors.redAccent,
          size: 30,
        ),
        onPressed: _stopScan,
      );
    } else {
      return new IconButton(
          icon: new Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
          onPressed: _startScan);
    }
  }

  _buildScanResultTiles() {
    return beacons.values.map<Widget>((b) {
      if (b is EddystoneUID) {
        if (b.namespaceId == "9bf8a454a56f646fd249") {
          return EddystoneUIDCard(
            eddystoneUID: b,
          );
        }
      }
      return Card();
    }).toList();
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'กรุณาเปิด Bluetooth ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }

    tiles.addAll(_buildScanResultTiles());

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white.withAlpha(0),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.elliptical(70, 20))),
        backgroundColor: Colors.blueAccent[100],
        automaticallyImplyLeading: false,
        title: Text(
          'Car In Area',
          style: GoogleFonts.calistoga(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: _buildScanningButton()),
        ],
      ),
      // floatingActionButton: _buildScanningButton(),
      body:new Stack(
        children: <Widget>[
          (isScanning) ? _buildProgressBarTile() :new Container(),
          new ListView(
            children: tiles,
          )
        ],
      ),
    );
  }
}
