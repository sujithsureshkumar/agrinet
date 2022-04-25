import 'dart:io';

//import 'package:blogapp/NetworkHandler.dart';
//import 'package:blogapp/Pages/HomePage.dart';
//import 'package:blogapp/Screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/users.dart';
import '../../providers/services_provider.dart';
import '../../services/firebase_api_methods.dart';
import 'addImage.dart';
//import 'package:image_picker/image_picker.dart';

class AddService extends StatefulWidget {
  AddService({Key key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  //final networkHandler = NetworkHandler();
  List<String> imageUrlList=["https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2Fnoimage.png?alt=media&token=47ee7a64-0059-4527-a72f-3b983957d887"];
  bool circular = false;
  //PickedFile _imageFile;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _servicename = TextEditingController();
  TextEditingController _category= TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _no_of_service= TextEditingController();
  TextEditingController _description= TextEditingController();
  //final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
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
                  ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
                await servicesProvider.sp_addservice(user.uid,_servicename.text, _category.text,
                      _price.text, _no_of_service.text, _description.text,imageUrlList).then((value) => {
                  Navigator.of(context).push(
                  MaterialPageRoute(
                  builder: (ctx) => AddImage(),
                  ),
                  )
                  });

                  // var response =
                  // await networkHandler.post("/profile/add", data);
                  // if (response.statusCode == 200 ||
                  //     response.statusCode == 201) {
                  //   if (_imageFile.path != null) {
                  //     var imageResponse = await networkHandler.patchImage(
                  //         "/profile/add/image", _imageFile.path);
                  //     if (imageResponse.statusCode == 200) {
                  //       setState(() {
                  //         circular = false;
                  //       });
                  //       Navigator.of(context).pushAndRemoveUntil(
                  //           MaterialPageRoute(builder: (context) => HomePage()),
                  //               (route) => false);
                  //     }
                  //   } else {
                  //     setState(() {
                  //       circular = false;
                  //     });
                  //     Navigator.of(context).pushAndRemoveUntil(
                  //         MaterialPageRoute(builder: (context) => HomePage()),
                  //             (route) => false);
                  //   }
                  // }
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
  //
  // Widget imageProfile() {
  //   return Center(
  //     child: Stack(children: <Widget>[
  //       CircleAvatar(
  //         radius: 80.0,
  //         backgroundImage: _imageFile == null
  //             ? AssetImage("assets/profile.jpeg")
  //             : FileImage(File(_imageFile.path)),
  //       ),
  //       Positioned(
  //         bottom: 20.0,
  //         right: 20.0,
  //         child: InkWell(
  //           onTap: () {
  //             showModalBottomSheet(
  //               context: context,
  //               builder: ((builder) => bottomSheet()),
  //             );
  //           },
  //           child: Icon(
  //             Icons.camera_alt,
  //             color: Colors.teal,
  //             size: 28.0,
  //           ),
  //         ),
  //       ),
  //     ]),
  //   );
  // }
  //
  // Widget bottomSheet() {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: EdgeInsets.symmetric(
  //       horizontal: 20,
  //       vertical: 20,
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Text(
  //           "Choose Profile photo",
  //           style: TextStyle(
  //             fontSize: 20.0,
  //           ),
  //         ),
  //         SizedBox(
  //           height: 20,
  //         ),
  //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
  //           FlatButton.icon(
  //             icon: Icon(Icons.camera),
  //             onPressed: () {
  //               takePhoto(ImageSource.camera);
  //             },
  //             label: Text("Camera"),
  //           ),
  //           FlatButton.icon(
  //             icon: Icon(Icons.image),
  //             onPressed: () {
  //               takePhoto(ImageSource.gallery);
  //             },
  //             label: Text("Gallery"),
  //           ),
  //         ])
  //       ],
  //     ),
  //   );
  // }
  //
  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(
  //     source: source,
  //   );
  //   setState(() {
  //     _imageFile = pickedFile;
  //   });
  // }

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
        prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),
        labelText: "Category",
        helperText: "Category can't be empty",
      ),
    );
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