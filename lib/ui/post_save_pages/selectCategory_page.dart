import 'package:flutter/material.dart';
import 'package:gelirim/controller/page/post_save_controller.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';

class SelectCategoryPage extends StatelessWidget {
  PostSaveController _postSaveController = Get.put(PostSaveController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("0E1839"),
      body: Obx(() {
        return buildPage();
      }),
    );
  }

  Widget buildPage() {
    if (_postSaveController.loading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Center(
      child: ListView.builder(
          itemCount: _postSaveController.categoryViewModels.length,
          itemBuilder: (contex, index) {
            return Container(
              height: 150,
              width: 400,
              //color: HexColor("726F7B").withOpacity(0.5),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: HexColor("726F7B").withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Expanded(
                child: InkWell(
                  onTap: (){
                    _postSaveController.selectCategory(index);
                  },
                  child: Center(
                    child: Text(_postSaveController.categoryViewModels.value[index].category,style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
