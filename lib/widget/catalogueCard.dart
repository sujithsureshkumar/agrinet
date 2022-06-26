import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/screens/pages/serviceDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/pages/detailPage.dart';
import '../screens/pages/detailscreen.dart';
import 'likeButtonWidget.dart';

class CatalogueCard extends StatelessWidget {
  final Service service;
  final Users user;
  CatalogueCard({this.service,this.user});

  String spName;
  @override
  Widget build(BuildContext context) {
    //ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    //servicesProvider.getServiceProviderDetails(service.serv_prov_id);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ServiceDetails(
                  service: service,
                  user: user,
                ),
              ),
            );
          },
          child: Container(
            height: 200,
            child: Card(
              //color: Colors.grey[800],
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
                                  image: NetworkImage(service.imageUrl[0])
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
                                  color: Color(0xffe57008),
                                  fontSize: 18
                              ),
                            ),


                                Expanded(
                                      child: Text(service.spName,
                                        style: TextStyle (
                                            color: Color(0xffe57008),
                                            fontSize: 12
                                        ),
                                      ),
                                    ),



                            Expanded(
                              child: Text("Price: ${service.price} Rs/${service.priceUnit}",
                                style: TextStyle (
                                    color: Color(0xffe57008),
                                    fontSize: 12
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 70,
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:LikeButtonWidget(isLiked:service.isLiked,
                                        likeCount:service.likeCount,
                                        docid:service.docid,
                                        userid: user.uid,
                                    ),
                                  ),
                                ),
                              ],
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