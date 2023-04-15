import 'dart:io';
import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/screens/pages/addImageFarm.dart';
import 'package:AgriNet/screens/pages/addImageService.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
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
  LocationDetails(
      {Key key, this.locality, this.distric, this.state, this.pincode})
      : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    locality.text = widget.locality;
    distric.text = widget.distric;
    state.text = widget.state;
    pincode.text = widget.pincode;
  }

  snackBarMsg(BuildContext context, String msg) {
    var sb = SnackBar(
      elevation: kRadius,
      content: Text(msg),
      backgroundColor: kAccentColor,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        textColor: kWhiteColor,
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  bool textBoxShow = false;
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController locality = TextEditingController();
  TextEditingController distric = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController pincode = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: DefaultAppBar(title: "Location Details"),
      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: TextButton(
              child: Text("Update", style: TextStyle(fontSize: 18.0)),
              style: TextButton.styleFrom(
                  primary: kWhiteColor,
                  elevation: 2,
                  backgroundColor: kPrimaryColor),
              onPressed: () async {
                if (_globalkey.currentState.validate()) {
                  updatelocation('labor', user.uid, locality.text, distric.text,
                          state.text, pincode.text)
                      .then((value) => snackBarMsg(context, "Success"));
                }
              }),
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
            nameTextField(locality, "Locality"),
            SizedBox(
              height: 20,
            ),
            nameTextField(distric, "Distric"),
            SizedBox(
              height: 20,
            ),
            nameTextField(state, "State"),
            SizedBox(
              height: 20,
            ),
            numberTextField(pincode, "Pincode"),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget nameTextField(TextEditingController name, String labelText) {
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

  Widget numberTextField(TextEditingController phone_no, String labelText) {
    return TextFormField(
      controller: phone_no,
      keyboardType: TextInputType.number,
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
