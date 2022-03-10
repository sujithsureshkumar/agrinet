import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  DetailScreen({this.image, this.name, this.price});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;


  Widget _buildColorProduct({Color color}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {

  }
}