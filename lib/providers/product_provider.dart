import 'package:flutter/material.dart';
import 'package:AgriNet/models/cartmodel.dart';
import 'package:AgriNet/models/product.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  Product featureData;

  List<CartModel> checkOutModelList = [];
  CartModel checkOutModel;
  //List<UserModel> userModelList = [];
  //UserModel userModel;

  Future<void> getFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot = await FirebaseFirestore.instance
        .collection("products")
        .doc("hfPmMokn0tbAuGZvRMy1")
        .collection("featureproduct")
        .get();
    featureSnapShot.docs.forEach(
          (element) {
        featureData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(featureData);
      },
    );
    feature = newList;
  }

  List<Product> get getFeatureList {
    return feature;
  }

  List<Product> homeFeature = [];

  Future<void> getHomeFeatureData() async {
    List<Product> newList = [];
    QuerySnapshot featureSnapShot =
    await FirebaseFirestore.instance.collection("homefeature").get();
    featureSnapShot.docs.forEach(
          (element) {
        featureData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(featureData);
      },
    );
    homeFeature = newList;
    notifyListeners();
  }

  List<Product> get getHomeFeatureList {
    return homeFeature;
  }

}