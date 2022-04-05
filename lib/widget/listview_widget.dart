import 'package:AgriNet/providers/users_provider.dart';
import 'package:AgriNet/screens/pages/detailscreen.dart';
import 'package:AgriNet/widget/likeButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/users.dart';

class ListViewWidget extends StatefulWidget {
  final UsersProvider usersProvider;

  const ListViewWidget({
    @required this.usersProvider,
    Key key,
  }) : super(key: key);

  @override
  _ListViewWidgetState createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final scrollController = ScrollController();

  Widget catalogueCard(service) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => DetailScreen(
                image:service.imageUrl ,
                name:service.name ,
                price: service.price,
              ),
            ),
          );
        },
        child: Container(
          height: 200,
          child: Card(
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 150.0,
                        height: 150.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(service.imageUrl)
                            )
                        )),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(service.name,
                            style: TextStyle (
                                color: Colors.white,
                                fontSize: 18
                            ),
                          ),
                          Expanded(
                            child: Text(service.name,
                              style: TextStyle (
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                          ),


                          Expanded(
                            child: Text("Price: "+service.price.toString(),
                              style: TextStyle (
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            /*child: IconButton(

                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    //builder: (ctx) => MyHomePage(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.favorite,
                                  size: 22.0 ,
                                  color: Color(0xffedf1f0)
                              ),
                              //label: Text('Home')
                            ),*/
                            child:LikeButtonWidget(isLiked:service.isLiked,likeCount:service.likeCount,docid:service.docid),
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(scrollListener);
    widget.usersProvider.fetchNextUsers();
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (widget.usersProvider.hasNext) {
        widget.usersProvider.fetchNextUsers();
      }
    }
  }

  @override
  Widget build(BuildContext context){
    final user = Provider.of<Users>(context);
    widget.usersProvider.fetchFirebaseWishlist(user.uid);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        controller: scrollController,
        padding: EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: <Widget>[

                Column(
                    children: widget.usersProvider.serviceList.map((p) {
                      return catalogueCard(p);
                    }).toList()
                ),
                if (widget.usersProvider.hasNext)
                  Center(
                    child: GestureDetector(
                      onTap: widget.usersProvider.fetchNextUsers,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}