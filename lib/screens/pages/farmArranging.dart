import 'package:AgriNet/models/farm.dart';
import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'dart:math' show cos, sqrt, asin;

class FarmArranging extends StatefulWidget {
  @override
  _FarmArrangingState createState() => _FarmArrangingState();
}

class _FarmArrangingState extends State<FarmArranging> {

  List<Farm> farms = [];

  List<dynamic> data = [
    {
      "lat": 44.968046,
      "lng": -94.420307
    },{
      "lat": 44.33328,
      "lng": -89.132008
    },
    {
      "lat": 44.33328,
      "lng": -89.132008
    },{
      "lat": 33.755787,
      "lng": -116.359998
    },{
      "lat": 33.844843,
      "lng": -116.54911
    },{
      "lat": 44.92057,
      "lng": -93.44786
    },{
      "lat": 44.240309,
      "lng": -91.493619
    },{
      "lat": 44.968041,
      "lng": -94.419696
    },{
      "lat": 44.333304,
      "lng": -89.132027
    },{
      "lat": 33.755783,
      "lng": -116.360066
    },{
      "lat": 33.844847,
      "lng": -116.549069
    },
  ];

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



    double totalDistance = 0;
    for(var i = 0; i < data.length-1; i++){
      totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);
    }
    print(totalDistance);
  }

  List<Farm> getUsers() => List.generate(
    5,
        (index) => Farm(
      name: faker.person.name(),
          lat: data[index]["lat"],
          long: data[index]["lng"],
    ),
  );

  @override
  void initState() {
    super.initState();

    farms = getUsers();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Farm Arranging'),
      centerTitle: true,
    ),
    body: ReorderableListView.builder(
      itemCount: farms.length,
      onReorder: (oldIndex, newIndex) => setState(() {
        final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

        final user = farms.removeAt(oldIndex);
        farms.insert(index, user);
      }),
      itemBuilder: (context, index) {
        final user = farms[index];

        return buildUser(index, user,farms);
      },
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.shuffle),
      onPressed: shuffleList,
    ),
  );

  Widget buildUser(int index, Farm farms,List<Farm> farmList) {
    return ListTile(
    key: ValueKey(farms),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    leading:Text(farms.name),
    title: Text(farms.name),
    trailing: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: Colors.black),
          //onPressed: () => edit(index),
            onPressed: () =>calculateDistance(
                farmList[index].lat, farmList[index].long, farmList[index+1].lat, farmList[index+1].long),
        ),
      ],
    ),
  );
  }

  void remove(int index) => setState(() => farms.removeAt(index));

  void edit(int index) => showDialog(
    context: context,
    builder: (context) {
      final user = farms[index];

      return AlertDialog(
        content: TextFormField(
          initialValue: user.name,
          onFieldSubmitted: (_) => Navigator.of(context).pop(),
          onChanged: (name) => setState(() => user.name = name),
        ),
      );
    },
  );

  void shuffleList() => setState(() => farms.shuffle());
}