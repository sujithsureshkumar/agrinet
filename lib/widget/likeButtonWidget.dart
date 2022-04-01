import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget > {
 bool isLiked =false;
 int likeCount=333;
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    this.isLiked=!this.isLiked;
    likeCount += this.isLiked ? 1 : -1;
    return !isLiked;
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;


    return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    final double buttonSize =40;
    return LikeButton(
      size: buttonSize,
      //circleColor:
      //CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      //bubblesColor: BubblesColor(dotPrimaryColor: Color(0xff33b5e5),dotSecondaryColor: Color(0xff0099cc),),
      isLiked: isLiked,
      likeBuilder: (isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
          size: buttonSize,
        );
      },
      likeCount: likeCount,
      countBuilder: (int count, bool isLiked, String text) {
        var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "love",
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            text,
            style: TextStyle(color: color,
            fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          );
        return result;
      },
        onTap:onLikeButtonTapped,
     /* onTap:(isLiked) async{
        this.isLiked=!this.isLiked;
        likeCount += this.isLiked ? 1 : -1;
        return !isLiked;
      }*/
    );
  }
}