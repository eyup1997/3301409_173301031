import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:gelirim/ui/widget/app_bar/profile_edit_appbar.dart';
import 'package:get/get.dart';

class GenderEditPage extends StatelessWidget {
  ProfileEditController _profileEditController;

  GenderEditPage(this._profileEditController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileEditAppBar(
        editController: _profileEditController,
        titleTex: "Cinsiyet",
        type: EditType.GENDER,
        appBar: AppBar(),
      ),
      body: Obx((){
       return _buildPage();
      }),
    );
  }

  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(
        top: 30,
        left: 20,
        right: 20,
      ),
      height: 200,
      child: Row(
        children: [
          Expanded(
            child: RaisedButton(
              color: _buildMaleColor(),
              onPressed: () {
                _profileEditController.selectMaleBtn();
              },
              child: Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text("Erkek"),
                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: RaisedButton(
              color: _buildFemaleColor(),
              onPressed: () {
                _profileEditController.selectFemaleBtn();
              },
              child: Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text("Kadın"),
                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: RaisedButton(
              color:_buildNonColor(),
              onPressed: () {
                _profileEditController.selectNonBtn();
              },
              child: Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text("Tanımsız"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _buildMaleColor(){
    if(_profileEditController.selectMale.value){
      return Colors.red;
    }
    return Colors.grey;
  }
  Color _buildFemaleColor(){
    if(_profileEditController.selectFemale.value){
      return Colors.red;
    }
    return Colors.grey;
  }
  Color _buildNonColor(){
    if(_profileEditController.selectNon.value){
      return Colors.red;
    }
    return Colors.grey;
  }
}
