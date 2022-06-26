import 'package:AgriNet/constants/constant.dart';
import 'package:AgriNet/models/users.dart';
import 'package:AgriNet/providers/farm_provider.dart';
import 'package:AgriNet/widget/defaultAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FarmAttachPage extends StatefulWidget {
  final String category,subCategory,groupId;
  final List memberList;
  FarmAttachPage({this.category,this.subCategory,this.groupId,this.memberList,Key key}) : super(key: key);

  @override
  _FarmAttachPageState createState() => _FarmAttachPageState();
}

class _FarmAttachPageState extends State<FarmAttachPage> {
  final _globalkey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _dropdownvalue;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    FarmProvider farmProvider = Provider.of<FarmProvider>(context, listen: false);
    farmProvider.fetchUserFarmWithInfo(user.uid,widget.subCategory);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(title: "Attach Farm"),
      bottomNavigationBar: Material(
        elevation: kLess,
        color: kWhiteColor,
        child:Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child:TextButton(
            child: Text("Attach Farm", style: TextStyle(fontSize: 18.0)),
            style: TextButton.styleFrom(
                primary: kWhiteColor,
                elevation: 2,
                backgroundColor: kPrimaryColor),
            onPressed: () async {

              if (_globalkey.currentState.validate()){
                farmProvider.selectedUserFarmDocid(_dropdownvalue).then((value) async {
                  farmProvider.updateFarmGroup(widget.groupId, user.uid, widget.memberList, _dropdownvalue,
                      value[0],value[1])
                      .then((value) => {
                       Navigator.of(context)
                      ..pop()
                  }).then((value) => setState(() {
                  }));
                });
              }
            },
          )
        ),

      ),
      body: Column(
        children: [
          Form(
            key: _globalkey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  categoryTextField(widget.category),
                  SizedBox(
                    height: 30,
                  ),
                  categoryTextField(widget.subCategory),

             Consumer<FarmProvider>(
                builder: (context, farmProvider, _) {
                 return Container(
                    //padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    //color: Colors.white,
                    margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(kShape)),
                      color: kAccentColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonFormField<String>(
                                value: _dropdownvalue,
                                iconSize: 30,
                                icon: (null),
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                                hint: Text('Select Farm'),
                                onChanged: (String newValue) {
                                  setState(() {
                                    _dropdownvalue = newValue;
                                    print(_dropdownvalue);
                                  });
                                },
                                items: farmProvider.groupNameList?.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item),
                                    value: item,
                                  );
                                })?.toList() ??
                                    [],

                                validator: (value) => value == null
                                    ? 'Please select an option' : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
               )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  snackBarMsg(BuildContext context, String msg) {
    var sb = SnackBar(
      elevation: kRadius,
      content: Text(msg),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        // textColor: kWhiteColor,
        label: 'OK',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(sb);
  }

  Widget categoryTextField(String name) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width*0.9,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            textScaleFactor: 1.3,
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:  Border(
          left: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          top: BorderSide(
            color: Colors.green,
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.green,
            width: 3,
          ),
        ),

        //helperText: "Name can't be empty",
      ),
    );
  }





}