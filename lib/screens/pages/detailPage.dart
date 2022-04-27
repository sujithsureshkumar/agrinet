import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../methods/custom_functions.dart';
import '../../methods/widget_functions.dart';
import '../../widget/BorderIcon.dart';
import '../../widget/OptionButton.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  DetailPage({Key key,
    @required this.image,
    @required this.name,
    @required this.price}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_WHITE,
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        //Image.asset(itemData["image"]),
                        Image.network(widget.image),
                        Positioned(
                          width: size.width,
                          top: padding,
                          child: Padding(
                            padding: sidePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(Icons.keyboard_backspace,color: COLOR_BLACK,),
                                  ),
                                ),
                                BorderIcon(
                                  height: 50,
                                  width: 50,
                                  child: Icon(Icons.favorite_border,color: COLOR_BLACK,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${formatCurrency(int.parse(widget.price))}",
                                style: themeData.textTheme.headline4,),
                              addVerticalSpace(5),
                              Text("\"address",style: themeData.textTheme.subtitle2,),
                            ],
                          ),
                          BorderIcon(child: Text("20 Hours ago",
                            style: themeData.textTheme.headline6,),
                            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),)
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text("House Information",style: themeData.textTheme.headline6,),
                    ),
                    addVerticalSpace(padding),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InformationTile(content: "area",name: "Square Foot",),
                          InformationTile(content: "bedrooms",name: "Bedrooms",),
                          InformationTile(content: "bathrooms",name: "Bathrooms",),
                          InformationTile(content: "garage",name: "Garage",)
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text("description"
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    ),
                    addVerticalSpace(100),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionButton(text: "Message",icon: Icons.message,width: size.width*0.35,),
                    addHorizontalSpace(10),
                    OptionButton(text: "Call",icon: Icons.call,width: size.width*0.35,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InformationTile extends StatelessWidget{

  final String content;
  final String name;

  const InformationTile({Key key,@required this.content,@required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width*0.30;
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              width: tileSize,
              height: size.width*0.15,
              child: Text(content,style: themeData.textTheme.headline6,)),
          addVerticalSpace(15),
          Text(name,style: themeData.textTheme.headline6,)
        ],
      ),
    );

  }

}