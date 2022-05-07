import 'package:flutter/foundation.dart';

class ServiceProvModel {
  String name;
  String phone_number;
  String account_holder_name;
  String ifs_code;
  String account_number;

  ServiceProvModel({
    @required this.name,
    @required this.phone_number,
    @required this.account_holder_name,
    @required this.ifs_code,
    @required this.account_number,
  });
}