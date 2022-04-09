import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AgriNet/services/firebase_api.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ImgProvider extends ChangeNotifier {
  String imageUrl;
  List<String> imageUrlList=[];

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    //final _picker = ImagePicker();
    final _picker = ImagePicker();
    //PickedFile image;


    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      //image = await _picker.getImage(source: ImageSource.gallery);
      XFile image = await _picker.pickImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _storage.ref()
            .child('folderName/imageName')
            .putFile(file);
        //.onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();
        print(downloadUrl);
        imageUrlList.add(downloadUrl);
        notifyListeners();



      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}