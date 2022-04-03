import 'package:flutter/material.dart';
import 'package:gelirim/controller/navigator_bar_controller.dart';
import 'package:get/get.dart';

class NavigatorBar extends StatelessWidget {
  final NavigatorBarController _navBarController=Get.put(NavigatorBarController());
  PageStorageBucket bucket=PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(onPressed: (){
                _navBarController.getHomePage();
              },
                minWidth: 40,
                child: Icon(Icons.home),
              ),
              MaterialButton(onPressed: (){
                _navBarController.getFavoritePage();
              },
                minWidth: 40,
                child: Icon(Icons.favorite),
              ),
              MaterialButton(onPressed: (){
                _navBarController.getChatPage();
              },
                minWidth: 40,
                child: Icon(Icons.chat),
              ),
              MaterialButton(onPressed: (){
                _navBarController.getProfilePage();
              },
                minWidth: 40,
                child: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),
      body: PageStorage(
        bucket: bucket,
        child: Obx(()=>_navBarController.selectPage.value),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          _navBarController.goSavePost();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}