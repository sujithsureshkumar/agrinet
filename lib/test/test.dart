import 'package:flutter/material.dart';

import '../services/firestoreApi.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  //const nested_tab_bar({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  //FirestoreApi firestoreApiInstance=FirestoreApi();
  //FirestoreApi firestoreApiInstance = Provider.of<FirestoreApi>(context,listen: false);

  @override
  Widget build(BuildContext context) {
    //firestoreApiInstance.fetchFirebaseCategory(uid)
    Provider.of<FirestoreApi>(context,listen: false).fetchFirebaseCategory();
    print(Provider.of<FirestoreApi>(context).subCategoryList);
    return Scaffold(
      appBar: AppBar(
        title: Text("title"),
        centerTitle: true,
      ),
      body: Center(
          child: Text("Hello2")

      ),
    );
  }
}