import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:gelirim/ui/widget/app_bar/profile_edit_appbar.dart';
import 'package:get/get.dart';

class UserNameEdit extends StatelessWidget {
  ProfileEditController _profileEditController;

  UserNameEdit(this._profileEditController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ProfileEditAppBar(editController:_profileEditController,titleTex: "Ad Soyad",type: EditType.NAME, appBar: AppBar(),),
      body: _buildPage(),
    );
  }
  
  Widget _buildPage(){
    return Container(
      margin: EdgeInsets.only(top: 30,left: 40,right: 50),
      width:double.infinity,
      child: Column(
        children: [
          TextFormField(
            controller: _profileEditController.nameEditController,
            onChanged: (String? value){
              _profileEditController.listenNameTextForm();
            },
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
