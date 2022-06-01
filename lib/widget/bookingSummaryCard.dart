import 'package:AgriNet/models/booking.dart';
import 'package:AgriNet/screens/pages/spContractSign.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingSummaryCard extends StatefulWidget {
  Booking booking;
  BookingSummaryCard({this.booking});
  @override
  _BookingSummaryCardState createState() => _BookingSummaryCardState();
}

class _BookingSummaryCardState extends State<BookingSummaryCard> {

  String location = 'loading..';

  Future<void> GetAddressFromLatLong(GeoPoint locat)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(locat.latitude, locat.longitude);
    print(placemarks);
    Placemark place= placemarks[0];
    location = place.locality;
    setState(()  {
    });
  }

  @override
  void initState () {
    super.initState();
    GetAddressFromLatLong(widget.booking.farmLocation);
    if(widget.booking.status=='Accepted' || widget.booking.status=='Rejected' || widget.booking.status=='Cancelled'){
      setState(() {
        buttonVisible=false;
      });
    }
  }
  static final double radius = 20;
  bool buttonVisible=true;


 /* UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }*/
 accept() {
   updateBooking(widget.booking.docid,'Accepted')
       .then((value) {
     setState(() {
       widget.booking.status = 'Accepted';
       widget.booking.statusOn = DateTime.now();
       buttonVisible=false;
     });
       });
  }
  reject() {
    updateBooking(widget.booking.docid,'Rejected')
        .then((value) {
      setState(() {
        widget.booking.status = 'Rejected';
        widget.booking.statusOn = DateTime.now();
        buttonVisible=false;
      });
    });
  }
  completed() {
    updateBooking(widget.booking.docid,'Completed')
        .then((value) {
      setState(() {
        widget.booking.status = 'Completed';
        widget.booking.statusOn = DateTime.now();
        buttonVisible=false;
      });
    });
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

  @override
  Widget build(BuildContext context) {
   // GetAddressFromLatLong(widget.booking.farmLocation);
    print(DateFormat.yMMMd().format(DateTime.now()));

    print(DateFormat.yMMMMd('en_US').format(DateTime.now()));
    return Padding(
      padding: EdgeInsets.all(12),
      child: Card(

        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  /*GestureDetector(
                    onTap: () => isExpanded ? shrinkTile() : expandTile(),
                    child: buildImage(),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.event_note,
                          color: Colors.pink,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(

                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                                children: [
                                  Text(
                                    widget.booking.status,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),

                                  Text(
                                    DateFormat.yMMMMd('en_US').format(widget.booking.statusOn),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.red,
                                    ),
                                  ),
                                ]
                            ),
                          ),
                        ),

                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                                children: [
                                  Row(
                                    children: [
                                      /*Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Service:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),*/
                                      Expanded(
                                        child: Text(
                                          widget.booking.serviceName,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff528090),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "amount:",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${widget.booking.price} Rs",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff528090),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ]
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  detailWidget(),
                  Divider(),
                  buildText(context),
                  widget.booking.status!='Completed'?buttonVisible?buttonWidget():completeButtonWidget():Container(),
                ],
              ),
            ),
        ),
      ),
    );
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

  Widget detailWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Farm Name:",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),

                          Expanded(
                            child: Text(
                              widget.booking.farmName,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.pink,
                            size: 14.0,
                          ),
                          Expanded(
                            child: Text(
                              location,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                width: 20,
              ),
              Expanded(
                child:Align(
                  alignment: Alignment.centerRight,
                child: IconButton(

                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        //builder: (ctx) => MyHomePage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.phone,
                      size: 23.0 ,
                      color: Color(0xff7b4949)
                  ),
                  //label: Text('Home')
                ),
                ),
              ),

            ],
          ),
    );

  }

  Widget buildText(BuildContext context) => Theme(
    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
    child: ExpansionTile(
      /*key: keyTile,
      initiallyExpanded: isExpanded,
      */
      childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
      title: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Order Details',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Color(0xff324441)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'View Order Details',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal,color: Color(0xff415e5b)),
            ),
          ),
        ],
      ),
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            ' Request date:${DateFormat.yMMMd().format(widget.booking.createdOn)}\nService Period:${DateFormat.yMMMd().format(widget.booking.Startdate)} to ${DateFormat.yMMMd().format(widget.booking.Enddate)}',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      Divider(
          color: Color(0xff7b4949)
      ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (ctx) =>SpContractSign(
                    booking: widget.booking,
                  )
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
        Divider(
            color: Color(0xff7b4949)
        ),
      ],
     /* onExpansionChanged: (isExpanded) => Utils.showSnackBar(
        context,
        text: isExpanded ? 'Expand Tile' : 'Shrink Tile',
        color: isExpanded ? Colors.green : Colors.red,
      ),*/
    ),
  );
}