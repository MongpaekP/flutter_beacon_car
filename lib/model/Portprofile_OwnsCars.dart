// To parse this JSON data, do
//
//     final portprofileOwnsCars = portprofileOwnsCarsFromJson(jsonString);

import 'dart:convert';


String portprofileOwnsCarsToJson(PortprofileOwnsCars data) => json.encode(data.toJson());

class PortprofileOwnsCars {
  PortprofileOwnsCars(
    this.brand,
    this.licensePlat,
    this.models,
    this.color,
    this.licenseExp,
  );

  String brand;
  String licensePlat;
  String models;
  String color;
  String licenseExp;



  Map<String, dynamic> toJson() => {
    "Brand": brand,
    "License_plat": licensePlat,
    "Models": models,
    "Color": color,
    "License_exp": licenseExp,
  };
}
