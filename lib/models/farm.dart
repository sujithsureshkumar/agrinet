import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
class Farm {
  String docid;
  String name;
  String category;
  String subCategory;
  GeoPoint location;


  Farm({
    @required this.docid,
    @required this.name,
    @required this.category,
    @required this.subCategory,
    @required this.location,
  });

}