import 'package:flutter/material.dart';


class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome>
    {
      @override
      Widget build(BuildContext context) {
        return new Scaffold(
          body: Center(
              child: Container(
                  child: Center(child: Text("Chat Section")),
                decoration: BoxDecoration(
                  image:DecorationImage(
                      image:NetworkImage('https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'))
                ),
              )

          ),
        );//Scaffold
      }
    }

