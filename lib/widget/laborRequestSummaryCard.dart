import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/laborHiring.dart';
import 'package:AgriNet/screens/pages/laborContractSign.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class LaborRequestSummaryCard extends StatefulWidget {

  LaborHiring laborHiring;
  LaborRequestSummaryCard ({this.laborHiring});

  @override
  _LaborRequestSummaryCardState createState() => _LaborRequestSummaryCardState();
}

class _LaborRequestSummaryCardState extends State<LaborRequestSummaryCard> {
  bool buttonVisible=true;

  @override
  void initState () {
    super.initState();
    if(widget.laborHiring.status=='Accepted' || widget.laborHiring.status=='Rejected' || widget.laborHiring.status=='Cancelled'){
      setState(() {
        buttonVisible=false;
      });
    }
  }

  Widget buttonWidget() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          MyButton(name:"Accept",
            onPressed: () =>accept(),
            ratio: 0.41,
            color: Color(0xffd782d6),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: MyButton(name:"Reject",
                  onPressed: () =>reject(),
                  ratio: 0.41,
                  color: Color(0xff86d76d)
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget completeButtonWidget() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyButton(name:"Completed",
          onPressed: () =>completed(),
          ratio: 0.82,
          color: Color(0xff86d76d)
      ),
    );
  }


  completed() {
    updateLaborHiring(widget.laborHiring.docid,'Completed')
        .then((value) {
      setState(() {
        widget.laborHiring.status = 'Completed';
        widget.laborHiring.statusOn = DateTime.now();
        buttonVisible=false;
      });
    });
  }
  accept() {
    updateLaborHiring(widget.laborHiring.docid,'Accepted')
        .then((value) {
      setState(() {
        widget.laborHiring.status = 'Accepted';
        widget.laborHiring.statusOn = DateTime.now();
        buttonVisible=false;
      });
    });
  }
  reject() {
    updateLaborHiring(widget.laborHiring.docid,'Rejected')
        .then((value) {
      setState(() {
        widget.laborHiring.status = 'Rejected';
        widget.laborHiring.statusOn = DateTime.now();
        buttonVisible=false;
      });
    });
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:10,
                    ),
                    Text("Status            :   "+widget.laborHiring.status,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.0)),
                    SizedBox(
                      height:10,
                    ),
                    Text("Hirer Name        :   "+widget.laborHiring.hirerName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17.0)),
                    SizedBox(
                      height:10,
                    ),
                    Text("Hirer Type     :   "+widget.laborHiring.hiringType,
                        style: TextStyle(
                            fontSize: 15.0, color: kLightColor)),
                    SizedBox(
                      height:10,
                    ),
                    Text("Request Made On     :   "+DateFormat.yMMMd().format(widget.laborHiring.createdOn),
                        style: TextStyle(
                            fontSize: 14.0, color: Color(0xFF90C440))),
                    SizedBox(
                      height:10,
                    ),
                    Text("Labor Phone no.        :    ${widget.laborHiring.laborPhone_number}"),
                    SizedBox(
                      height:10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>LaborContractSign(laborHiring: widget.laborHiring,)
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                ' More Details',
                                style: TextStyle(fontSize: 18, height: 1.4,fontWeight: FontWeight.bold,
                                    color: Color(0xffb46a6a)),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.pink,
                                  size: 24.0,
                                  semanticLabel: 'Text to announce in accessibility modes',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height:20,
                    ),
                   // buttonVisible?buttonWidget():Container(),
                    widget.laborHiring.status!='Completed' && widget.laborHiring.status!='Cancelled'?buttonVisible?
                    buttonWidget():completeButtonWidget():Container(),
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