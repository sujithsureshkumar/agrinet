import 'package:AgriNet/models/service.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/imageTesting/CarouselWithDotsPage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  List<String>? imgList;

  HomePage({this.imgList});



  @override
  _HomePageState createState() => _HomePageState();
}
final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
];





class _HomePageState extends State<HomePage> {
  int _current = 0;

  late Service imageData;
  List<String> imageList = [];

  Future<void> getImageUrl() async {
    List<String> newList = [];
    QuerySnapshot featureSnapShot =
    await FirebaseFirestore.instance.collection("services").get();
    featureSnapShot.docs.forEach(
          (element) {
        imageData = Service(
          imageUrl: List.from(element.get("image")),
          name: element.get("name"),
          price: element.get("price"),
           owner: element.get("name")
        );

        for(String i in imageData.imageUrl){
          print(i);
          newList.add(i);
        }
      },
    );
    imageList = newList;
    //print(imageList[0]);
  }



  @override
  Widget build(BuildContext context) {
    getImageUrl();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[700],
        title: Text("Carousel Example"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Carousel With Image",
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            CarouselSlider(
              items: imgList
                  .map((item) => Container(
                child: Center(
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
                ),
              ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CarouselWithDotsPage(imgList: imageList),
          ],
        ),
      ),
    );
  }
}