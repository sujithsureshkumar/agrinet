import 'package:flutter/foundation.dart';
class LaborHiring {
  String docid;
  String hiringType;
  String hirerName;
  String hirerLocality;
  String hirerdistrict;
  String hirerState;
  String hirerPincode;
  String hirerPhone_number;
  String uid;
  String laborPhone_number;
  String laborid;
  String laborName;
  String laborSkill;
  String laborlocality;
  String labordistrict;
  String laborstate;
  String laborpincode;
  DateTime Startdate;
  DateTime Enddate;
  DateTime createdOn;
  String status;
  DateTime statusOn;

  LaborHiring({
    @required this.docid,
    @required this.hiringType,
    @required this.hirerName,
    @required this.hirerLocality,
    @required this.hirerdistrict,
    @required this.hirerState,
    @required this.hirerPincode,
    @required this.hirerPhone_number,
    @required this.uid,
    @required this.laborPhone_number,
    @required this.laborid,
    @required this.laborName,
    @required this.laborSkill,
    @required this.laborlocality,
    @required this.labordistrict,
    @required this.laborstate,
    @required this.laborpincode,
    @required this.Startdate,
    @required this.Enddate,
    @required this.createdOn,
    @required this.status,
    @required this.statusOn,
  });


}