import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:AgriNet/services/addservice.dart';

class addFarm extends StatefulWidget {
  addFarm({Key key}) : super(key: key);

  @override
  _addFarmState createState() => _addFarmState();
}
class _addFarmState extends State<addFarm> {
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _subcategory= TextEditingController();
  TextEditingController _landarea= TextEditingController();
  TextEditingController _location= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Farm'),
        backgroundColor:Colors.green,
      ),
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
                // if (_globalkey.currentState.validate()) {
                //   sp_addservice(_servicename.text, _category.text,
                //       _price.text, _no_of_service.text, _description.text).then((value) => {
                //     Navigator.pop(context)
                //   });
                // }
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

