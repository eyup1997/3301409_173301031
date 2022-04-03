import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gelirim/ui/denemePage.dart';
import 'package:gelirim/ui/post_save_pages/show_new_post.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/user/image_res_model.dart';
import 'package:gelirim/dao/api/user_api.dart';
import 'package:gelirim/service/user_service.dart';
import 'package:gelirim/ui/widget/navigator_bar_widget.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class HomePage extends StatelessWidget implements NavigatorBarWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: RaisedButton(
            onPressed: () {
              Get.to(ShowNewPost());
            },
            child: Text("asd")
          ),
        ),
      ),
    );
  }

  Future de() async {

  }
}
