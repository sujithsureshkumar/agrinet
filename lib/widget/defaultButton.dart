
import 'package:flutter/material.dart';

import '../constants/constant.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  final double ratio;
  final Color color,textColor;
  const DefaultButton({
    Key key, this.btnText, this.onPressed,this.ratio,this.color,this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*ratio,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: kLessPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kShape)),
        color: color,
        textColor:textColor ,
        highlightColor: kTransparent,
        onPressed: onPressed,
        child: Text(btnText.toUpperCase()),
      ),
    );
  }
}