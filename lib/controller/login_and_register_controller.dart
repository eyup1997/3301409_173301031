import 'package:flutter/cupertino.dart';
import 'package:gelirim/api/model/auth_model.dart';
import 'package:gelirim/controller/auth_controller.dart';
import 'package:gelirim/model/form_model/login_form_model.dart';
import 'package:gelirim/model/form_model/register_form_model.dart';
import 'package:gelirim/ui/android/welcome_page.dart';
import 'package:get/get.dart';

import '../main.dart';

class LoginAndRegisterController extends GetxController{

  //TODO LOGIN Controller

  //TODO Button status
  var loginBtnStatus=false.obs;
  //TODO Validations status
  var emailValidStatus=false.obs;
  var passwordValidStatus=false.obs;
  //TODO Form Controller
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  //TODO Loading status
  var loginLoading=false.obs;
  //TODO Error login
  var wrongEmailOrPassword=false.obs;

  //TODO Listeners formField
  void listenersEmailField(String? value){
    if(value==null){
      emailValidStatus.value=false;
    }else if(value.isEmpty){
      emailValidStatus.value=true;
    }else if(!value.isEmail){
      emailValidStatus.value=true;
    }else{
      emailValidStatus.value=false;
    }
    listenersLoginBt();
  }
  void listenersPasswordField(String? value){
    if(value==null){
      passwordValidStatus.value=false;
    }else if(value.length>=6){
      passwordValidStatus.value=false;
    }else{
      passwordValidStatus.value=true;
    }
    listenersLoginBt();
  }

  void listenersLoginBt(){
    if(passwordValidStatus.value || emailValidStatus.value){
      loginBtnStatus.value=false;
    }else if(loginEmailController.value.text.isNotEmpty || loginPasswordController.value.text.isNotEmpty){
      loginBtnStatus.value=true;
    }else{
      loginBtnStatus.value=true;
    }
  }

  void login(){
    loginLoading.value=true;
    AuthController authController=Get.put(AuthController());
    authController.login(LoginFormModel(password: loginPasswordController.text, email: loginEmailController.text)).then((value) =>{
      if(value){
        //Success login
        loginLoading.value=false,
        Get.offAll(WelcomePage()),
      }else{
        //Error login
        wrongEmailOrPassword.value=true,
        loginLoading.value=false,
    }
    });
  }


  //TODO REGISTER Controller
  var registerBtnStatus=false.obs;
  var registerLoading=false.obs;
  var usedEmail=false.obs;
  //Form valid status
  var registerEmailValidStatus=false.obs;
  var registerNameValidStatus=false.obs;
  var registerPasswordValidStatus=false.obs;
  var registerPasswordRepeatValidStatus=false.obs;
  //Form controller
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerPasswordRepeatController = TextEditingController();
  TextEditingController registerNameController = TextEditingController();
  TextEditingController denemeNameController=TextEditingController();

  void listenerRegisterEmailForm(String value){
    if(value.isEmpty){
      registerEmailValidStatus.value=true;
    }else if(!value.isEmail){
      registerEmailValidStatus.value=true;
    }else if(value.isEmail){
      registerEmailValidStatus.value=false;
    }
    listenerRegisterBtn();
  }
  void listenerRegisterNameForm(String value){
    if(value.length>=6 && value.length<=20){
      registerNameValidStatus.value=false;
    }else{
      registerNameValidStatus.value=true;
    }
    listenerRegisterBtn();
  }
  void listenerRegisterPasswordForm(String value){
    if(value.length>=6 && value.length<=20){
      registerPasswordValidStatus.value=false;
    }else{
      registerPasswordValidStatus.value=true;
    }
    listenerRegisterBtn();
  }
  void listenerRegisterPasswordRepeatForm(String value){
    if(registerPasswordController.text!=value){
      registerPasswordRepeatValidStatus.value=true;
    }
    else{
      registerPasswordRepeatValidStatus.value=false;
    }
    listenerRegisterBtn();
  }

  void listenerRegisterBtn(){
    if(registerEmailController.text.isEmpty || denemeNameController.text.isEmpty || registerPasswordController.text.isEmpty || registerPasswordRepeatController.text.isEmpty){
      registerBtnStatus.value=false;
    }else if(registerPasswordRepeatValidStatus.value || registerEmailValidStatus.value || registerNameValidStatus.value || registerPasswordRepeatValidStatus.value){
      registerBtnStatus.value=false;
    }else{
      registerBtnStatus.value=true;
    }
  }



  void register(){
    registerLoading.value=true;
    AuthController authController=Get.put(AuthController());
    var email=registerEmailController.text;
    var password=registerPasswordController.text;
    var name=denemeNameController.text;
    authController.register(RegisterFormModel(email: email, password: password, name: name)).then((value) =>{
      registerLoading.value=false,
      if(value){
        //Success register
        Get.offAll(Welcome()),
      }else{
        //Error login
        usedEmail.value=true,
      }
    });
  }


}