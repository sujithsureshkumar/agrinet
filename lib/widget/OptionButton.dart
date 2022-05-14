import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../methods/widget_functions.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;
  final Function onPressed;

  const OptionButton({Key key,
    @required this.text,
    @required this.icon,
    @required this.width,
    @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: FlatButton(
          color: kPrimaryColor,
          splashColor: Colors.white.withAlpha(55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          onPressed:onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: COLOR_WHITE,
              ),
              addHorizontalSpace(10),
              Text(
                text,
                style: TextStyle(color: COLOR_WHITE),
              )
            ],
          )),
    );
  }
}