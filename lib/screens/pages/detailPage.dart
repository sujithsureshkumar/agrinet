import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/widget/likeButtonWidget.dart';
import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../../methods/custom_functions.dart';
import '../../methods/widget_functions.dart';
import '../../models/users.dart';
import '../../widget/BorderIcon.dart';
import '../../widget/OptionButton.dart';
import 'delivery.dart';

class DetailPage extends StatefulWidget {
  final Service service;
  final Users user;

  DetailPage({Key key,@required this.service,
  @required this.user,}) : super(key: key);

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
                        Image.network(widget.service.imageUrl[0]),
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
                                  width: 60,
                                  child: LikeButtonWidget(isLiked:widget.service.isLiked,
                                    likeCount:widget.service.likeCount,
                                    docid:widget.service.docid,
                                    userid: widget.user.uid,
                                  ),
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
                              Text("${formatCurrency(int.parse(widget.service.price))}",
                                style: themeData.textTheme.headline4,),
                              addVerticalSpace(5),
                              Text("\address",style: themeData.textTheme.subtitle2,),
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
                      child: Text("Service Information",style: themeData.textTheme.headline6,),
                    ),
                    addVerticalSpace(padding),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InformationTile(content: "Abc service",name: "Service Provider",),
                          InformationTile(content: "Thalapuzha",name: "location",),
                          InformationTile(content: "Tracter",name: "Machines",),
                          InformationTile(content: "harvester",name: "Machine",)
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
                    OptionButton(
                      text: "Message",
                      icon: Icons.message,width: size.width*0.35,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => Delivery(),
                          ),
                        );
                      },
                    ),
                    addHorizontalSpace(10),
                    OptionButton(
                      text: "Proceed",
                      icon: Icons.arrow_forward,
                      width: size.width*0.35,
                      onPressed: () {
                    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                    builder: (ctx) => Delivery(),
                    ),
                    );
                    },
                    ),
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