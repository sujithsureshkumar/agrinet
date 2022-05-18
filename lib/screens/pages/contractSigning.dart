import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/headerLabel.dart';
import 'package:flutter/material.dart';

class ContractSigning extends StatefulWidget {

  ContractSigning({Key key,}) : super(key: key);

  @override
  _ContractSigningState createState() => _ContractSigningState();
}

class _ContractSigningState extends State<ContractSigning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        appBar: DefaultAppBar(
        title: "Contract",
        child: DefaultBackButton(),
    ),

      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child: Row(
          children: [
            SizedBox(
                width:5
            ),

            Expanded(
              child: TextButton(
                //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                //color: kPrimaryColor,
                //textColor: kWhiteColor,
                child: Text("Pay", style: TextStyle(fontSize: 18.0)),
                style: TextButton.styleFrom(
                  primary: kWhiteColor,
                  elevation: 2,
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
                width:5
            ),
          ],
        ),
      ),
    body:Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
      children: [
      HeaderLabel(
      headerText: "Please Sign the contract",
      ),

      SizedBox(
      height: kDefaultPadding,
      ),

        Text("Serive Name: name",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Serive Provider Name: name",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Category: name",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),

        Text("SubCategory: name",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),
        Text("Date Range",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
        ),

        Text("Amount",
          style: TextStyle (
              color: kLightColor,
              fontSize: 18
          ),
        ),

      ]
      ),
    ),
    );
  }
}