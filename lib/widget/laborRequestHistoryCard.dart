import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/laborHiring.dart';
import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/screens/pages/editService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class LaborRequestHistoryCard extends StatefulWidget {

  LaborHiring laborHiring;
  LaborRequestHistoryCard ({this.laborHiring});

  @override
  _LaborRequestHistoryCardState createState() => _LaborRequestHistoryCardState();
}

class _LaborRequestHistoryCardState extends State<LaborRequestHistoryCard> {
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
                    Text(widget.laborHiring.laborName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: kFixPadding)),
                    Text(widget.laborHiring.laborSkill,
                        style: TextStyle(
                            fontSize: 12.0, color: kLightColor)),
                    Text(DateFormat.yMMMd().format(widget.laborHiring.createdOn),
                        style: TextStyle(
                            fontSize: 12.0, color: Color(0xFF90C440))),
                    Text(" ${widget.laborHiring.laborPhone_number}"),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}