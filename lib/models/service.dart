import 'package:flutter/foundation.dart';

class Service {
  String name;
  List<String> imageUrl;
  String price;
  String category;
  String subCategory;
  String equipmentDetail;
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
  List<String> reviewList;
  DateTime createdOn;

  String locality;
  String district;
  String state;
  String pincode;


  Service({
    @required this.name,
    @required this.imageUrl,
    @required this.price,
    @required this.category,
    @required this.subCategory,
    @required this.equipmentDetail,
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
    @required this.reviewList,
    @required this.createdOn,

    @required this.locality,
    @required this.district,
    @required this.state,
    @required this.pincode,
  });

}