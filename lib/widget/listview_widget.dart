import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/screens/pages/detailscreen.dart';
import 'package:AgriNet/widget/catalogueCard.dart';
import 'package:AgriNet/widget/likeButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';
import '../providers/services_provider.dart';

class ListViewWidget extends StatefulWidget {
  //final ServicesProvider servicesProvider;



  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final scrollController = ScrollController();

 /* Widget catalogueCard(service) {
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
                            child:LikeButtonWidget(isLiked:service.isLiked,likeCount:service.likeCount,docid:service.docid),
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
  }*/






  @override
  Widget build(BuildContext context){

    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    final user = Provider.of<Users>(context);
    servicesProvider.fetchFirebaseWishlist(user.uid);
    servicesProvider.getserviceSnapShot();

    return Consumer<ServicesProvider>(
      builder:(context, servicesProvider, _) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: ListView(
            padding: EdgeInsets.all(12),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  children: <Widget>[
                    Column(
                        children: servicesProvider.serviceList.map((p) {
                          return CatalogueCard(service: p,user: user);
                        }).toList()
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );

  }
}