import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatefulWidget {
  bool isLiked;
  int likeCount;
  String docid;
  String userid;
  LikeButtonWidget({this.isLiked, this.likeCount,this.docid,this.userid});
  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget > {
  //bool isLiked =false;
  //int likeCount=333;
  Future<bool> onLikeButtonTapped(bool isLiked) async{
    widget.isLiked=!widget.isLiked;
    //widget.likeCount += widget.isLiked ? 1 : -1;

    // Create a reference to the document the transaction will use
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('services')
        .doc(widget.docid);

    DocumentReference documentReferenceForUser=FirebaseFirestore.instance
        .collection('farmUser')
        .doc(widget.userid);

     FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
     DocumentSnapshot snapshot = await transaction.get(documentReference);


       DocumentSnapshot snapshotForUser =  await transaction.get(documentReferenceForUser);
        var doc = (snapshotForUser.data()as Map<String, dynamic>);
        if (doc['wishlist'].contains(widget.docid)) {
        await transaction.update(snapshotForUser.reference, <String, dynamic>{
         'wishlist': FieldValue.arrayRemove([widget.docid])
          });
      } else {
          await transaction.update(snapshotForUser.reference, <String, dynamic>{
            'wishlist': FieldValue.arrayUnion([widget.docid])
          });
        }

     // if (!snapshot.exists) {throw Exception("User does not exist!");}

      // Update the follower count based on the current count
      // Note: this could be done without a transaction
      // by updating the population using FieldValue.increment()
      int inc =widget.isLiked ? 1 : -1;
      int newCount = (snapshot.data()as Map<String, dynamic>)['likecount'] + inc;

      // Perform an update on the document
      transaction.update(documentReference, {'likecount': newCount});

      // Return the new count
      //return newFollowerCount;
    })
        .then((value) {
          print("count updated to $value");
          widget.likeCount += widget.isLiked ? 1 : -1;
        })
        .catchError((error) => print("Failed to update count: $error"));

    return !isLiked;
    /// send your request here
    // final bool success= await sendRequest();

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;


    //return !isLiked;
  }
  @override
  Widget build(BuildContext context) {
    final double buttonSize =30;
    return LikeButton(
      size: buttonSize,
      //circleColor:
      //CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      //bubblesColor: BubblesColor(dotPrimaryColor: Color(0xff33b5e5),dotSecondaryColor: Color(0xff0099cc),),
      isLiked: widget.isLiked,
      likeBuilder: (isLiked) {
        return Icon(
          Icons.favorite,
          color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
          size: buttonSize,
        );
      },
      likeCount: widget.likeCount,
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
                fontSize: 10,
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