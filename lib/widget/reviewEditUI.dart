import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/reviewModal.dart';
import 'package:AgriNet/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewEditUI extends StatefulWidget {
  //final String image, name, date, comment;
  //final double rating;
  final Function onTap;
  const ReviewEditUI({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  State<ReviewEditUI> createState() => _ReviewEditUIState();
}

class _ReviewEditUIState extends State<ReviewEditUI> {

  double ratingValue;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _comment= TextEditingController();

  Widget commentTextField() {
    return TextFormField(
      controller: _comment,
      validator: (value) {
        if (value.isEmpty) return "Write review here";
        return null;
      },
      maxLines: 4,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
        labelText: "Comment",

      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalkey,
      child: Container(
        padding: EdgeInsets.only(
          top: 2.0,
          bottom: 2.0,
          left: 16.0,
          right: 0.0,
        ),
        child: SizedBox(
          height: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Rate this Service",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              SmoothStarRating(
                starCount: 5,
                rating: 0,
                size: 28.0,
                color: Colors.orange,
                borderColor: Colors.orange,
                onRated: (double value){
                  ratingValue=value;
                },
              ),
              SizedBox(height: 8.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: commentTextField(),
              ),

              SizedBox(height: 8.0),
              MyButton(
                name: "Post",
                onPressed: () {
              if (_globalkey.currentState.validate() && ratingValue>0) {
                        print("validation ready");
              }
                },
                ratio:0.9,
                color: Colors.lightGreen,
                ),
              /*GestureDetector(
                onTap: onTap,
                child:Text(
                  "Write a review",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: kLightColor,
                  ),
                ),
              ),*/

            ],
          ),
        ),
      ),
    );
  }
}