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
              child: Text("Chat Section")

          ),
        );//Scaffold
      }
    }

