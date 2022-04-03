import 'package:gelirim/controller/model/user_view_model_controller.dart';
import 'package:gelirim/controller/page/post_show_controller.dart';
import 'package:gelirim/main.dart';
import 'package:gelirim/model/post/post_view_model.dart';
import 'package:gelirim/service/post_service.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:gelirim/ui/login_page.dart';
import 'package:gelirim/ui/post_pages/auth_post_page.dart';
import 'package:get/get.dart';
import 'package:restart_app/restart_app.dart';

class ProfileController extends GetxController{
  UserService _userService=UserService();
  PostService _postService=PostService();
  UserViewModelController userViewModelController=Get.put(UserViewModelController());
  Rx<String> value="DENEME".obs;
  var authPostShow=false.obs;
  var authPosts=<PostViewModel>[].obs;
  ProfileController(){
    setAuthPosts();
  }
  void setAuthPosts()async{
    var res=await _postService.getAuthPost();
    if(res!=null){
      authPostShow.value=true;
      authPosts.value=res;
    }
  }
  void logout()async{
    await _userService.logout();
    Get.offAll(LoginPage());
  }
  void deneme(){
    value.value="DENEME2";
    print(value.value);
  }

  void goAuthPostDetail(int id){
    PostShowController postShowController=Get.put(PostShowController());
    _postService.getPost(id).then((value) => {
      print("---------------------2"),

      if(value!=null){
        print("---------------------1"),
        postShowController.authPost.value=value,
        Get.to(AuthPostPage()),
      }
    });
  }
}