import 'package:AgriNet/models/booking.dart';
import 'package:AgriNet/screens/pages/contractSigning.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingListingCard extends StatefulWidget {
  final Booking booking;
  String status;
  final String serviceCategory;
  final String price;
  final String farmerName;
  BookingListingCard({this.booking,this.status,this.serviceCategory,this.price,this.farmerName});
  @override
  _BookingListingCardState createState() => _BookingListingCardState();
}

class _BookingListingCardState extends State<BookingListingCard> {

  @override
  void initState () {
    super.initState();
    if(widget.booking.status=='Cancelled' || widget.booking.status=='Rejected'){
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
    setState(() {
      widget.status = 'Accepted';
      buttonVisible=false;
    });
  }


  cancel() {
    updateBooking(widget.booking.docid,'Cancelled')
        .then((value) {
      setState(() {
        widget.booking.status = 'Cancelled';
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

  @override
  Widget build(BuildContext context) {
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
                                  //"On Feb 16,22",
                                  "${DateFormat.yMMMd().format(widget.booking.statusOn)}",

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
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          "request on:",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                        DateFormat.yMMMd().format(widget.booking.createdOn),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff528090),
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
                //!widget.booking.isSpPaymentDone?buttonVisible?buttonWidget():Container():Container(),
                widget.booking.status != 'Completed' && widget.booking.status != 'Cancelled'?
                !widget.booking.isSpPaymentDone?
                widget.booking.status == 'Accepted'?
                twoButtonWidgetCompleted():cancelButtonWidget():completeButtonWidget():Container(),
              ],
            ),
          ),
        ),
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
  Widget cancelButtonWidget() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyButton(name:"Cancel",
          onPressed: () =>cancel(),
          ratio: 0.82,
          color: Color(0xff86d76d)
      ),
    );
  }
  Widget buttonWidget() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyButton(name:"Cancel",
          onPressed: () =>cancel(),
          ratio: 0.82,
          color: Color(0xff86d76d)
      ),
    );
  }

  Widget twoButtonWidgetCompleted() {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          MyButton(name:"Completed",
            onPressed: () =>completed(),
            ratio: 0.41,
            color: Color(0xffd782d6),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: MyButton(name:"Cancel",
                  onPressed: () =>cancel(),
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
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Card(
          //elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          child:Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 55.0,
                        height: 55.0,
                        //color: Colors.green,
                        child:CircleAvatar(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.green,
                          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU",
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.booking.serviceName,
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            widget.booking.spName,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                ],
              )
          )
      )
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
            ' booking date:${DateFormat.yMMMd().format(widget.booking.createdOn)}\nService Period:${DateFormat.yMMMd().format(widget.booking.Startdate)} to ${DateFormat.yMMMd().format(widget.booking.Enddate)}',
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
                builder: (ctx) =>ContractSigning(
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