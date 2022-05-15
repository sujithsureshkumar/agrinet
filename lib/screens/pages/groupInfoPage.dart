import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/screens/group_chats/add_members.dart';
import 'package:AgriNet/screens/group_chats/group_chat_room.dart';
import 'package:AgriNet/screens/group_chats/group_chat_screen.dart';
import 'package:AgriNet/screens/pages/farmArrrangingNew.dart';
import 'package:AgriNet/screens/pages/farmAttachPage.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:AgriNet/widget/stickyLabel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupInfoPage extends StatefulWidget {
  final String groupId, groupName,myFarmName,category,subCategory;
  final bool isFarmSet;
  GroupInfoPage({
    this.groupId,
    this.groupName,
    this.myFarmName,
    this.category,
    this.subCategory,
    this.isFarmSet,
    Key key}) : super(key: key);

  @override
  _GroupInfoPageState createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
  List membersList = [];
  bool isLoading = true;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    getGroupDetails();
  }

  Future getGroupDetails() async {
    await _firestore
        .collection('groups')
        .doc(widget.groupId)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      print(membersList);
      isLoading = false;
      setState(() {});
    });
  }

  bool checkAdmin() {
    bool isAdmin = false;

    membersList.forEach((element) {
      if (element['uid'] == _auth.currentUser.uid) {
        isAdmin = element['isAdmin'];
      }
    });
    return isAdmin;
  }

  Future onLeaveGroup() async {
    if (!checkAdmin()) {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < membersList.length; i++) {
        if (membersList[i]['uid'] == _auth.currentUser.uid) {
          membersList.removeAt(i);
        }
      }

      await _firestore.collection('groups').doc(widget.groupId).update({
        "members": membersList,
      });

      await _firestore
          .collection('users')
          .doc(_auth.currentUser.uid)
          .collection('groups')
          .doc(widget.groupId)
          .delete();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => GroupChatHomeScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
          body:isLoading
              ? Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 250.0,
                      child: Image(
                        image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/agrinet-66009.appspot.com/o/Required%20files%2FbannerImage.jpg?alt=media&token=4f72866b-917a-4d3f-aecd-c991fc13e666"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top:0.0,
                      left: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BackButton(),
                      ),
                    ),
                    Positioned(
                      bottom: -60.0,
                      child: Container(
                        height: 125.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(
                            color: kWhiteColor,
                            width: kLess,
                          ),
                          image: DecorationImage(
                            image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-sa_II3GuTyXT0EGyW7sKvep9GTL1lmIZW2RjO98L8DgGeZ4iD4ussfCcQgW22FiFnMo&usqp=CAU"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -88.0,
                      child: Text(
                        widget.groupName,
                        style: kDarkTextStyle,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(top: 108.0,left: 10,right: 10),
                  child: Card(
                      //elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child:Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (ctx) => FarmAttachPage(
                                          category: widget.category,
                                          subCategory:widget.subCategory ,
                                          groupId: widget.groupId,
                                          memberList:membersList,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "My Farm",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget.myFarmName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Icon( Icons.chevron_right, ))
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: widget.isFarmSet?Text(
                                          "Attached",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ):Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>  GroupChatRoom(
                            groupName: widget.groupName,
                            groupChatId: widget.groupId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      //elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child:Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  //width: 10.0,
                                  height: 30,
                                ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
                                      child: Icon( Icons.chat, ),
                                    ),
                                    Text(
                                      "Chat",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                     Expanded(
                                       child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon( Icons.chevron_right, )),
                                     ),
                                    



                                SizedBox(
                                  //width: 10.0,
                                  height: 30,
                                ),

                              ],
                            )
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => FarmArrangingNew(
                            memberList:membersList,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      //elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child:Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                            child:Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  //width: 10.0,
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
                                  child: Icon( Icons.chat, ),
                                ),
                                Text(
                                  "Chat",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon( Icons.chevron_right, )),
                                ),




                                SizedBox(
                                  //width: 10.0,
                                  height: 30,
                                ),

                              ],
                            )
                        )
                    ),
                  ),
                ),
                StickyLabel(text: "Members"),

                checkAdmin()
                    ? ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddMembersINGroup(
                        groupChatId: widget.groupId,
                        name: widget.groupName,
                        membersList: membersList,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.add,
                  ),
                  title: Text(
                    "Add Members",
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : SizedBox(),

                Flexible(
                  child: ListView.builder(
                    itemCount: membersList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        //onTap: () => showDialogBox(index),
                        leading: Icon(Icons.account_circle),
                        title: Text(
                          membersList[index]['name'],
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(membersList[index]['email']),
                        trailing: Text(membersList[index]['isAdmin'] ? "Admin" : ""),
                      );
                    },
                  ),
                ),

                ListTile(
                  onTap: onLeaveGroup,
                  leading: Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    "Leave Group",
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                ],
          ),
          ),
      ),
    );
  }
}