import 'package:gelirim/model/user/user_view_model.dart';
import 'package:gelirim/service/return_code.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:get/get.dart';

class MainController extends GetxController{
  var loadingScreen=true.obs;
  var loginScreen=false.obs;
  var homeScreen=false.obs;
  final UserService _userService=UserService();
  void run(){
    _userService.checkAuth().then((value) => {
      print(value),
      if(value is UserViewModel){
        loadingScreen.value=false,
        homeScreen.value=true,
      }else{
        loadingScreen.value=false,
        loginScreen.value=true,
      }
    });
  }

}