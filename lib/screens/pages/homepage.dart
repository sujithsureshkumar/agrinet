import 'package:flutter/material.dart';
import 'package:AgriNet/providers/product_provider.dart';
import 'package:AgriNet/providers/category_provider.dart';
import 'package:AgriNet/models/categoryicon.dart';
import 'package:AgriNet/models/product.dart';
import 'package:provider/provider.dart';
import 'package:AgriNet/screens/pages/listproduct.dart';
import 'package:AgriNet/screens/pages/detailscreen.dart';
import 'package:AgriNet/widget/singleproduct.dart';
import 'package:carousel_pro/carousel_pro.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//Product menData;
CategoryProvider categoryProvider;
ProductProvider productProvider;

//Product womenData;

//Product bulbData;

//Product smartPhoneData;

class _HomePageState extends State<HomePage> {

  Widget _buildCategoryProduct({String image, int color}) {
    return CircleAvatar(
      maxRadius: height * 0.1 / 2.1,
      backgroundColor: Color(color),
      child: Container(
        height: 40,
        child:
        Image.network(image),
        ),
    );
  }

  double height, width;
  bool homeColor = true;

  bool checkoutColor = false;

  bool aboutColor = false;

  bool contactUsColor = false;
  bool profileColor = false;
  MediaQueryData mediaQuery;

  Widget _buildDressIcon() {
    List<CategoryIcon> dressIcon = categoryProvider.getDressIcon;
    List<Product> dress = categoryProvider.getDressList;
    return Row(
        children: dressIcon.map((e) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => ListProduct(
                    name: "Dress",
                    snapShot: dress,
                  ),
                ),
              );
            },
            child: _buildCategoryProduct(image: e.image, color: 0xff33dcfd),
          );
        }).toList());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        Container(
          height: height * 0.1 - 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Categorie",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            children: <Widget>[
              _buildDressIcon(),
              //_buildShirtIcon(),
             // _buildShoeIcon(),
             // _buildPantIcon(),
             // _buildTieIcon(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeature() {
    List<Product> featureProduct;

    featureProduct = productProvider.getFeatureList;

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Featured",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => ListProduct(
                      name: "Featured",
                      isCategory: false,
                      snapShot: featureProduct,
                    ),
                  ),
                );
              },
              child: Text(
                "View more",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          children: productProvider.getHomeFeatureList.map((e) {
            return Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => DetailScreen(
                              image: e.image,
                              price: e.price,
                              name: e.name,
                            ),
                          ),
                        );
                      },
                      child: SingleProduct(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => DetailScreen(
                              image: e.image, price: e.price, name: e.name),
                        ),
                      );
                    },
                    child: SingleProduct(
                      image: e.image,
                      price: e.price,
                      name: e.name,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImageSlider() {
    return Container(
      height: height * 0.3,
      child: Carousel(
        autoplay: true,
        showIndicator: false,
        images: [
          AssetImage("images/man.jpg"),
          AssetImage("images/women.jpg"),
          AssetImage("images/camera.jpg"),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  void getCallAllFunction() {
    //CategoryProvider.getShirtData();
    categoryProvider.getDressData();
    //categoryProvider.getShoesData();
    //categoryProvider.getPantData();
   // categoryProvider.getTieData();
    //categoryProvider.getDressIconData();
    productProvider.getNewAchiveData();
    productProvider.getFeatureData();
    productProvider.getHomeFeatureData();
    productProvider.getHomeAchiveData();
    //categoryProvider.getShirtIcon();
    //categoryProvider.getshoesIconData();
    //categoryProvider.getPantIconData();
    //categoryProvider.getTieIconData();
    //productProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    getCallAllFunction();
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _key,
      //drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          "HomePage",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              _key.currentState.openDrawer();
            }),
        actions: <Widget>[
          //NotificationButton(),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildImageSlider(),
                  _buildCategory(),
                  SizedBox(
                    height: 20,
                  ),
                  //_buildFeature(),
                  //_buildNewAchives()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}