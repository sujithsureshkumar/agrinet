import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Farm {
  String docid;
  String name;
  String category;
  String subCategory;
  String landarea;
  GeoPoint location;
  bool locationSet;
  List<String> imageUrl;
  DateTime createdOn;
  double lat,long;


  Farm({
    @required this.docid,
    @required this.name,
    @required this.category,
    @required this.subCategory,
    @required this.location,
    @required this.locationSet,
    @required this.landarea,
    @required this.imageUrl,
    @required this.createdOn,
    @required this.lat,
    @required this.long,
  });

}