import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/widget/mybutton.dart';

import '../../imageTesting/homepage.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String name;
  final int price;
  DetailScreen({required this.image, required this.name, required this.price});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int count = 1;
  // ProductProvider productProvider;
  late UsersProvider usersProvider;

  Widget _buildColorProduct({required Color color}) {
    return Container(
      height: 40,
      width: 40,
      color: color,
    );
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 380,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.image),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescriptionPart() {
    return Container(
      height: 100,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.name, style: myStyle),
              Text(
                "\$ ${widget.price.toString()}",
                style: TextStyle(
                    color: Color(0xff9b96d6),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text("Description", style: myStyle),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 170,
      child: Wrap(
        children: <Widget>[
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. ",
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }











  Widget _buildButtonPart() {
    return Container(
      height: 60,
      child: MyButton(
        name: "Add To Cart",
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => HomePage(),
            ),
          );
        },
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    //usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Detail Page", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Home(),
              ),
            );
          },
        ),
        actions: <Widget>[
          //NotificationButton(),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            _buildImage(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNameToDescriptionPart(),
                  _buildDiscription(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildButtonPart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}