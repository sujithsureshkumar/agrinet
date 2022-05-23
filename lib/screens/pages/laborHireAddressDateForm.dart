import 'dart:io';
import 'package:AgriNet/models/labor.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/screens/pages/addImageFarm.dart';
import 'package:AgriNet/screens/pages/addImageService.dart';
import 'package:AgriNet/screens/pages/success.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/date_range_picker_widget.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:AgriNet/services/addservice.dart';

class LaborHireAddressDateForm extends StatefulWidget {
  final Labor labor;
  LaborHireAddressDateForm({this.labor,Key key}) : super(key: key);

  @override
  _LaborHireAddressDateFormState createState() => _LaborHireAddressDateFormState();
}
class _LaborHireAddressDateFormState extends State<LaborHireAddressDateForm> {

  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _locality= TextEditingController();
  TextEditingController _district= TextEditingController();
  TextEditingController _state= TextEditingController();
  TextEditingController _pincode= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider >(context, listen: false);
    return Scaffold(
      appBar: DefaultAppBar(title: "More Details"),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(_locality,"locality"),
            SizedBox(
              height: 20,
            ),
            nameTextField(_district,"district"),
            SizedBox(
              height: 20,
            ),
            nameTextField(_state,"state"),
            SizedBox(
              height: 20,
            ),
            pincodeTextField(),
            SizedBox(
              height: 20,
            ),
            DateRangePickerWidget(),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (_globalkey.currentState.validate()&& servicesProvider.startTimeStamp!=null
                    && servicesProvider.endTimeStamp!=null) {
                  await addLaborHiring(widget.labor, user,
                      "hiringType","hirerName",_locality.text,
                      _district.text,_state.text,_pincode.text,"hirerPhone_number"
                      ,servicesProvider.startTimeStamp,servicesProvider.endTimeStamp)
                      .then((value) =>  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Success(),
                    ),
                  ));
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




  Widget nameTextField(TextEditingController name,String label) {
    return TextFormField(
      controller: name,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

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
        labelText: label,
        //helperText: "Name can't be empty",
      ),
    );
  }






  Widget pincodeTextField() {
    return TextFormField(
      controller: _pincode,
      keyboardType:TextInputType.number,
      validator: (value) {
        if (value.isEmpty) return "Enter acres of land";

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
        labelText: "Pincode",
        helperText: "Enter in digits",

      ),
    );
  }



}
