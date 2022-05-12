import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/farm.dart';
import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/screens/pages/editService.dart';
import 'package:flutter/material.dart';




class FarmListingCard extends StatefulWidget {

  Farm farm;
  FarmListingCard ({this.farm});

  @override
  _FarmListingCardState createState() => _FarmListingCardState();
}

class _FarmListingCardState extends State<FarmListingCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
             // builder: (ctx) => EditService(service: widget.farm)
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
        //padding: EdgeInsets.all(8.0),
        //decoration: BoxDecoration(border: Border.all(color: kAccentColor)),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.farm.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: kFixPadding)),
                    Text("Category",
                        style: TextStyle(
                            fontSize: 12.0, color: kLightColor)),
                    Text("Date",
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF90C440))),
                    Text("\$ ${widget.farm.name}"),
                  ],
                ),
              ),
            ),

            Image(
              image: NetworkImage(widget.farm.imageUrl[0]),
              height: 110.0,
              width: 110.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}