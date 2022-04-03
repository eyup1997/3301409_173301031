import 'package:flutter/cupertino.dart';

import 'package:gelirim/ui/chat_page.dart';
import 'package:gelirim/ui/favorite_page.dart';
import 'package:gelirim/ui/home_page.dart';
import 'package:gelirim/ui/post_save_pages/selectCategory_page.dart';
import 'package:gelirim/ui/profile_page.dart';
import 'package:gelirim/ui/widget/navigator_bar_widget.dart';
import 'package:get/get.dart';

class NavigatorBarController extends GetxController{
  var pages=<NavigatorBarWidget>[
    HomePage(),
    FavoritePage(),
    ChatPage(),
    ProfilePage(),
  ].obs;
  var selectPage=NavigatorBarWidget().obs;
  var changed=false.obs;
  @override
  void onInit() {
    selectPage=pages.value[0].obs;
    super.onInit();
  }
  void getHomePage(){
    print("HOME->");
    if(selectPage.value is! HomePage){
      print("HOME->+");
      selectPage.value=HomePage();
    }
    print("HOME->-");
  }
  void getFavoritePage(){
    print("FavoritePage->"+selectPage.toString());

    if(selectPage.value is! FavoritePage){
      print("FavoritePage->+");

      selectPage.value=FavoritePage();
    }else{
      print("FavoritePage->-");

    }
  }
  void getChatPage(){
    if(selectPage.value is! ChatPage){
      selectPage.value=ChatPage();
    }
  }
  void getProfilePage(){
    if(selectPage.value is! ProfilePage){
      selectPage.value=ProfilePage();
    }
  }
  void goSavePost(){
    Get.to(SelectCategoryPage());
  }
}