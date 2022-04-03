import 'package:flutter/material.dart';
import 'package:gelirim/controller/model/user_view_model_controller.dart';
import 'package:gelirim/controller/page/profile_controller.dart';
import 'package:gelirim/dao/api/endpoint/base_endpoint.dart';
import 'package:gelirim/ui/profile_edit_page.dart';
import 'package:gelirim/ui/widget/app_bar/profile_appbar.dart';
import 'package:gelirim/ui/widget/drawers/profile_drawer.dart';
import 'package:gelirim/ui/widget/navigator_bar_widget.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget implements NavigatorBarWidget {
  late BuildContext pageContex;
  ProfileController _profileController=Get.put(ProfileController());
  UserViewModelController _userViewModelController=Get.put(UserViewModelController());

  ProfilePage(){
    print("------------------------------------------1");
  }

  @override
  Widget build(BuildContext context) {
    pageContex=context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          actions: [
            profileMenu(),
          ],
        ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx((){return buildPage();}),
      )
    );
  }

  Widget profileMenu(){
    return Container(
      margin: EdgeInsets.only(right: 10,top: 3),
      child: InkWell(
        onTap: (){
          showDialog(
              context: pageContex!,
              builder: (context) => AlertDialog(
                  insetPadding:
                  EdgeInsets.symmetric(horizontal: 100),
                  content: Container(
                    height: 50,
                    width: 50,
                    child: Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _profileController.logout();
                            },
                            child: Text("Çıkış Yap"),
                          ),
                        ),

                      ],
                    ),
                  )));
        },
        child: Icon(Icons.menu,color: Colors.black,),
      ),
    );
  }

  Widget buildPage(){
    return Column(
      children: [
        //Photo
        Container(
          margin: EdgeInsets.only(top: 15),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.grey,
            //image: DecorationImage(
            //               image: NetworkImage(BaseEndpoint.userImage+_userViewModelController.authViewModel.value.imageName!),
            //               fit: BoxFit.cover,
            //               ),
          ),
        ),

        //Name
        Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            _userViewModelController.authViewModel.value.name,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),

        //Follow
        Container(
          padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
          child:  Row(
            children: [
              //Following
              Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text("23",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                        Text(
                          "Takip ediliyor",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        )
                      ],
                    ),
                  )),
              //Followers
              Text("|",style: TextStyle(fontSize: 20),),
              Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text("23",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24)),
                        Text(
                          "Takip ediliyor",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        Container(
          child: ElevatedButton(
            style:  ElevatedButton.styleFrom(
                primary: Colors.white
            ),
            onPressed: (){
              Get.to(ProfileEditPage());
            }, child: Text("Profili Düzenle",style: TextStyle(color: Colors.black),),
          ),
        ),
        buildAuthPost(),
      ],

    );
  }

  Widget buildAuthPost(){
    if(_profileController.authPostShow.value){
      return Container(
        height: 240,
        color: Colors.blueGrey,
        child: ListView.builder(itemCount: _profileController.authPosts.value.length,itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              _profileController.goAuthPostDetail(_profileController.authPosts.value[index].id);
            },
            child: Container(
              color: Colors.grey,
              margin: EdgeInsets.all(10),
              child: Text(_profileController.authPosts.value[index].gameName),
            ),
          );
        }),
      );
    }
    return SizedBox();
  }
}
