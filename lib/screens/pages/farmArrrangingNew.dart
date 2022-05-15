import 'package:AgriNet/models/farm.dart';
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

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
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
                      //width: 10.0,
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
                      child: Icon( Icons.chat, ),
                    ),
                    Text(
                      farmList[index]['name'],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              Icon( Icons.expand_less, ),

                              Text(
                                farmList[index]['location'].latitude.toString(),
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

  @override
  Widget build(BuildContext context) => Scaffold(
  appBar: AppBar(
  title: Text('Farm Arranging'),
  centerTitle: true,
  ),


    body: ReorderableListView.builder(
      itemCount: widget.memberList.length,
      onReorder: (oldIndex, newIndex) => setState(() {
        final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

        final temp = widget.memberList.removeAt(oldIndex);
        widget.memberList.insert(index, temp);
      }),
      itemBuilder: (context, index) {
        //final user = farms[index];

        return buidFarmList(index, widget.memberList);
      },
    ),
  );

}