import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:get/get.dart';

class ProfileEditAppBar extends StatelessWidget implements PreferredSizeWidget{
  late String titleTex;
  late EditType type;
  late ProfileEditController editController;
  late AppBar appBar;

  ProfileEditAppBar({Key? key,required this.appBar,required this.titleTex,required this.type,required this.editController}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Text(titleTex,style: const TextStyle(color: Colors.black),),

      actions: <Widget>[
        _buildEditSaveBtn()
      ],
      bottom: PreferredSize(
          child: Container(
            color: Colors.grey.shade500,
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(4.0)),
    );
  }

  Widget _buildEditSaveBtn(){
    switch(type){
      case EditType.NAME:return _nameEditBtn();
      case EditType.GENDER:return _genderEditBtn();
      case EditType.BIO:return _bioEditBtn();
      case EditType.BIRTH_DATE:return _birthDateEditBtn();
      case EditType.PASSWORD:return _passwordEditBtn();
    }
    return FlatButton(onPressed: (){}, child: Text(" "));
  }
  Widget _nameEditBtn(){
    return Obx((){
      if(editController.nameEditSaveBtn.value){
        return FlatButton(
          textColor: Colors.white,
          onPressed: () {
            editController.nameUpdate();
          },
          child: const Text("Kayıt",style: TextStyle(color: Colors.red),),
          shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        );
      }
      return FlatButton(
        onPressed: () {
        },
        child: const Text("Kayıt",style: TextStyle(color: Colors.grey),),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      );

    });
  }
  Widget _passwordEditBtn(){
    return Obx((){
      if(editController.passwordSaveBtn.value){
        return FlatButton(
          textColor: Colors.white,
          onPressed: () {
            editController.updatePassword();
          },
          child: const Text("Kayıt",style: TextStyle(color: Colors.red),),
          shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        );
      }
      return FlatButton(
        onPressed: () {
        },
        child: const Text("Kayıt",style: TextStyle(color: Colors.grey),),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      );

    });
  }

  Widget _genderEditBtn(){
    return Obx((){
      if(editController.genderEditSaveBtn.value){
        return FlatButton(
          textColor: Colors.white,
          onPressed: () {
            editController.genderUpdate();
          },
          child: const Text("Kayıt",style: TextStyle(color: Colors.red),),
          shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        );
      }
      return FlatButton(
        onPressed: () {
        },
        child: const Text("Kayıt",style: TextStyle(color: Colors.grey),),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      );

    });
  }

  Widget _bioEditBtn(){
    return Obx((){
      if(editController.genderEditSaveBtn.value){
        return FlatButton(
          textColor: Colors.white,
          onPressed: () {
            editController.genderUpdate();
          },
          child: const Text("Kayıt",style: TextStyle(color: Colors.red),),
          shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        );
      }
      return FlatButton(
        onPressed: () {
        },
        child: const Text("Kayıt",style: TextStyle(color: Colors.grey),),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      );

    });
  }


  Widget _birthDateEditBtn(){
    return Obx((){
      if(editController.birthDateCheck.value){
        return FlatButton(
          textColor: Colors.white,
          onPressed: () {
            editController.updateBirthDate();
          },
          child: const Text("Kayıt",style: TextStyle(color: Colors.red),),
          shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        );
      }
      return FlatButton(
        onPressed: () {
        },
        child: const Text("Kayıt",style: TextStyle(color: Colors.grey),),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
      );

    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

enum EditType{NAME,BIRTH_DATE,GENDER,BIO,PASSWORD}
