import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gelirim/controller/model/user_view_model_controller.dart';
import 'package:gelirim/dao/api/model/enums/gender.dart';
import 'package:gelirim/model/user/user_view_model.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:gelirim/ui/profile_edit_pages/birth_edit_page.dart';
import 'package:gelirim/ui/profile_edit_pages/gender_edit_page.dart';
import 'package:gelirim/ui/profile_edit_pages/name_edit_page.dart';
import 'package:gelirim/ui/profile_edit_pages/password_edit_page.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ProfileEditController extends GetxController{
  UserService _userService=UserService();
  var systemError=false.obs;//TRUE MUST NOT!!
  var loadingStatus=true.obs;
  var editBtnEnable=false.obs;
  var userViewModelController=Get.put(UserViewModelController());
  late TextEditingController nameEditController;
  late TextEditingController birthDateEditController;
  late var userViewModel=UserViewModel().obs;
  late Rx<String> birthDate="Tarih Belirle".obs;

  ProfileEditController(){
    setViewModel();
  }

  Future setViewModel()async{
    var mdl=await _userService.checkAuth();
    if(mdl is UserViewModel){
    userViewModel.value=mdl;
    print(userViewModel.value.imageName);
    loadingStatus.value=false;
    nameEditController =TextEditingController(text: mdl.name);
    birthDateEditController=TextEditingController();
    if(userViewModel.value.birthDate != null){
      birthDate.value=DateFormat("yyyy-MM-d").format(userViewModel.value.birthDate!);
    }
    }else{
    //ERROR
    loadingStatus.value=false;
    systemError.value=true;
    }

  }



  //Page Navi
  void goNameEditPage(){
    nameEditController=TextEditingController(text: userViewModel.value.name);
    Get.to(UserNameEdit(this));
  }
  void goGenderEditPage(){
    switch(userViewModel.value.gender){
      case Gender.MALE:{
        selectMale.value=true;
        selectFemale.value=false;
        selectNon.value=false;
      }break;
      case Gender.FEMALE:{
        selectMale.value=false;
        selectFemale.value=true;
        selectNon.value=false;
      }break;
      case Gender.NON:{
        selectMale.value=false;
        selectFemale.value=false;
        selectNon.value=true;
      }break;
    }
    Get.to(GenderEditPage(this));
  }
  void goBirthDateEditPage() {
    Get.to(BirthEditPage(this));
  }
  void goPasswordEditPage(){
    Get.to(PasswordEditPage(this));
  }
  //TODO Name Edit Controller
  var nameEditSaveBtn=false.obs;
  void listenNameTextForm(){
    if(nameEditController.text.length>4 && nameEditController.text!=userViewModel.value.name){
      nameEditSaveBtn.value=true;
    }else{
      nameEditSaveBtn.value=false;
    }
  }

  //TODO Gender Edit Controller
  var genderEditSaveBtn=false.obs;
  var selectMale=false.obs;
  var selectFemale=false.obs;
  var selectNon=true.obs;
  void selectMaleBtn(){
    selectMale.value=true;
    selectFemale.value=false;
    selectNon.value=false;
    checkGenderSaveBtn();
  }
  void selectFemaleBtn(){
    selectMale.value=false;
    selectFemale.value=true;
    selectNon.value=false;
    checkGenderSaveBtn();
  }
  void selectNonBtn(){
    selectMale.value=false;
    selectFemale.value=false;
    selectNon.value=true;
    checkGenderSaveBtn();
  }
  void checkGenderSaveBtn(){
    if((userViewModel.value.gender==Gender.MALE && selectMale.value) ||
        (userViewModel.value.gender==Gender.FEMALE && selectFemale.value) ||
        (userViewModel.value.gender==Gender.NON && selectNon.value)){
      genderEditSaveBtn.value=false;
    }else{
      genderEditSaveBtn.value=true;
    }
  }

  //TODO Bio Edit Controller
  var bioEditSaveBtn=false.obs;
  

  //TODO Update
  void nameUpdate(){
    userViewModel.value.name=nameEditController.text;
    loadingStatus.value=true;
    nameEditSaveBtn.value=false;
    _userService.profileUpdate(userViewModel.value).then((value) => {
    loadingStatus.value=false,
        if(!value){
        //Error
      }else{

        }
    });
    userViewModelController.authViewModel.value=userViewModel.value;
    Get.back();
  }



  void genderUpdate(){
    if(selectNon.value){
      userViewModel.value.gender=Gender.NON;
    }
    else if(selectMale.value){
      userViewModel.value.gender=Gender.MALE;
    }
   else if(selectFemale.value){
      userViewModel.value.gender=Gender.FEMALE;
    }
    loadingStatus.value=true;
   genderEditSaveBtn.value=false;
   _userService.profileUpdate(userViewModel.value).then((value) => {
     loadingStatus.value=false,
   });
   Get.back();
  }


  var birthDateCheck=false.obs;
  void birthDateChange(DateTime time){
    birthDateCheck.value=true;
    userViewModel.value.birthDate=time;  }
  void updateBirthDate(){
    loadingStatus.value=true;
    _userService.profileUpdate(userViewModel.value).then((value) => {
      loadingStatus.value=false,
      birthDateCheck.value=false,
    birthDate.value=DateFormat("yyyy-MM-d").format(userViewModel.value.birthDate!),
    });
    Get.back();
  }

  Future selectCamera()async{
    loadingStatus.value=true;
    var im=await ImagePicker().pickImage(source: ImageSource.camera);
    if(im!=null){
      print("**************0");
      File? img = (await ImageCropper.cropImage(
          sourcePath: im.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      )) as File;
      if(img!=null){
        _userService.profileImageUpdate(img).then((value) => {
          loadingStatus.value=false,
        });
      }
    }
    Get.back();
  }
  Future selectGallery()async{
    loadingStatus.value=true;
    var im=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(im!=null){
      print("**************0");
      File? img = (await ImageCropper.cropImage(
          sourcePath: im.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )
      )) as File;
      if(img!=null){
        _userService.profileImageUpdate(img).then((value) => {
          loadingStatus.value=false,
        });
      }
    }
    Get.back();
  }

  var passwordSaveBtn=false.obs;
  var oldPasswordCheck=false.obs;
  var oldPasswordValidText=false.obs;
  var newPasswordCheck=false.obs;
  var newPasswordValidText=false.obs;
  var newPasswordRepeatCheck=false.obs;
  var oldPasswordEditController=TextEditingController();
  var newPasswordEditController=TextEditingController();
  void listenOldPasswordForm(String? value)async{
    oldPasswordCheck.value=true;
    if(value!=null){
      var chk=await _userService.checkPassword(value);
      if(chk){
        oldPasswordCheck.value=false;
        oldPasswordValidText.value=true;
      }else{
        oldPasswordCheck.value=true;
        oldPasswordValidText.value=false;
      }
    }
  }
  void listenNewPasswordForm(String? value)async{
    newPasswordCheck.value=true;
    if(value!=null && oldPasswordValidText.value){
      String  pattern = r'^(?=.*?[A-z])(?=.*?[0-9]).{3,}$';
      RegExp regExp = new RegExp(pattern);
      if(regExp.hasMatch(value)){
        print("00000000000000000");
        newPasswordValidText.value=true;
        newPasswordCheck.value=false;
      }else{
        newPasswordValidText.value=false;
        newPasswordCheck.value=true;
      }
    }
  }
  void listenNewPasswordRepeatForm(String? value){
    newPasswordRepeatCheck.value=true;
    if(value!=null && newPasswordValidText.value && value==newPasswordEditController.value.text){
      newPasswordRepeatCheck.value=false;
      passwordSaveBtn.value=true;
    }else{
      passwordSaveBtn.value=false;
    }
  }
  void updatePassword(){
    loadingStatus.value=true;
    _userService.updatePassword(newPasswordEditController.value.text, oldPasswordEditController.value.text).then((value) => {
      if(value){
        loadingStatus.value=false,
        passwordSaveBtn.value=false,
         oldPasswordCheck.value=false,
         oldPasswordValidText.value=false,
         newPasswordCheck.value=false,
         newPasswordValidText.value=false,
         newPasswordRepeatCheck.value=false,
         oldPasswordEditController=TextEditingController(),
         newPasswordEditController=TextEditingController(),
      }
    });
    Get.back();
  }




}