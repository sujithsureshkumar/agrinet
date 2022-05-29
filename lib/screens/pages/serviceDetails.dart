import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/reviewModal.dart';
import 'package:AgriNet/models/service.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/services_provider.dart';
import 'package:AgriNet/screens/pages/dateFarmSelection.dart';
import 'package:AgriNet/screens/pages/reviews.dart';
import 'package:AgriNet/screens/pages/serviceProviderDetails.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/defaultBackButton.dart';
import 'package:AgriNet/widget/likeButtonWidget.dart';
import 'package:AgriNet/widget/recommendedItems.dart';
import 'package:AgriNet/widget/recommendedView.dart';
import 'package:AgriNet/widget/reviewEditUI.dart';
import 'package:AgriNet/widget/reviewUI.dart';
import 'package:AgriNet/widget/stickyLabel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceDetails extends StatefulWidget {
  final Service service;
  final Users user;

  ServiceDetails({Key key,@required this.service,
    @required this.user,}) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  bool isMore = false;


  List<String> productSize = ["S", "M", "L", "XL"];

  List<Color> productColors = [
    kPrimaryColor,
    kDarkColor,
    Colors.orange,
    Colors.green
  ];

  List<String> detailImages = [
    "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
    "https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
    "ahttps://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/folderName%2FimageName?alt=media&token=77b4fba1-5afd-4c85-a86a-d4c44f3f0ecf",
  ];




  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    ServicesProvider servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    servicesProvider.getReview(widget.service.docid);
    servicesProvider.editReviewShow=widget.service.reviewList.contains(user.uid);
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: "Service Details",
      ),
      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 8.0, left: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor, width: 2.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.phone, color: kPrimaryColor),
                  onPressed: () async {
                    String telephoneNumber = widget.service.phone_number;
                    String telephoneUrl = "tel:$telephoneNumber";
                    launchUrl (Uri.parse(telephoneUrl));
                  },
                ),
              ),
             /* Container(
                margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: kPrimaryColor, width: 2.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.chat, color: kPrimaryColor),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      //builder: (context) => Message(),
                    ),
                  ),
                ),
              ),*/
              Expanded(
                child: Container(
                  height: 52.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: kPrimaryColor, width: 2.0),
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: kLessPadding),
                    color: kPrimaryColor,
                    textColor: kWhiteColor,
                    child: Text("Proceed", style: TextStyle(fontSize: 18.0)),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DateFarmSelection(
                          service:widget.service,
                          user: widget.user,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 250.0,
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    //itemCount: detailImages.length,
                      itemCount:widget.service.imageUrl.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        //detailImages[index],
                        widget.service.imageUrl[index],
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      detailImages.length,
                          (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        height: 8.0,
                        width: currentIndex == index ? 24.0 : 8.0,
                        margin: EdgeInsets.only(right: 4.0),
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? kPrimaryColor
                              : kLightColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StickyLabel(text: widget.service.name),
            Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Row(
                children: [
                  Text(
                    "\$ ${widget.service.price}",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 240,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: LikeButtonWidget(isLiked:widget.service.isLiked,
                        likeCount:widget.service.likeCount,
                        docid:widget.service.docid,
                        userid: widget.user.uid,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(22.0)),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "8.9",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 18.0,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.top,
                            child: Icon(
                              Icons.star,
                              size: 18.0,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      //"${826} Requests",
                      '',
                      style: TextStyle(
                        color: kDarkColor.withOpacity(0.4),
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kLessPadding),
            kSmallDivider,
            // for shirt or Other Products who has the Size
            Padding(
              padding: EdgeInsets.fromLTRB(kDefaultPadding,20,0,0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ServiceProviderDetails(
                        service: widget.service,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      widget.service.spName,
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon( Icons.link, ),

                    Text(
                      "Click here for service Provider Details",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.amberAccent
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 44.0,
              margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kLessPadding),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.pink,
                    size: 14.0,
                  ),
                  Expanded(
                    child: Text(
                      "Thalapuzha, Manandavady,wayanad",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.normal,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kSmallDivider,
            // for shirt or Other Products who has the Colors
            Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                "Machine details",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Container(
              height: 44.0,
              margin: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: kLessPadding),
              child: Text(
                //"Tracter,Harvesting Machine",
                widget.service.equipmentDetail,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            kSmallDivider,
            Padding(
              padding: EdgeInsets.only(left: kDefaultPadding),
              child: Text(
                "Desciption",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kLessPadding),
              child: isMore
                  ? Text(
                widget.service.description,
                style: kSubTextStyle,
              )
                  : Text(
                widget.service.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: kSubTextStyle,
              ),
            ),
            GestureDetector(
              onTap: () => setState(() {
                isMore = !isMore;
              }),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: kDefaultPadding),
                  child: Text(
                    isMore ? "View Less" : "View More",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: kLessPadding),
            kSmallDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StickyLabel(text: "Review"),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Reviews(),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child:
                    StickyLabel(text: "View All", textColor: kPrimaryColor),
                  ),
                ),
              ],
            ),

            Consumer<ServicesProvider>(
                 builder: (context, servicesProvider, _) {
                   return servicesProvider.reviewList==[] ?SizedBox(height: kLessPadding)
                       :ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                      itemCount: servicesProvider.reviewList.length,
                        //itemCount:1,
                      itemBuilder: (context, index) {
                        return ReviewUI(
                          serviceReview:servicesProvider.reviewList[index],
                          onPressed: () => print("More Action $index"),
                          onTap: () => setState(() {
                            isMore = !isMore;
                          }),
                          isLess: isMore,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2.0,
                          color: kAccentColor,
                        );
                      },
                    );
                 }
               ),

            kSmallDivider,
            Consumer<ServicesProvider>(
                builder: (context, servicesProvider, _) {
                return
                  servicesProvider.editReviewShow?
                Container():ReviewEditUI(service: widget.service,);
              }
            ),
            kSmallDivider,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StickyLabel(text: "Top Related Services"),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      //builder: (context) => Products(true),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child:
                    StickyLabel(text: "View All", textColor: kPrimaryColor),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: RecommendedView(
                direction: Axis.horizontal,
                heights: 250.0,
                widths: MediaQuery.of(context).size.width,
                top: 0.0,
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                column: 1,
                ratio: 1.8,
                items: 6,
                itemBuilder: (context, index) {
                  return RecommendedItems(
                    height: 150.0,
                    radius: 8.0,
                    top: 8.0,
                    bottom: 8.0,
                    left: 4.0,
                    right: 4.0,
                    image: recommendedList[index].image,
                    title: recommendedList[index].title,
                    price: recommendedList[index].price,
                    rating: recommendedList[index].rating,
                    sale: recommendedList[index].sale,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}