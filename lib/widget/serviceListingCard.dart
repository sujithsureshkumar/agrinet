import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';




class ServiceListingCard extends StatefulWidget {

  Service service;
  ServiceListingCard({this.service});

  @override
  _ServiceListingCardState createState() => _ServiceListingCardState();
}

class _ServiceListingCardState extends State<ServiceListingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
              margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              //padding: EdgeInsets.all(8.0),
              //decoration: BoxDecoration(border: Border.all(color: kAccentColor)),
              child: Row(
                children: [
                  Image(
                    image: NetworkImage(widget.service.imageUrl[0]),
                    height: 110.0,
                    width: 110.0,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.service.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: kFixPadding)),
                          Text("Category",
                              style: TextStyle(
                                  fontSize: 12.0, color: kLightColor)),
                          Text("Date",
                              style: TextStyle(
                                  fontSize: 12.0, color: Color(0xFF90C440))),
                          Text("\$ ${widget.service.name}"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
  }
}