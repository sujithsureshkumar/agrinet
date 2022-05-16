import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMembersINGroup extends StatefulWidget {
  final String groupChatId, name;
  final List membersList;
  const AddMembersINGroup(
      {this.name,
        this.membersList,
        this.groupChatId,
        Key key})
      : super(key: key);

  @override
  _AddMembersINGroupState createState() => _AddMembersINGroupState();
}

class _AddMembersINGroupState extends State<AddMembersINGroup> {
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic> userMap;
  bool isLoading = false;
  bool isAlreadyExist = false;
  List membersList = [];
  //List<Map<String, dynamic>> membersList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    membersList = widget.membersList;
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot searchSnapShot =
    await _firestore
        .collection('search')
        .doc('searchdoc')
        .get();
    var emailList = (searchSnapShot.data()as Map<String, dynamic>)['email'];

    if (emailList.contains(_search.text)) {
      await _firestore
          .collection('users')
          .where("email", isEqualTo: _search.text)
          .get()
          .then((value) {
        setState(() {
          userMap = value.docs[0].data();
          isLoading = false;
        });
        print(userMap);
      });}else{
      setState(() {
        isLoading = false;
      });
    }
  }

  void onAddMembers() async {
    isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap['uid']) {
        isAlreadyExist = true;
      }
    }
    if (!isAlreadyExist) {

        membersList.add({
          "name": userMap['name'],
          "email": userMap['email'],
          "uid": userMap['uid'],
          "isAdmin": false,
          'myFarm':'No farm attached',
          'myFarmId':'',
          'isFarmSet':false,
          'location':GeoPoint(0,0),
        });

        await _firestore.collection('groups').doc(widget.groupChatId).update({
          "members": membersList,
        });

        await _firestore
            .collection('users')
            .doc(userMap['uid'])
            .collection('groups')
            .doc(widget.groupChatId)
            .set({
          "name": widget.name,
          "id": widget.groupChatId,
          'myFarm':'No farm attached',
          'myFarmId':'',
          'isFarmSet':false,

        });

    }
    setState(() {
    });


  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:DefaultAppBar(title: "Add Members"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            isAlreadyExist?SizedBox(
              height: 20,
              child:Text("This name is already exist"),
            ): SizedBox(
              height: 20,
            ),
            Container(
              height: size.height / 14,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 14,
                width: size.width / 1.15,
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: "Search",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 50,
            ),
            isLoading
                ? Container(
              height: size.height / 12,
              width: size.height / 12,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
                : ElevatedButton(
              onPressed: onSearch,
              child: Text("Search"),
            ),
            userMap != null
                ? ListTile(
              onTap: onAddMembers,
              leading: Icon(Icons.account_box),
              title: Text(userMap['name']),
              subtitle: Text(userMap['email']),
              trailing: Icon(Icons.add),
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}