import 'package:AgriNet/providers/users_provider.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/img_picker.dart';

class ListViewWidget extends StatefulWidget {
  final UsersProvider usersProvider;

  const ListViewWidget({
    @required this.usersProvider,
    Key key,
  }) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final scrollController = ScrollController();

  String imageUrl;

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


      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }

  ImgPicker ImgPick;

  Widget addImageCard() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              /* builder: (ctx) => DetailScreen(
                image:service.imageUrl ,
                name:service.name ,
                price: service.price,
              ),*/
            ),
          );
        },
        child: Container(
          height: 200,
          width: 150.0,
          child: Card(
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(

                            onPressed: () {
                              uploadImage();
                            },
                            icon: Icon(Icons.category, size: 44.0 ,),
                            //label: Text('Home')
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Add Image",
                          style: TextStyle (
                              color: Colors.white,
                              fontSize: 18
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget catalogueCard(service) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
             /* builder: (ctx) => DetailScreen(
                image:service.imageUrl ,
                name:service.name ,
                price: service.price,
              ),*/
            ),
          );
        },
        child: Container(
          height: 200,
          child: Card(
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 200.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(service.imageUrl)
                            )
                        )),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    widget.usersProvider.fetchNextUsers();
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.usersProvider.hasNext) {
        widget.usersProvider.fetchNextUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: SingleChildScrollView(
          scrollDirection:Axis.horizontal,
          controller: scrollController,
          padding: EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
          children: <Widget>[
            Row(
                children:[addImageCard()]
            ),

                Row(
                    children: widget.usersProvider.serviceList.map((p) {
                      return catalogueCard(p);
                    }).toList(),
                ),
                if (widget.usersProvider.hasNext)
                  GestureDetector(
                    onTap: widget.usersProvider.fetchNextUsers,
                    child: Container(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
            ),
      ),


      );

  }
}