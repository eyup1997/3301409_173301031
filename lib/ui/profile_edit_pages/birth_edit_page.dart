import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:gelirim/ui/widget/app_bar/profile_edit_appbar.dart';

class BirthEditPage extends StatelessWidget {
  ProfileEditController _profileEditController;

  BirthEditPage(this._profileEditController);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileEditAppBar(
        editController: _profileEditController,
        titleTex: "Doğum Tarihi",
        type: EditType.BIRTH_DATE,
        appBar: AppBar(),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        height: 100,

        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime.now(),
          minimumDate:  DateTime(1940,1,1),
          maximumDate: DateTime.now(),
          onDateTimeChanged: (DateTime newDateTime) {
            _profileEditController.birthDateChange(newDateTime);
          },
        ),
      ),
    );
  }
}
