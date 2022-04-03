import 'package:flutter/cupertino.dart';
import 'package:gelirim/model/user/login_view_model.dart';
import 'package:gelirim/model/user/register_view_model.dart';
import 'package:gelirim/service/return_code.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:gelirim/ui/home_page.dart';
import 'package:gelirim/ui/navigator_bar.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  UserService _userService=UserService();

  var loginScreen=true.obs;
  var btnStatus=false.obs;
  var passwordValidatorTextStatus=false.obs;
  var passwordRepeatValidatorTextStatus=false.obs;
  var passwordMinChar=false.obs;
  var passwordChar=false.obs;
  var passwordRepeat=false.obs;
  var emailValidatorTextStatus=false.obs;
  var emailText=false.obs;




  ///Forms fields
  RxString loginEmail=RxString("");
  RxString registerEmail=RxString("");
  RxString registerPassword=RxString("");

  ///Forms controllers
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  void loginEmailChange(String? value){
    emailValidatorTextStatus.value=true;
    if(value!=null){
      String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regExp = RegExp(pattern);
      if(regExp.hasMatch(value)){
        emailText.value=true;
        checkLoginBtnStatus();
      }else{
        emailText.value=false;
      }
    }else{
      emailText.value=false;
    }
  }

  void loginPasswordChange(String? value){
    if(emailText.value){
      passwordChar.value=true;
      checkLoginBtnStatus();
    }else{
      passwordChar.value=false;
    }
  }

  void checkLoginBtnStatus(){
    if(emailText.value && passwordChar.value){
      btnStatus.value=true;
    }else{
      btnStatus.value=false;
    }
  }

  void registerEmailChange(String? value){
    useEmail.value=false;
    emailValidatorTextStatus.value=true;
    if(value!=null){
      String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regExp = RegExp(pattern);
      if(regExp.hasMatch(value)){
        emailText.value=true;
        registerEmail.value=value;
        checkBtnStatus();
      }else{
        emailText.value=false;
        checkBtnStatus();
      }
    }else{
      emailText.value=false;
      checkBtnStatus();
    }
  }


  void registerPasswordChange(String? value){
    registerPasswordRepeatChange(null);
    passwordValidatorTextStatus.value=true;
    if(value!=null){
      if(value.length>=6) {
        passwordMinChar.value=true;
        checkBtnStatus();
      } else{
        passwordMinChar.value=false;
        checkBtnStatus();
      }
    }else{
      passwordMinChar.value=false;
      checkBtnStatus();
    }

    if(value!=null){
      String  pattern = r'^(?=.*?[A-z])(?=.*?[0-9]).{3,}$';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(value)){
        passwordChar.value=true;
        checkBtnStatus();
      }else{
        passwordChar.value=false;
        checkBtnStatus();
      }
    }else{
      passwordChar.value=false;
      checkBtnStatus();
    }

    if(passwordChar.value && passwordMinChar.value){
      registerPassword.value=value!;
    }
  }
  void registerPasswordRepeatChange(String? value){
    if(passwordMinChar.value && passwordChar.value){
      passwordRepeatValidatorTextStatus.value=true;
      if(value==null) {
        passwordRepeatValidatorTextStatus.value=false;
      } else{
        if(value==registerPassword.value){
          passwordRepeat.value=true;
          checkBtnStatus();
        }else{
          passwordRepeat.value=false;
          checkBtnStatus();
        }
      }
    }else{
      passwordRepeatValidatorTextStatus.value=false;

    }

  }
  void checkBtnStatus(){
    if(emailText.value && passwordChar.value && passwordMinChar.value && passwordRepeat.value){
      btnStatus.value=true;
    }else{
      btnStatus.value=false;
    }
  }

  var registerError=false.obs;
  var useEmail=false.obs;
  var loading=false.obs;
  var successRegister=false.obs;
  void register(){
    loading.value=true;
    btnStatus.value=false;


    RegisterViewModel viewModel=RegisterViewModel();
    viewModel.password=registerPassword.value;
    viewModel.email=registerEmail.value;
    viewModel.name="Deneme";
    _userService.register(viewModel).then((code) => {
      loading.value=false,
      if(code==RegisterCode.UNSUCCESSFUL){
        useEmail.value=true,
        emailValidatorTextStatus.value=false,
        passwordValidatorTextStatus.value=false,
        passwordRepeatValidatorTextStatus.value=false,
      }else{
        successRegister.value=true,

        Get.offAll(NavigatorBar()),
      }
    });
  }

  var errorLogin=false.obs;
  var successLogin=false.obs;
  void login(){
    errorLogin=false.obs;
    successLogin=false.obs;
    loading.value=true;
    btnStatus.value=false;


    LoginViewModel viewModel=LoginViewModel();
    viewModel.username=loginEmailController.value.text;
    viewModel.password=loginPasswordController.value.text;
    _userService.login(viewModel).then((code) => {
      loading.value=false,
      if(code==LoginCode.UNSUCCESSFUL){
        errorLogin.value=true,
      }else{
        Get.offAll(NavigatorBar()),
      }
    });
  }

  void changeScreen(){
    loginScreen.value=!loginScreen.value;
    ///reset
    emailValidatorTextStatus.value=false;
    passwordValidatorTextStatus.value=false;
    passwordRepeatValidatorTextStatus.value=false;
    btnStatus.value=false;
    errorLogin=false.obs;
    successLogin=false.obs;
    registerEmailController.clear();
    registerPasswordController.clear();
    loginPasswordController.clear();
    loginEmailController.clear();
  }


}