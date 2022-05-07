import 'package:flutter/foundation.dart';

class Service {
  String name;
  String owner;
  List<String> imageUrl;
  String price;
  bool isLiked;
  int likeCount;
  String docid;
  String description;
  String serv_prov_id;
  String spName;
  String phone_number;
  String account_holder_name;
  String ifs_code;
  String account_number;

  Service({
    @required this.name,
    @required this.owner,
    @required this.imageUrl,
    @required this.price,
    @required this.isLiked,
    @required this.likeCount,
    @required this.docid,
    @required this.description,
    @required this.serv_prov_id,
    @required this.spName,
    @required this.phone_number,
    @required this.account_holder_name,
    @required this.ifs_code,
    @required this.account_number,
  });

}