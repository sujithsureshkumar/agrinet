import 'package:flutter/foundation.dart';

class Service {
  String name;
  String owner;
  String imageUrl;
  int price;
  bool isLiked;
  int likeCount;
  String docid;

  Service({
    @required this.name,
    @required this.owner,
    @required this.imageUrl,
    @required this.price,
    @required this.isLiked,
    @required this.likeCount,
    @required this.docid,
  });
}