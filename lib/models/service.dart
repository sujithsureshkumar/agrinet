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
  String serv_prov_name;

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
    @required this.serv_prov_name,
  });
}