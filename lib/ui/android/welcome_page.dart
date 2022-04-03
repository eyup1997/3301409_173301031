import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../main.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("------WELCOME------"),
              FlatButton(onPressed: (){
                var st=GetStorage();
                st.remove("username");
                st.remove("password");
                Get.to(Welcome());
              }, child: Text("ÇIKIŞ"))
            ],
          ),
      ),
    );
  }
}
