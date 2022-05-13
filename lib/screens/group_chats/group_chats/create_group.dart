
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../group_chat_screen.dart';


class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;

  const CreateGroup({this.membersList, Key key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool textBoxShow=false;
  final _globalkey = GlobalKey<FormState>();

  checkUsernameIsUnique(String name)async
  {
    QuerySnapshot querySnapshot;
    /* setState(() {
      loading=true;
    });*/
    querySnapshot=await FirebaseFirestore.instance
        .collection('groups')
        .where("name",isEqualTo: name)
        .get();
    print(querySnapshot.docs.isNotEmpty);
    return querySnapshot.docs.isEmpty;
  }

  void createGroup() async {

    if (_globalkey.currentState.validate()) {
      checkUsernameIsUnique(_groupName.text).then((val) async {
        if(val)
        {

          setState(() {
            isLoading = true;
          });
          String groupId = Uuid().v1();

          await _firestore.collection('groups').doc(groupId).set({
            "members": widget.membersList,
            "id": groupId,
            "name": _groupName.text,
            'farmSetCount':0,
          });

          for (int i = 0; i < widget.membersList.length; i++) {
            String uid = widget.membersList[i]['uid'];

            await _firestore
                .collection('users')
                .doc(uid)
                .collection('groups')
                .doc(groupId)
                .set({
              "name": _groupName.text,
              "id": groupId,
              'category': categoryValue,
              'subcategory': subCategoryValue,
              'myFarm':'No farm attached',
              'myFarmId':'',
              'isFarmSet':false,
            });
          }

          await _firestore.collection('groups').doc(groupId).collection('chats').add({
            "message": "${_auth.currentUser.displayName} Created This Group.",
            "type": "notify",
          });

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => GroupChatHomeScreen()), (route) => false);

        }
        else{
          setState(() {
            textBoxShow = true;
          });
        }
//username is taken
      });
    }

  }

  Widget nameTextField() {
    return TextFormField(
      controller: _groupName,
      validator: (value) {
        if (value.isEmpty) return "Name can't be empty";

        return null;
      },
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
        // prefixIcon: Icon(
        //   Icons.agriculture,
        //   color: Colors.green,
        // ),
        labelText: "Farm Name",
        helperText: "Name can't be empty",
        hintText: "Enter Group Name",
      ),
    );
  }

  Widget categoryTextField() {
    return DropdownButtonFormField(
      value: categoryValue,
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
        prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          categoryValue = newValue;
          _newGetList();
        });
      },
      items: catList
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget subCategoryTextField() {
    return DropdownButtonFormField(
      value: subCategoryValue,
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
        prefixIcon: Icon(
          Icons.category,
          color: Colors.green,
        ),
      ),
      icon: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(Icons.keyboard_arrow_down)),
      style: const TextStyle(color: Colors.teal, fontSize: 16),
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          subCategoryValue = newValue;
        });
      },
      items: subCategory?.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })?.toList(),
    );
  }

  @override
  void initState () {
    super.initState();
    _asyncMethod();
  }
  List<String> catList=[];
  Map<String, dynamic> CategoryList;
  String categoryValue = '';
  String subCategoryValue;
  List<String> subCategory;
  List<String> _tempList=[];
  _asyncMethod() async {
    DocumentSnapshot categorySnapShot =
    await FirebaseFirestore.instance
        .collection('Category')
        .doc('category')
        .get();

    CategoryList = (categorySnapShot.data()as Map<String, dynamic>)['category'];

    catList = CategoryList.keys.toList();
    categoryValue = catList[0];
    print(CategoryList);
    print(catList);

    setState((){});
  }

  _newGetList() async {
    _tempList=[];
    CategoryList[categoryValue].forEach((result){
      _tempList.add(result);
    });
    setState(() {
      subCategory=_tempList;
      subCategoryValue=null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Group Name"),
      ),
      body: isLoading
          ? Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
          : Form(
          key: _globalkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
        children: [
          textBoxShow?SizedBox(
            height: 20,
            child:Text("This name is already exist"),
          ): SizedBox(
            height: 20,
          ),
              nameTextField(),
              SizedBox(
                height: size.height / 50,
              ),
               categoryTextField(),
               SizedBox(
                  height: size.height / 50,
                ),
              subCategoryTextField(),
              SizedBox(
                  height: size.height / 50,
               ),
              ElevatedButton(
                onPressed: createGroup,
                child: Text("Create Group"),
              ),
        ],
      ),
            ),
          ),
    );
  }
}


//