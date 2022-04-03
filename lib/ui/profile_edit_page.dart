import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gelirim/controller/profile_edit_controller.dart';
import 'package:gelirim/dao/api/endpoint/base_endpoint.dart';
import 'package:gelirim/dao/api/model/enums/gender.dart';
import 'package:get/get.dart';


class ProfileEditPage extends StatelessWidget {
  ProfileEditController _profileEditController =Get.put(ProfileEditController());

  late BuildContext pageContext;

  @override
  Widget build(BuildContext context) {
    this.pageContext = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(
          "Profili Düzenle",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() {
        return _buildPage();
      }),
    );
  }

  File? img;
  //MediaQuery.of(context).size.he
  Widget _buildPage() {
    if (_profileEditController.loadingStatus.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ///Profile Foto Edit
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Stack(
              children: [
                Container(
                  //margin: EdgeInsets.only(top: 15),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(BaseEndpoint.userImage+_profileEditController.userViewModel.value.imageName!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white.withOpacity(0.9),
                          size: 40,
                        ),
                        onTap: () {
                          showDialog(
                              context: pageContext,
                              builder: (context) => AlertDialog(
                                  insetPadding:
                                      EdgeInsets.symmetric(horizontal: 100),
                                  content: Container(
                                    height: 100,
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              _profileEditController.selectCamera();
                                            },
                                            child: Text("Fotoğraf çek"),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            child: Text("Galeriden seç"),
                                            onTap: () {
                                              _profileEditController.selectGallery();
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "İptal",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )));
                        },
                      )),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: 30, right: 50),
            child: Column(
              children: [
                ///Name edit
                TextButton(
                  onPressed: () {
                    _profileEditController.goNameEditPage();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Ad Soyad"),
                      ),
                      Expanded(
                        child: Text(_profileEditController.userViewModel.value.name),
                      ),
                      Expanded(
                        child: Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    _profileEditController.goBirthDateEditPage();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Doğum Tarihi"),
                      ),
                      Expanded(
                        child: Text(_profileEditController.birthDate.value),
                      ),
                      Expanded(
                        child: Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    _profileEditController.goGenderEditPage();
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("Cinsiyet"),
                      ),
                      Expanded(child: _buildGenderText()),
                      Expanded(
                        child: Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text("Biyografi"),
                    ),
                    Expanded(
                      child: Text("Selçuk..."),
                    ),
                    Expanded(
                      child: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 30, top: 30),
            width: double.infinity,
            child: InkWell(
              onTap: (){
                _profileEditController.goPasswordEditPage();
              },
              child: Text(
                "Şifreyi Değiştir",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.only(left: 30, top: 30),
            width: double.infinity,
            child: Text(
              "Kişisel Bilgileri Ayarla",
              style: TextStyle(color: Colors.blue),
            ),
          ),

          ///info setting
        ],
      ),
    );
  }

  Widget _buildGenderText() {
    switch (_profileEditController.userViewModel.value.gender) {
      case Gender.NON:
        return Text("Tanımsız");
      case Gender.MALE:
        return Text("Erkek");
      case Gender.FEMALE:
        return Text("Kadın");
    }
    return Text("Tanımsız");
  }

}
