import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:gelirim/ui/widget/app_bar/profile_edit_appbar.dart';
import 'package:get/get.dart';

class PasswordEditPage extends StatelessWidget {
  ProfileEditController _profileEditController;
  PasswordEditPage(this._profileEditController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileEditAppBar(editController:_profileEditController,titleTex: "Şifre",type: EditType.PASSWORD, appBar: AppBar(),),
      body: Obx((){
        return buildPage();
      })
    );
  }
  Widget buildPage(){
    return Container(
      child: Form(
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              controller: _profileEditController.oldPasswordEditController,
              onChanged: (String? value){
                _profileEditController.listenOldPasswordForm(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.lock),
                hintText: "Eski Şifre",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            buildOldPasswordValidText(),
            //buildUseEmailText(),
            //buildEmailValidatorText(),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              controller: _profileEditController.newPasswordEditController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.lock),
                hintText: "Yeni Şifre",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              onChanged: (String? value){
                _profileEditController.listenNewPasswordForm(value);
              },
            ),
            buildNewPasswordValidText(),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              onChanged: (String? value){
                _profileEditController.listenNewPasswordRepeatForm(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre Tekrar",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            buildNewPasswordRepeatValidText(),

          ],
        ),

      ),
    );
  }
  Widget buildOldPasswordValidText(){
    if(_profileEditController.oldPasswordCheck.value){
      return Text("Eski şifre yanlış!!",style: TextStyle(color: Colors.red),);
    }
    return Text(" ");
  }
  Widget buildNewPasswordValidText(){
    if(_profileEditController.newPasswordCheck.value){
      return Text("Yeni şifre: 6 karakter ve en az 1 harf ve 1 rakam içermeli!!",style: TextStyle(color: Colors.red),);
    }
    return Text(" ");
  }
  Widget buildNewPasswordRepeatValidText(){
    if(_profileEditController.newPasswordRepeatCheck.value){
      return Text("Şifre tekrarı yanlış!",style: TextStyle(color: Colors.red),);
    }
    return Text(" ");
  }
}
