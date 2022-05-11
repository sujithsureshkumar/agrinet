import 'dart:io';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/screens/pages/addImageFarm.dart';
import 'package:AgriNet/screens/pages/addImageService.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:AgriNet/services/addservice.dart';

class AddFarm extends StatefulWidget {
  AddFarm({Key key}) : super(key: key);

  @override
  _AddFarmState createState() => _AddFarmState();
}
class _AddFarmState extends State<AddFarm> {

  @override
  void initState () {
    super.initState();
    _asyncMethod();
  }
  List<String> catList=[];
  Map<String, dynamic> CategoryList;
  String categoryValue = '';
  String subCategoryValue;
  List<String> subCategory;
  List<String> _tempList=[];
  _asyncMethod() async {
    DocumentSnapshot categorySnapShot =
    await FirebaseFirestore.instance
        .collection('Category')
        .doc('category')
        .get();

    CategoryList = (categorySnapShot.data()as Map<String, dynamic>)['category'];

    catList = CategoryList.keys.toList();
    categoryValue = catList[0];
    print(CategoryList);
    print(catList);

    setState((){});
  }

  _newGetList() async {
    _tempList=[];
    CategoryList[categoryValue].forEach((result){
      _tempList.add(result);
    });
    setState(() {
      subCategory=_tempList;
      subCategoryValue=null;
    });
  }

  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _subcategory= TextEditingController();
  TextEditingController _landarea= TextEditingController();
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
            categoryTextField(),
            SizedBox(
              height: 20,
            ),
            subCategoryTextField(),
            SizedBox(
              height: 20,
            ),
            landAreaTextField(),
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
                   await farmProvider.farmer_addfarm(user.uid,_name.text, categoryValue,
                     subCategoryValue, _landarea.text,).then((value) => {
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
  Widget categoryTextField() {
    return DropdownButtonFormField(
      value: categoryValue,
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
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          categoryValue = newValue;
          _newGetList();
        });
      },
      items: catList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget subCategoryTextField() {
    return DropdownButtonFormField(
      value: subCategoryValue,
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
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          subCategoryValue = newValue;
        });
      },
      items: subCategory?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })?.toList(),
    );
  }



  Widget landAreaTextField() {
    return TextFormField(
      controller: _landarea,
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
        labelText: "Landarea",
        helperText: "Enter in digits",

      ),
    );
  }



}
