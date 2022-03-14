import 'package:flutter/material.dart';
import 'package:AgriNet/models/cartmodel.dart';
import 'package:AgriNet/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> feature = [];
  Product featureData;

  List<CartModel> checkOutModelList = [];
  CartModel checkOutModel;
  //List<UserModel> userModelList = [];
  //UserModel userModel;


}