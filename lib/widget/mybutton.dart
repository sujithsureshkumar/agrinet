import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final double ratio;
  MyButton({this.name, this.onPressed,this.ratio});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      //width: double.infinity,
      width: MediaQuery.of(context).size.width*ratio,
      child: RaisedButton(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        color: Color(0xff746bc9),
        onPressed: onPressed,
      ),
    );
  }
}