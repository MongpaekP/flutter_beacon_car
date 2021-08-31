// To parse this JSON data, do
//
//     final portprofile = portprofileFromJson(jsonString);

import 'dart:convert';


String portprofileToJson(Portprofile data) =>  json.encode(data.toJson());

class Portprofile {
  Portprofile(
    this.persanalId,
    this.nameSurname,
    this.age,
    this.birthday,
    this.phonenumber,
    this.eMail,
    this.address,
  );

  String persanalId;
  String nameSurname;
  String age;
  String birthday;
  String phonenumber;
  String eMail;
  String address;



  Map<String, dynamic> toJson() => {
    "Persanal_id": persanalId,
    "Name_Surname": nameSurname,
    "Age": age,
    "Birthday": birthday,
    "Phonenumber": phonenumber,
    "e_mail": eMail,
    "Address": address,
  };
}
