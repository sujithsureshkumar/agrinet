import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Labor {
  String docid;
  String name;
  String phone_number;
  String skill;
  String locality;
  String district;
  String state;
  String pincode;
  String account_holder_name;
  String account_number;
  String ifs_code;
  String bank_name;
  String imageUrl;
  DateTime createdOn;


  Labor({
    @required this.docid,
    @required this.name,
    @required this.phone_number,
    @required this.skill,
    @required this.locality,
    @required this.district,
    @required this.state,
    @required this.pincode,
    @required this.account_holder_name,
    @required this.account_number,
    @required this.ifs_code,
    @required this.bank_name,
    @required this.imageUrl,
    @required this.createdOn,
  });

}