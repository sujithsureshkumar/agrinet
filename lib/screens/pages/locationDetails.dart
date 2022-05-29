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

class LocationDetails extends StatefulWidget {
  final String locality;
  final String distric;
  final String state;
  final String pincode;
  LocationDetails({Key key,this.locality,this.distric,this.state,this.pincode}) : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}
class _LocationDetailsState extends State<LocationDetails> {

  @override
  void initState () {
    super.initState();
    locality.text=widget.locality;
    distric.text=widget.distric;
    state.text=widget.state;
    pincode.text=widget.pincode;
  }





  bool textBoxShow=false;
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController locality = TextEditingController();
  TextEditingController distric= TextEditingController();
  TextEditingController state= TextEditingController();
  TextEditingController pincode= TextEditingController();
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
            //onPressed: () =>snackBarMsg(context,  'msg')
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
            nameTextField(locality,"Account holder name"),
            SizedBox(
              height: 20,
            ),
            nameTextField(distric,"Account number"),
            SizedBox(
              height: 20,
            ),
            nameTextField(state,"Account number"),
            SizedBox(
              height: 20,
            ),
            numberTextField(pincode,"ifsc code"),
            SizedBox(
              height: 20,
            ),

            InkWell(
              onTap: () async {
                if (_globalkey.currentState.validate()) {


                }
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? CircularProgressIndicator()
                        : Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
