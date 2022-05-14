
import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/screens/pages/groupInfoPage.dart';
import 'package:AgriNet/screens/pages/home.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'group_chat_room.dart';
import 'group_chats/add_members.dart';


class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];

  @override
  void initState() {
    super.initState();
    getAvailableGroups();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: DefaultAppBar(
        title: "Groups",
          child:IconButton(
            icon: Icon(Icons.arrow_back_ios, color: kPrimaryColor),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => Home(),
              ),
            ),
          )
      ),
      body: isLoading
          ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: groupList.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => GroupInfoPage(
                  groupName: groupList[index]['name'],
                  //groupChatId: groupList[index]['id'],
                  groupId: groupList[index]['id'],
                  myFarmName: groupList[index]['myFarm'],
                  category: groupList[index]['category'],
                  subCategory:groupList[index]['subcategory'] ,
                  isFarmSet: groupList[index]['isFarmSet'] ,
                ),
              ),
            ),
            leading: Icon(Icons.group),
            title: Text(groupList[index]['name']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor:Color(0xffa694a7),
        child: Icon(Icons.create),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AddMembersInGroup(),
          ),
        ),
        tooltip: "Create Group",
      ),
    );
  }
}