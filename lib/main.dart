import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:gelirim/controller/auth_controller.dart';
import 'package:gelirim/ui/android/login_page/login_and_register_select_page.dart';
import 'package:gelirim/ui/android/welcome_page.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gelirim/controller/main_controller.dart';
import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/user/login_request_model.dart';
import 'package:gelirim/dao/api/post_api.dart';
import 'package:gelirim/dao/api/user_api.dart';
import 'package:gelirim/service/return_code.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:gelirim/ui/login_page.dart';
import 'package:gelirim/ui/navigator_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final MainController _mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    _mainController.run();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }

}

class Welcome extends StatelessWidget {
  final AuthController _authController=Get.put(AuthController());
  Welcome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _authController.checkAuth().then((value) => {
      if(value){
        Get.offAll(WelcomePage()),
      }else{
        Get.offAll(LoginRegisterSelectPage()),
      }
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gelirim",style: TextStyle(color: Colors.white,fontSize: 30),),
              SizedBox(height: 20,),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadingPage(){
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Gelirim",style: TextStyle(color: Colors.white,fontSize: 30),),
              SizedBox(height: 20,),
              CircularProgressIndicator(color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
