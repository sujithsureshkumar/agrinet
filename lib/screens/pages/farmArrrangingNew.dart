import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/farm.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'dart:math' show cos, sqrt, asin;

class FarmArrangingNew extends StatefulWidget {
  final List memberList;
  FarmArrangingNew({this.memberList,Key key}) : super(key: key);
  @override
  _FarmArrangingNewState createState() => _FarmArrangingNewState();
}

class _FarmArrangingNewState extends State<FarmArrangingNew> {
  double totalDistance;

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }

  void distanceCalculator() {
    totalDistance = 0;
    for(var i = 0; i < widget.memberList.length-1; i++){
      totalDistance += calculateDistance(
          widget.memberList[i]['location'].latitude, widget.memberList[i]['location'].longitude,
          widget.memberList[i+1]['location'].latitude, widget.memberList[i+1]['location'].longitude);
    }
    print(totalDistance);
  }

  Widget buidFarmList(int index,List farmList){

    return Padding(
      key: ValueKey(farmList[index]),
      padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              //builder: (ctx) =>
            ),
          );
        },
        child: Card(
          //elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child:Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10.0,
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          farmList[index]['myFarm'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          farmList[index]['name'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Icon( Icons.expand_less, ),

                              Text(
                                //farmList[index]['location'].latitude.toString(),
                                  calculateDistance(
                                      farmList[index]['location'].latitude, farmList[index]['location'].longitude,
                                      farmList[(index+1)%farmList.length]['location'].latitude, farmList[(index+1)%farmList.length]['location'].longitude)
                                      .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                              Icon( Icons.expand_more, ),
                            ],
                          )),
                    ),




                    SizedBox(
                      //width: 10.0,
                      height: 30,
                    ),

                  ],
                )
            )
        ),
      ),
    );
  }

  Widget textField(String name) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width*0.95,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            textScaleFactor: 1.3,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:  Border(
          left: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          top: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),

        //helperText: "Name can't be empty",
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
  appBar: DefaultAppBar(title: "Farm Arranging"),

    bottomNavigationBar: BottomAppBar(
      elevation: kLess,
      color: kWhiteColor,
      child: Container(
        height: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textField("Total Distance:${totalDistance.toString()}"),
          )
        ]
        ),
            Row(
              children: [
                SizedBox(
                    width:5
                ),
                Expanded(
                  child: TextButton(
                    //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                    //color: kPrimaryColor,
                    //textColor: kWhiteColor,
                    child: Text("Calculate", style: TextStyle(fontSize: 18.0)),
                    style: TextButton.styleFrom(
                        primary: kWhiteColor,
                        elevation: 2,
                        backgroundColor: kLightColor),
                    onPressed: () =>setState(() {
                      distanceCalculator();
                    }),

                  ),
                ),

                SizedBox(
                    width:10
                ),
                Expanded(
                  child: TextButton(
                    //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                    //color: kPrimaryColor,
                    //textColor: kWhiteColor,
                    child: Text("Save", style: TextStyle(fontSize: 18.0)),
                    style: TextButton.styleFrom(
                      primary: kWhiteColor,
                      elevation: 2,
                      backgroundColor: kPrimaryColor,
                    ),
                    onPressed: () async =>  Navigator.of(context).push(
                      MaterialPageRoute(
                        //builder: (context) => DeliveryAddress(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                    width:5
                ),
              ],
            ),
          ],
        ),
      ),
    ),

    body: ReorderableListView.builder(
      itemCount: widget.memberList.length,
        //itemCount:3,
      onReorder: (oldIndex, newIndex) => setState(() {
        final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

        final temp = widget.memberList.removeAt(oldIndex);
        widget.memberList.insert(index, temp);
      }),
      itemBuilder: (context, index) {
        //final user = farms[index];
        //print(widget.memberList);
        return buidFarmList(index, widget.memberList);
      },
    ),
  );

}