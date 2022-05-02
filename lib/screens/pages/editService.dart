import 'package:AgriNet/widget/addImageCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/constants/constant.dart';




class editService extends StatefulWidget {
  editService({Key key}) : super(key: key);

  @override
  _editServiceState createState() => _editServiceState();
}

class _editServiceState extends State<editService> {
  @override
  void initState() {
    super.initState();
    _asyncMethod();
    setState(() {
      _servicename.text = 'fullName';
     // _controllerEmail.text = widget.email;
    });
  }

  List<String> catList = [];
  String dropdownValue = '';

  _asyncMethod() async {
    QuerySnapshot categorySnapShot =
    await FirebaseFirestore.instance
        .collection('category')
        .get();

    dropdownValue = categorySnapShot.docs[0].id;
    categorySnapShot.docs.forEach((result) {
      catList.add(result.id);
    });
    print(catList);

    setState(() {});
  }

  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _servicename = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _no_of_service = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "Edit Service"),
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
        child: Text("Delete", style: TextStyle(fontSize: 18.0)),
        style: TextButton.styleFrom(
            primary: kWhiteColor,
            elevation: 2,
            backgroundColor: kPrimaryColor),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            //builder: (context) => DeliveryAddress(),
          ),
        ),
      ),
            ),

            SizedBox(
                width:10
            ),
            Expanded(
              child: TextButton(
                //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                //color: kPrimaryColor,
                //textColor: kWhiteColor,
                child: Text("Save", style: TextStyle(fontSize: 18.0)),
                  style: TextButton.styleFrom(
                      primary: kWhiteColor,
                      elevation: 2,
                      backgroundColor: kLightColor,
                  ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    //builder: (context) => DeliveryAddress(),
                  ),
                ),
              ),
            ),
            SizedBox(
                width:5
            ),
          ],
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: <Widget>[
          // imageProfile(),
          AddImageCard(),
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
        ],
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
    return DropdownButtonFormField(
      value: dropdownValue,
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
          child: Icon(Icons.arrow_circle_down_sharp)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          dropdownValue = newValue;
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

  Widget dobField() {
    return TextFormField(
      controller: _price,
      keyboardType:TextInputType.number,
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
      keyboardType:TextInputType.number,
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
