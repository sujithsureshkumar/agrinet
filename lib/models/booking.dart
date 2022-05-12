import 'package:flutter/foundation.dart';
class Booking {
  String docid;
  String farmType;
  String farmName;
  String price;
  String uid;
  String phone_number;
  String spid;
  String spName;
  String serviceName;
  //String serviceCategory;
  DateTime Startdate;
  DateTime Enddate;
  DateTime createdOn;
  String status;
  DateTime statusOn;

  Booking({
    @required this.docid,
    @required this.farmType,
    @required this.farmName,
    @required this.price,
    @required this.uid,
    @required this.phone_number,
    @required this.spid,
    @required this.serviceName,
    //@required this.serviceCategory,
    @required this.spName,
    @required this.Startdate,
    @required this.Enddate,
    @required this.createdOn,
    @required this.status,
    @required this.statusOn,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    farmType= json['farmType'];
    farmName= json['farmName'];
    uid= json['uid'];
    //phone_number= json['spid'];
    spid= json['spid'];
    spName= json['spName'];
    serviceName= json['serviceName'];
    Startdate= json['startTime'];
    Enddate= json['endTime'];
    createdOn= json['createdOn'];
  }
}