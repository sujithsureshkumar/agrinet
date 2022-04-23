import 'dart:io';
import 'package:flutter/material.dart';
import 'package:AgriNet/services/addservice.dart';

class CreatProfile extends StatefulWidget {
  CreatProfile({Key key}) : super(key: key);

  @override
  _CreatProfileState createState() => _CreatProfileState();
}
class _CreatProfileState extends State<CreatProfile> {
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _servicename = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _no_of_service= TextEditingController();
  TextEditingController _description= TextEditingController();
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Service'),
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
                if (_globalkey.currentState.validate()) {
                  sp_addservice(_servicename.text, _category.text,
                          _price.text, _no_of_service.text, _description.text).then((value) => {
                    Navigator.pop(context)
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
      controller: _servicename,
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
        prefixIcon: Icon(
          Icons.agriculture,
          color: Colors.green,
        ),
        labelText: "Service Name",
        helperText: "Name can't be empty",
      ),
    );
  }
  Widget professionTextField() {

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
       underline: Container(
         height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
    // return TextFormField(
    //   controller: _category,
    //   validator: (value) {
    //     if (value.isEmpty) return "category can't be empty";
    //
    //     return null;
    //   },
    //   decoration: InputDecoration(
    //     border: OutlineInputBorder(
    //         borderSide: BorderSide(
    //           color: Colors.teal,
    //         )),
    //     focusedBorder: OutlineInputBorder(
    //         borderSide: BorderSide(
    //           color: Colors.orange,
    //           width: 2,
    //         )),
    //     prefixIcon: Icon(
    //       Icons.category,
    //       color: Colors.green,
    //     ),
    //     labelText: "Category",
    //     helperText: "Category can't be empty",
    //   ),
    // );
  }

  Widget dobField() {
    return TextFormField(
      controller: _price,
      validator: (value) {
        if (value.isEmpty) return "price can't be empty";

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
        prefixIcon: Icon(
          Icons.attach_money,
          color: Colors.green,
        ),
        labelText: "Price Per Unit",
        helperText: "Provide price of single service ",

      ),
    );
  }

  Widget titleTextField() {
    return TextFormField(
      controller: _no_of_service,
      validator: (value) {
        if (value.isEmpty) return "Enter number of services available";

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
        prefixIcon: Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: "Number Of Services Available",
        helperText: "Enter in digits",

      ),
    );
  }

  Widget aboutTextField() {
    return TextFormField(
      controller: _description,
      validator: (value) {
        if (value.isEmpty) return "About service";

        return null;
      },
      maxLines: 4,
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
        labelText: "Description",

      ),
    );
  }
}

