import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File image;

  @override
  Widget build(BuildContext context) {
    Future pickImage() async{

      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image =imageTemporary);


    }


    Future uploadPic(BuildContext context) async{
      String fileName = basename(image.path);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      TaskSnapshot taskSnapshot=await uploadTask;
      setState(() {
        print("Profile Picture uploaded");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      appBar: DefaultAppBar(title: 'My Profile'),
     /* AppBar(
        leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('Edit Profile'),
      ),*/
      body: Builder(
        builder: (context) =>  Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor:kPrimaryColor,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (image!=null)?Image.file(
                            image,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                          color: kPrimaryColor,
                      ),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Username',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('George',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Phone no.',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('7518445511',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Email id',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('george@gmail.com',
                                style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        FontAwesomeIcons.pen,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              /*Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Email',
                        style:
                        TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                    SizedBox(width: 20.0),
                    Text('george@gmail.com',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),*/
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),

                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                        elevation: MaterialStateProperty.all(4),)

                  ),
                  ElevatedButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),

                    onPressed: () {
                      uploadPic(context);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                      elevation: MaterialStateProperty.all(4),),

                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}