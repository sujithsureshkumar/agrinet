import 'package:flutter/material.dart';
import 'package:AgriNet/models/product.dart';
import 'package:AgriNet/models/categoryicon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider with ChangeNotifier {
  List<Product> shirt = [];
  Product shirtData;
  List<Product> dress = [];
  Product dressData;
  List<Product> shoes = [];
  Product shoesData;
  List<Product> pant = [];
  Product pantData;
  List<Product> tie = [];
  Product tieData;
  List<CategoryIcon> dressIcon = [];
  CategoryIcon dressiconData;

  Future<void> getDressIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot dressSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("categoryicon1")
        .collection("dress")
        .get();
    dressSnapShot.docs.forEach(
          (element) {
        dressiconData = CategoryIcon(image: element.get("image"));

        newList.add(dressiconData);
      },
    );
    dressIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getDressIcon {
    return dressIcon;
  }


  Future<void> getDressData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("4QOHr6F0gZRhWe6xcF3N")
        .collection("dress")
        .get();
    shirtSnapShot.docs.forEach(
          (element) {
        shirtData = Product(
            image: element.get("image"),
            name: element.get("name"),
            price: element.get("price"));
        newList.add(shirtData);
        print(shirtData.name);
      },
    );
    dress = newList;
    print(dress[0].image);
    notifyListeners();
  }


  List<Product> get getDressList {
    return dress;
  }


}