import 'package:AgriNet/widget/mybutton.dart';
import 'package:flutter/material.dart';

class BookingSummaryCard extends StatefulWidget {
  String status;
  BookingSummaryCard({this.status,});
  @override
  _BookingSummaryCardState createState() => _BookingSummaryCardState();
}

class _BookingSummaryCardState extends State<BookingSummaryCard> {
  static final double radius = 20;

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

  @override
  Widget build(BuildContext context) {
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
                      Column(
                          children: [
                            Text(
                              "Accepted",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),

                            Text(
                              "On Feb 16,22",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.red,
                              ),
                            ),
                          ]
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Service:Harvesting",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "amount:3000",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
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
                buttonWidget(),
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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  //builder: (ctx) => CheckOut(),
                ),
              );
            },
            ratio: 0.41,
            color: Color(0xffd782d6),
          ),

          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: MyButton(name:"Reject",
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      //builder: (ctx) => CheckOut(),
                    ),
                  );
                },
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
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Customer:",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),

                      Text(
                        "Paddy Farmer",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.red,
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
                      Text(
                        "Thalapuzha, Manandavady,wayanad",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
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
  Widget buildImage() => Image.network(
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80',
    fit: BoxFit.cover,
    width: double.infinity,
    height: 400,
  );

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
            ' Order date:24-12-22\nService Period:24-12-22 to 01-02-21 ',
            style: TextStyle(fontSize: 13, height: 1.4),
          ),
        ),
      Divider(
          color: Color(0xff7b4949)
      ),
        GestureDetector(
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