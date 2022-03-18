import 'package:flutter/foundation.dart';

class Service {
  String name;
  String owner;
  String imageUrl;
  int price;

  Service({
    @required this.name,
    @required this.owner,
    @required this.imageUrl,
    @required this.price,
  });
}