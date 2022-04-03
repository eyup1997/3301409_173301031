import 'package:flutter/material.dart';
import 'package:gelirim/controller/page/post_show_controller.dart';
import 'package:get/get.dart';

class AuthPostPage extends StatelessWidget{
  PostShowController _postShowController=Get.put(PostShowController());
  AuthPostPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("------------"),
      ),
      body: Obx((){
        return buildPage();
      }),
    );
  }

  Widget buildPage(){
    return Container(
      child: Column(
        children: [
          Text(_postShowController.authPost.value.gameName),
          Text(_postShowController.authPost.value.explanation),
          Text(_postShowController.authPost.value.id.toString()),
        ],
      ),
    );
  }
}
