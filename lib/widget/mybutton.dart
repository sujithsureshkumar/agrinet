import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final double ratio;
  final Color color;
  MyButton({this.name, this.onPressed, this.ratio, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      //width: double.infinity,
      width: MediaQuery.of(context).size.width * ratio,
      child: ElevatedButton(
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
