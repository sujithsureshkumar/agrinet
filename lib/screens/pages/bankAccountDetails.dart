import 'dart:io';
import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/screens/pages/addImageFarm.dart';
import 'package:AgriNet/screens/pages/addImageService.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:AgriNet/services/addservice.dart';

class BankAccountDetails extends StatefulWidget {
  final String account_holder_name;
  final String account_number;
  final String ifsc_code;
  BankAccountDetails({Key key,this.account_holder_name,this.account_number,this.ifsc_code}) : super(key: key);

  @override
  _BankAccountDetailsState createState() => _BankAccountDetailsState();
}
class _BankAccountDetailsState extends State<BankAccountDetails> {

  @override
  void initState () {
    super.initState();
    account_holder_name.text=widget.account_holder_name;
    _account_number.text=widget.account_number;
    _ifsc_code.text=widget.ifsc_code;
  }





  bool textBoxShow=false;
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController account_holder_name = TextEditingController();
  TextEditingController _account_number= TextEditingController();
  TextEditingController _ifsc_code= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: DefaultAppBar(title: "Bank Account Details"),

      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child:Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child:TextButton(
              child: Text("Update", style: TextStyle(fontSize: 18.0)),
              style: TextButton.styleFrom(
                  primary: kWhiteColor,
                  elevation: 2,
                  backgroundColor: kPrimaryColor),
              onPressed: () async {
                if (_globalkey.currentState.validate()) {


                }
              }
          ),
        ),

      ),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[

            SizedBox(
              height: 20,
            ),
            nameTextField(account_holder_name,"Account holder name"),
            SizedBox(
              height: 20,
            ),
            numberTextField(_account_number,"Account number"),
            SizedBox(
              height: 20,
            ),
            nameTextField(_ifsc_code,"ifsc code"),
            SizedBox(
              height: 20,
            ),

          ],
        ),
      ),
    );
  }




  Widget nameTextField(TextEditingController name,String labelText) {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value.isEmpty) return "Field can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.agriculture,
        //   color: Colors.green,
        // ),
        labelText: labelText,
       // helperText: "Name can't be empty",
      ),
    );
  }






  Widget numberTextField(TextEditingController phone_no,String labelText) {
    return TextFormField(
      controller: phone_no,
      keyboardType:TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "Field can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: labelText,
        //helperText: "Enter in digits",

      ),
    );
  }



}
