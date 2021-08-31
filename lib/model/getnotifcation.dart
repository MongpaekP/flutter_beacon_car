// To parse this JSON data, do
//
//     final getnotifcation = getnotifcationFromJson(jsonString);

import 'dart:convert';

String getnotifcationToJson(Getnotifcation data) => json.encode(data.toJson());

class Getnotifcation {
  Getnotifcation(
    this.personalId,
    this.beaconId,
    this.licensePlat,
    this.brand,
    this.models,
    this.color,
      this.latitudeCheckin,
      this.longitudeCheckin,
      this.id,
    this.date,
    this.status,
    this.latitude,
    this.longitude
  );

  String personalId;
  String beaconId;
  String licensePlat;
  String brand;
  String models;
  String color;
  String latitudeCheckin;
  String longitudeCheckin;
  String id;
  DateTime date;
  String status;
  String latitude;
  String longitude;


  Map<String, dynamic> toJson() => {
    "Personal_id": personalId,
    "Beacon_id": beaconId,
    "License_plat": licensePlat,
    "Brand": brand,
    "Models": models,
    "Color": color,
    "latitude_checkin": latitudeCheckin,
    "longitude_checkin": longitudeCheckin,
    "id": id,
    "date": date.toIso8601String(),
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
  };
}

