import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/farm.dart';
import 'package:AgriNet/screens/group_chats/group_chat_screen.dart';
import 'package:AgriNet/screens/pages/success.dart';
import 'package:AgriNet/services/firebase_api_methods.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'dart:math' show cos, sqrt, asin;

import 'bookingListing.dart';

class FarmArrangingNew extends StatefulWidget {
  final List memberList;
  final String groupId;
  String farmScore;
  FarmArrangingNew({this.memberList, this.groupId, this.farmScore, Key key})
      : super(key: key);
  @override
  _FarmArrangingNewState createState() => _FarmArrangingNewState();
}

class _FarmArrangingNewState extends State<FarmArrangingNew> {
  @override
  void initState() {
    super.initState();
  }

  double totalDistance = 0, farmScore = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }

  void distanceCalculator() {
    totalDistance = 0;
    for (var i = 0; i < widget.memberList.length - 1; i++) {
      totalDistance += calculateDistance(
          widget.memberList[i]['location'].latitude,
          widget.memberList[i]['location'].longitude,
          widget.memberList[i + 1]['location'].latitude,
          widget.memberList[i + 1]['location'].longitude);
    }
    print(totalDistance);
    farmScore = widget.memberList.length / totalDistance;
    setState(() {
      widget.farmScore = farmScore.toStringAsFixed(2);
    });
  }

  int farmAttachCount(List farmList) {
    int count = 0;
    for (var i = 0; i < farmList.length; i++) {
      if (farmList[i]['isFarmSet']) {
        count++;
      }
    }
    return count;
  }

  snackBarMsg(BuildContext context, String msg) {
    final now = DateTime.now();

    var sb = SnackBar(
      elevation: kRadius,
      content: Text(msg + now.microsecondsSinceEpoch.toString()),
      backgroundColor: kAccentColor,
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        textColor: kWhiteColor,
        label: 'OK',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(sb);
  }

  Widget buidFarmList(int index, List farmList) {
    return Padding(
      key: ValueKey(farmList[index]),
      padding: EdgeInsets.only(top: 10.0, left: 10, right: 10),
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
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Row(
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
                              color: Colors.amber,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          farmList[index]['name'],
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Text(
                                "From",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.expand_less,
                              ),
                              Text(
                                //farmList[index]['location'].latitude.toString(),
                                calculateDistance(
                                            farmList[index]['location']
                                                .latitude,
                                            farmList[index]['location']
                                                .longitude,
                                            farmList[(index + 1) %
                                                    farmList.length]['location']
                                                .latitude,
                                            farmList[(index + 1) %
                                                    farmList.length]['location']
                                                .longitude)
                                        .toStringAsFixed(2) +
                                    " KM",
                                style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.expand_more,
                              ),
                              Text(
                                "To",
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      //width: 10.0,
                      height: 30,
                    ),
                  ],
                ))),
      ),
    );
  }

  Widget textField(String name) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.95,
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
        border: Border(
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "Farm Arranging"),
      bottomNavigationBar: BottomAppBar(
        elevation: kLess,
        color: kWhiteColor,
        child: Container(
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textField("Total Distance:" +
                      totalDistance.toStringAsFixed(2) +
                      "KM"),
                )
              ]),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textField("Farm Score:" + widget.farmScore),
                )
              ]),
              Row(
                children: [
                  SizedBox(width: 5),
                  Expanded(
                    child: TextButton(
                      //padding: EdgeInsets.symmetric(vertical: kLessPadding),
                      //color: kPrimaryColor,
                      //textColor: kWhiteColor,
                      child:
                          Text("Calculate", style: TextStyle(fontSize: 18.0)),
                      style: TextButton.styleFrom(
                          primary: kWhiteColor,
                          elevation: 2,
                          backgroundColor: kLightColor),
                      onPressed: () => setState(() {
                        distanceCalculator();
                      }),
                    ),
                  ),
                  SizedBox(width: 10),
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
                        onPressed: () async {
                          if (farmAttachCount(widget.memberList) ==
                              widget.memberList.length) {
                            updateFarmScore(widget.groupId,
                                    farmScore.toStringAsFixed(0))
                                .then(
                              (value) =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => Success(
                                  onPressed: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (ctx) =>
                                              GroupChatHomeScreen())),
                                  emptyMsg: "Successful ",
                                  subTitleText:
                                      'Your Farm Score updated Successfuly ',
                                ),
                              )),
                            );
                          }
                        }

                        /*   Navigator.of(context).push(
                      MaterialPageRoute(
                        //builder: (context) => DeliveryAddress(),
                      ),
                    ),*/
                        ),
                  ),
                  SizedBox(width: 5),
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
}
