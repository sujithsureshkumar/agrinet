import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/imgProvider.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/addImageCard.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/serviceListingCard.dart';
import 'package:AgriNet/widget/viewImageCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/constants/constant.dart';
import 'package:provider/provider.dart';




class EditService extends StatefulWidget {
  final Service service;

  EditService({Key key,@required this.service}) : super(key: key);
  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  @override
  void initState() {
    super.initState();
    _asyncMethod();
    setState(() {
      _servicename.text = widget.service.name;
      _price.text=widget.service.price;
      _equipmentDetail.text=widget.service.equipmentDetail;
      _description.text=widget.service.description;
     // _controllerEmail.text = widget.email;
      categoryValue=widget.service.category;
      subCategoryValue=widget.service.subCategory;
    });
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
        .doc('serviceCategory')
        .get();

    CategoryList = (categorySnapShot.data()as Map<String, dynamic>)['serviceCategory'];

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
  TextEditingController _servicename = TextEditingController();
  //TextEditingController _category = TextEditingController();
  TextEditingController _price = TextEditingController();
  //TextEditingController _no_of_service = TextEditingController();
  TextEditingController _equipmentDetail= TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);

    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
    //_price.text=widget.service.price;
    //_servicename.text=widget.service.name;
    //print(widget.service.name);
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
            backgroundColor: kLightColor),
        onPressed: () {
          deleteService(widget.service.docid).then((value) =>
              servicesProvider.getserviceListing(user.uid).then((value) =>
              Navigator.of(context)
                ..pop())
          );

        },
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
                      backgroundColor: kPrimaryColor,
                  ),
                onPressed: () async => await sp_updateService(widget.service.docid,_servicename.text, categoryValue,
                    subCategoryValue, _price.text,_equipmentDetail.text, _description.text,imgProvider.imageUrlList).then((value) => {
                  Navigator.of(context)
                    ..pop()
                    ..pop()
                }),
              ),
            ),
            SizedBox(
                width:5
            ),
          ],
        ),
      ),

      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            // imageProfile(),
            ViewImageCard(imageList:widget.service.imageUrl),
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
            priceField(),
           /* SizedBox(
              height: 20,
            ),*/
            //titleTextField(),
            SizedBox(
              height: 20,
            ),
            equipmentDetailsField(),
            SizedBox(
              height: 20,
            ),
            descriptionField(),
            SizedBox(
              height: 20,
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


  Widget priceField() {
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

  /*Widget titleTextField() {
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
  }*/
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

  Widget equipmentDetailsField() {
    return TextFormField(
      controller: _equipmentDetail,
      validator: (value) {
        if (value.isEmpty) return "About service";

        return null;
      },
      maxLines: 2,
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
        labelText: "Equipment Detail",
      ),
    );
  }

  Widget descriptionField() {
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
