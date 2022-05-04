import 'dart:io';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/screens/pages/addImage.dart';
import 'package:AgriNet/screens/pages/addImage_farm.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:AgriNet/services/addservice.dart';

class AddFarm extends StatefulWidget {
  AddFarm({Key key}) : super(key: key);

  @override
  _AddFarmState createState() => _AddFarmState();
}
class _AddFarmState extends State<AddFarm> {
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _subcategory= TextEditingController();
  TextEditingController _landarea= TextEditingController();
  TextEditingController _location= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return Scaffold(
      appBar: DefaultAppBar(title: "Add Farm"),
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // imageProfile(),
            SizedBox(
              height: 20,
            ),
            nameTextField(),
            SizedBox(
              height: 20,
            ),
            professionTextField(),
            SizedBox(
              height: 20,
            ),
            dobField(),
            SizedBox(
              height: 20,
            ),
            titleTextField(),
            SizedBox(
              height: 20,
            ),
            aboutTextField(),

            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  circular = true;
                });
                 if (_globalkey.currentState.validate()) {
                   FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
                   await farmProvider.farmer_addfarm(user.uid,_name.text, _category.text,
                       _subcategory.text, _landarea.text, _location.text,).then((value) => {
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (ctx) => AddImageFarm(),
                       ),
                     )
                   });
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

  Widget nameTextField() {
    return TextFormField(
      controller: _name,
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
        labelText: "Farm Name",
        helperText: "Name can't be empty",
      ),
    );
  }
  Widget professionTextField() {



    return TextFormField(
      controller: _category,
      validator: (value) {
        if (value.isEmpty) return "category can't be empty";

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
        //   Icons.category,
        //   color: Colors.green,
        // ),
        labelText: "Category",
        helperText: "Category can't be empty",
      ),
    );
  }

  Widget dobField() {
    return TextFormField(
      controller: _subcategory,
      validator: (value) {
        if (value.isEmpty) return "Subcategory can't be empty";

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
        //   Icons.attach_money,
        //   color: Colors.green,
        // ),
        labelText: "Subcategory",

      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _landarea,
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
        labelText: "Landarea",
        helperText: "Enter in digits",

      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _location,
      validator: (value) {
        if (value.isEmpty) return "Enter location";

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
        labelText: " Location",


      ),
    );
  }

}
