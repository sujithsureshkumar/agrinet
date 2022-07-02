import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Farmer {
  String docid;
  String name;
  String phone_no;
  String bankName;
  String accountHolderName;
  String accountNumber;
  String ifsc_code;


  Farmer({
    @required this.docid,
    @required this.name,
    @required this.phone_no,
    @required this.bankName,
    @required this.accountHolderName,
    @required this.accountNumber,
    @required this.ifsc_code,
  });

}