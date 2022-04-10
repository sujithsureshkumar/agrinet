import 'package:AgriNet/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../providers/imgProvider.dart';


class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  //final scrollController = ScrollController();
  //ImgPicker ImgPick;



  Widget addImageCard() {
    ImgProvider imgProvider = Provider.of<ImgProvider>(context, listen: false);
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
                              imgProvider.uploadImage();
                            },
                            icon: Icon(Icons.add, size: 44.0 ,),
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

  Widget catalogueCard(String imagelink) {
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
                                image: NetworkImage(imagelink)
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

  }


  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context){
    return Consumer<ImgProvider>(
        builder:(context, imgProvider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff6d8000),
              title: Padding(
                padding: EdgeInsets.only(top: 4.0),
                child:Center(
                    child:Text("Add Image")
                ),
              ),
            ),
            backgroundColor: Colors.grey[900],
            body: Column(
              children: [
                Container(
                  child: SingleChildScrollView(
                    scrollDirection:Axis.horizontal,
                    padding: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: <Widget>[
                          Row(
                              children:[addImageCard()]
                          ),

                          Row(
                            children: imgProvider.imageUrlList.map((p) {
                              return catalogueCard(p);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:Center(
                              child: Text(
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
                    ),

                    Expanded(
                      child: InkWell(
                        onTap: () async {
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:Center(
                              child: Text(
                                "Skip",
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
                    ),
                  ],
                ),
              ],
            ),


          );

        }
    );
  }
}