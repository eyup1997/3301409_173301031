import 'package:gelirim/model/user/user_view_model.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:get/get.dart';

class UserViewModelController extends GetxController{
  UserService _userService=UserService();
  var authViewModel=UserViewModel().obs;
  UserViewModelController(){
    setAuthViewModel();
  }
  Future setAuthViewModel()async{
    var rtn=await _userService.checkAuth();
    if(rtn is UserViewModel){
      authViewModel.value=rtn;
    }
  }
}