import 'package:flutter/material.dart';
import 'package:AgriNet/models/product.dart';
//import 'package:AgriNet/screens/catalogue/detailscreen.dart';
import 'package:provider/provider.dart';

class ListProduct extends StatelessWidget {
  final String name;
  bool isCategory = true;
  final List<Product> snapShot;
  ListProduct({
    this.name,
    this.isCategory,
    this.snapShot,
  });

  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
   // categoryProvider = Provider.of<CategoryProvider>(context);
   // productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),

        child: ListView(
          children: <Widget>[
            //Text("Hello"),
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            //_buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}