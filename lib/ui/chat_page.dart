import 'package:flutter/material.dart';
import 'package:gelirim/ui/denemePage.dart';
import 'package:gelirim/ui/widget/navigator_bar_widget.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget implements NavigatorBarWidget{
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FlatButton(
            onPressed: (){
            },
            child: Text("MAP"),
          ),
        ),
      ),
    );
  }
}
