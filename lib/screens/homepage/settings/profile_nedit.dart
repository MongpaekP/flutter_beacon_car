import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beacon_car/model/Portprofile_OwnsCars.dart';
import 'package:flutter_beacon_car/model/api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_beacon_car/model/Portprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class editProfile extends StatefulWidget {
  const editProfile({Key key}) : super(key: key);

  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  List<Portprofile> _ApiPortprofile=[];
  List<PortprofileOwnsCars> _ApiPortprofileOwnsCars=[];


  ApiPortprofile () async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Persanal_id = preferences.getString('Persanal_id');
    Uri apiUrl = Uri.parse(API.urlPortprofile);

    final res = await http.post(apiUrl, body: {"Persanal_id": Persanal_id});
    var responseList = json.decode(res.body);
    for (var data in responseList) {
      print("Profile ${data}");
      _ApiPortprofile.add(new Portprofile(
          data['Persanal_id'],
          data['Name_Surname'],
          data['Age'],
          data['Birthday'],
          data['Phonenumber'],
          data['e_mail'],
          data['Address'],
         ));
    }
    Uri apiUrl1 = Uri.parse(API.urlPortprofile_OwnsCars);

    final res1 = await http.post(apiUrl1, body: {"Persanal_id": Persanal_id});
    var responseList1 = json.decode(res1.body);
    for (var data in responseList1) {
      print("ApiPortprofileOwnsCars ${data}");
      _ApiPortprofileOwnsCars.add(new PortprofileOwnsCars(
        data['Brand'],
        data['License_plat'],
        data['Models'],
        data['Color'],
        data['License_exp'],
      ));
    }
    setState(() {});
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiPortprofile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        elevation: 5,
        backgroundColor: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.elliptical(70, 20))),
        title: Text(
          'Profile',
          style: GoogleFonts.calistoga(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
            itemCount: _ApiPortprofile==null? 0 : _ApiPortprofile.length ,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return  ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.account_box,
                      size: 100,
                      color: Colors.blueAccent[100],
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '\nName: ',
                          style: GoogleFonts.fenix(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          '${_ApiPortprofile[index].nameSurname}',
                          style: GoogleFonts.k2d(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal ID:',
                              style: GoogleFonts.fenix(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              ' ${_ApiPortprofile[index].persanalId}',
                              style: GoogleFonts.k2d(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact.',
                          style: GoogleFonts.fenix(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.local_phone,
                              size: 40,
                              color: Colors.blueAccent[100],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${_ApiPortprofile[index].phonenumber}',
                              style: GoogleFonts.k2d(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 40,
                              color: Colors.blueAccent[100],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${_ApiPortprofile[index].eMail}',
                              style: GoogleFonts.k2d(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_city_outlined,
                              size: 40,
                              color: Colors.blueAccent[100],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Address',
                              style: GoogleFonts.k2d(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            '${_ApiPortprofile[index].address}',
                            style: GoogleFonts.k2d(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.directions_car_outlined,
                              size: 50,
                              color: Colors.blueAccent[100],
                            ),
                            Text(
                              'Own\'s Cars ',
                              style: GoogleFonts.fenix(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              '${_ApiPortprofileOwnsCars.length==null? "0" : _ApiPortprofileOwnsCars.length} คัน',
                              style: GoogleFonts.k2d(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  carOwnerList(),
                ],
              );
            },


          )),
    );
  }

  Widget carOwnerList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _ApiPortprofileOwnsCars==null?0:_ApiPortprofileOwnsCars.length,
      itemBuilder: (context, index) {
        return   new ListTile(
        tileColor: Colors.greenAccent[100],
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Text(
        'Brand: ${_ApiPortprofileOwnsCars[index].brand}  / ${_ApiPortprofileOwnsCars[index].licensePlat}',
        style: GoogleFonts.fenix(
        fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
        ),
        subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Text(
        'Model: ${_ApiPortprofileOwnsCars[index].models}',
        style: GoogleFonts.fenix(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black),
        ),
        SizedBox(
        width: 10,
        ),
        Text(
        'Color: ${_ApiPortprofileOwnsCars[index].color}',
        style: GoogleFonts.fenix(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: Colors.black),
        ),
        ],
        ),
        Text(
        'License EXP: ${_ApiPortprofileOwnsCars[index].licenseExp}',
        style: GoogleFonts.fenix(
        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
        ),
        SizedBox(
        height: 5,
        )
        ],
        ),
        trailing: Text(
        'คันที่ ${index+1}',
        style: GoogleFonts.fenix(
        fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
        ),
        );
      },

    );
  }
}
