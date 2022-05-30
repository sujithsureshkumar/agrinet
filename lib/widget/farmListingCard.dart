import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/farm.dart';
import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/screens/pages/addImageFarm.dart';
import 'package:AgriNet/screens/pages/editService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class FarmListingCard extends StatefulWidget {

  Farm farm;
  FarmListingCard ({this.farm});

  @override
  _FarmListingCardState createState() => _FarmListingCardState();
}

class _FarmListingCardState extends State<FarmListingCard> {
  @override
  Widget build(BuildContext context) {
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        farmProvider.setDocid(widget.farm.docid);
        Navigator.of(context).push(
          MaterialPageRoute(
             builder: (ctx) => AddImageFarm()
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
                    Text("Farm Name :  "+widget.farm.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: kFixPadding)),
                    SizedBox(
                      height:10,
                    ),
                    Text("Farm Category :  "+widget.farm.subCategory ,
                        style: TextStyle(
                            fontSize: 12.0, color: kLightColor)),
                    SizedBox(
                      height:10,
                    ),
                    Text("Farm Added On :  "+DateFormat.yMMMd().format(widget.farm.createdOn,),
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF90C440))),
                    SizedBox(
                      height:10,
                    ),
                    widget.farm.locationSet?Text("Farm Location add status : Completed"):
                    Text("Farm Location add status : Pending"),
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