import 'package:AgriNet/providers/users_provider.dart';
import 'package:flutter/material.dart';

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
  //UsersProvider usersProvider;

  Widget personDetailCard(person) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
                              image: NetworkImage(person.imageUrl)
                          )
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(person.name,
                        style: TextStyle (
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                      Text(person.name,
                        style: TextStyle (
                            color: Colors.white,
                            fontSize: 12
                        ),
                      )
                    ],
                  ),
                )
              ],
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
    //usersProvider.fetchNextUsers();
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
                  children: widget.usersProvider.users.map((p) {
                    return personDetailCard(p);
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

  } /*=> ListView(
    controller: scrollController,
    padding: EdgeInsets.all(12),
    children: [
      ...widget.usersProvider.users
          .map((user) => ListTile(
        title: Text(user.name),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.imageUrl),
          /*child:Text(
            user.name[0].toUpperCase(),
          ),*/
        ),
      ))
          .toList(),
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
  );*/
}