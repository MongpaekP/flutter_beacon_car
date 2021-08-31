import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:flutter_beacon_car/screens/homepage/home_body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_beacon_car/screens/check_in_parking/confirm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Checkin extends StatefulWidget {
  @override
  _CheckinState createState() => _CheckinState();
}

class _CheckinState extends State<Checkin> {
  @override
  int x = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[100],
        elevation: 5,
        title: Text(
          'Parking Check In',
          style: GoogleFonts.calistoga(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black),
        ),
      ),
      body: Center(
        child: QRViewExample(),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 12,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    var scannedDataStream;
    scannedDataStream = controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        //  controller.pauseCamera();
        scannedDataStream.cancel();
        no(result.code);

        print(result.code);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void no(String beacon) async {
    checkqrcode(beacon);
  }

  void checkqrcode(String beacon) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var Persanal_id = preferences.getString('Persanal_id');
    print("ss1" + Persanal_id);
    Uri apiUrl = Uri.parse(API.urlportcheckqrcode);
    final res = await http
        .post(apiUrl, body: {"Personal_id": Persanal_id, "Beacon_id": beacon});
    final data = jsonDecode(res.body);
    if (data['error'] == "false") {
      print(data['error']);
      setState(() {
        showTopSnackBar(
          this.context,
          CustomSnackBar.error(
            message: "INCORRECT QR CODE",
          ),
        );
      });
      Navigator.pushReplacement(this.context,
          MaterialPageRoute(builder: (context) {
        return HomeBody(0);
      }));
    } else if (data['error'] == "true") {
      await Navigator.pushReplacement(this.context,
          MaterialPageRoute(builder: (context) {
        return Result(beacon);
      }));
    }
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
