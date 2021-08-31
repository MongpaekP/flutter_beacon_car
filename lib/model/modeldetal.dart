import 'dart:convert';


String ModeldetalToJson(Modeldetal data) => json.encode(data.toJson());

class Modeldetal {
  Modeldetal(
      this.beaconId,
      this.personalId,
      this.licensePlat,
      this.licenseExp,
      this.brand,
      this.models,
      this.color,
      this.latitude_checkin,
      this.longitude_checkin,
      this.token,
  );

  String beaconId;
  String personalId;
  String licensePlat;
  String licenseExp;
  String brand;
  String models;
  String color;
  String latitude_checkin;
  String longitude_checkin;
  String token;

  Map<String, dynamic> toJson() => {
    "Beacon_id": beaconId,
    "Personal_id": personalId,
    "License_plat": licensePlat,
    "License_exp": licenseExp,
    "Brand": brand,
    "Models": models,
    "Color": color,
    "latitude_checkin": latitude_checkin,
    "longitude_checkin": longitude_checkin,
    "Token": token,
  };
}