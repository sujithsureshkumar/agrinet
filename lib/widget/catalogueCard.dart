import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/models/users.dart';
import 'package:flutter/material.dart';

import '../screens/pages/detailscreen.dart';
import 'likeButtonWidget.dart';

class CatalogueCard extends StatelessWidget {
  final Service service;
  final Users user;
  CatalogueCard({this.service,this.user});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => DetailScreen(
                  image:service.imageUrl ,
                  name:service.name ,
                  price: service.price,
                ),
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
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(service.imageUrl)
                              )
                          )),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(service.name,
                              style: TextStyle (
                                  color: Colors.white,
                                  fontSize: 18
                              ),
                            ),
                            Expanded(
                              child: Text(service.name,
                                style: TextStyle (
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              ),
                            ),


                            Expanded(
                              child: Text("Price: "+service.price.toString(),
                                style: TextStyle (
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              /*child: IconButton(

                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.favorite,
                                  size: 22.0 ,
                                  color: Color(0xffedf1f0)
                              ),
                              //label: Text('Home')
                            ),*/
                              child:LikeButtonWidget(isLiked:service.isLiked,
                                  likeCount:service.likeCount,
                                  docid:service.docid,
                                  userid: user.uid,
                              ),
                            ),

                          ],
                        ),
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
  }