import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultButton.dart';
import 'package:AgriNet/widget/emptySection.dart';
import 'package:AgriNet/widget/subTitle.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  final Function onPressed;
  final String emptyMsg;
  final String subTitleText;
  Success({Key key,this.onPressed,this.emptyMsg,this.subTitleText}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmptySection(
            emptyImg: "https://c.tenor.com/0AVbKGY_MxMAAAAM/check-mark-verified.gif",
            //emptyMsg: 'Successful !!',
              emptyMsg:widget.emptyMsg,
          ),
          SubTitle(
            //subTitleText: 'Your Request was Sent successfully',
              subTitleText:widget.subTitleText,
          ),
          DefaultButton(
            btnText: 'Ok',
            onPressed: widget.onPressed,
           /* onPressed: () => Navigator.of(context)
              ..pop()
              ..pop()
              ..pop(),*/
            ratio:0.5,
            color:kPrimaryColor,
            textColor: kWhiteColor,
          ),
        ],
      ),
    );
  }
}