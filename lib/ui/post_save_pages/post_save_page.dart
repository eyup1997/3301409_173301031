import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gelirim/controller/page/post_save_controller.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PostSavePage extends StatelessWidget {
  PostSaveController _postSaveController = Get.put(PostSaveController());
  late BuildContext pageContext;
  PostSavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pageContext = context;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildTopBar(),
      body: Obx(() {
        return buildPage();
      }),
    );
  }

  Widget buildPage() {
    if (_postSaveController.loading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return buildForm();
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSelectGameText(),
            SizedBox(
              height: 5,
            ),
            buildSelectGameForm(),
            SizedBox(
              height: 20,
            ),
            buildSelectStartDateText(),
            SizedBox(
              height: 5,
            ),
            buildSelectStartDateBtn(),
            SizedBox(
              height: 20,
            ),
            buildSelectFinishDateText(),
            SizedBox(
              height: 5,
            ),
            buildSelectFinishDateForm(),
            SizedBox(
              height: 40,
            ),
            buildWantedCountForm(),
            SizedBox(
              height: 20,
            ),
            buildExpFormText(),
            SizedBox(
              height: 5,
            ),
            buildExpForm(),
            SizedBox(
              height: 40,
            ),
            buildContinueBtn(),
          ],
        ),
      ),
    );
  }

  Widget buildSelectGameText() {
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Text(
        "Oyun Belirle",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildSelectGameForm() {
    return DropdownButtonHideUnderline(
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black, spreadRadius: 1),
          ],
        ),
        //margin: EdgeInsets.only(left: 10.0, right: 10.0),
        padding: EdgeInsets.only(right: 10, left: 10),
        child: DropdownButton(
            borderRadius: BorderRadius.circular(20),
            isExpanded: true,
            elevation: 8,
            value: _postSaveController.selectGameId.value,
            items: _postSaveController.getGameDropMenu(),
            onChanged: (int? value) {
              _postSaveController.selectGame(value!);
              _postSaveController.formListener();
            }),
      ),
    );
  }

  Widget buildSelectStartDateText() {
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Text(
        "Oyun başlama zamanı",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildSelectStartDateBtn() {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black, spreadRadius: 1),
        ],
      ),
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              startDate(pageContext);
            },
            child: buildStartDateText(),
          ))
        ],
      ),
    );
  }

  Widget buildStartDateText() {
    if (_postSaveController.startDateSelect.value) {
      return Text(
        _postSaveController.startDateText.value,
        style: TextStyle(color: Colors.black, fontSize: 18),
      );
    }
    return Text(
      "Zamanı belirle...",
      style: TextStyle(color: Colors.grey, fontSize: 18),
    );
  }

  Widget buildSelectFinishDateText() {
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Text(
        "Oynama süresi",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildSelectFinishDateForm() {
    return Container(
      width: double.infinity,
      //margin: EdgeInsets.only(left: 10.0, right: 10.0),
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Row(
        children: [
          Expanded(child: buildFinishSwitchBtn()),
          Expanded(
            child: buildFinishDateForm(),
          )
        ],
      ),
    );
  }

  Widget buildFinishSwitchBtn() {
    return Container(
        child: SingleChildScrollView(
      child: ToggleSwitch(
        minWidth: 80,
        radiusStyle: true,
        borderColor: [Colors.black],
        cornerRadius: 20,
        borderWidth: 2,
        activeBgColor: [HexColor("FF4D00")],
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.white,
        inactiveFgColor: Colors.black,
        initialLabelIndex: 0,
        totalSwitches: 2,
        labels: ['Saat ile', 'Dakika ile'],
        onToggle: (index) {
          print(index);
          if (index != null) {
            if (index == 1) {
              _postSaveController.selectHourTime.value = false;
            } else if (index == 0) {
              _postSaveController.selectHourTime.value = true;
            }
          }
        },
      ),
    ));
  }

  Widget buildFinishDateForm() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 10),
      child: Form(
          child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("FF4D00"), width: 2.0),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2)
        ],
        controller: _postSaveController.gameTimeController,
        onChanged: (value) {
          if (_postSaveController.selectHourTime.value) {
            if (value == null) {
              _postSaveController.gameTimeController.text = 1.toString();
            } else if (int.parse(value) > 24) {
              _postSaveController.gameTimeController.text = 24.toString();
            } else if (int.parse(value) < 1) {
              _postSaveController.gameTimeController.text = 1.toString();
            }
          } else {
            if (value == null) {
              _postSaveController.gameTimeController.text = 20.toString();
            } else if (int.parse(value) > 60) {
              _postSaveController.gameTimeController.text = 60.toString();
            } else if (int.parse(value) < 1) {
              _postSaveController.gameTimeController.text = 20.toString();
            }
          }
          _postSaveController.formListener();
        },
      )),
    );
  }

  Widget buildWantedCountForm() {
    return Container(
      child: Row(
        children: [
          Expanded(child: buildSelectWantedCountText()),
          Expanded(child: buildWantedForm())
        ],
      ),
    );
  }

  Widget buildSelectWantedCountText() {
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Text(
        "Aranan Kişi Sayısı",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildWantedForm() {
    return Container(
      height: 50,
      margin: EdgeInsets.only(left: 10),
      child: Form(
          child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("FF4D00"), width: 2.0),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2)
        ],
        controller: _postSaveController.wantedCountController,
        onChanged: (value) {
          if (value == null || int.parse(value) < 1) {
            _postSaveController.wantedCountController.text = "1";
          } else if (int.parse(value) > 20) {
            _postSaveController.wantedCountController.text = "20";
          }
          _postSaveController.formListener();
        },
      )),
    );
  }

  Widget buildExpFormText() {
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(right: 10),
      child: Text(
        "Açıklama",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildExpForm() {
    return Container(
      child: Form(
          child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 6,
        maxLength: 150,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor("FF4D00"), width: 2.0),
              borderRadius: BorderRadius.circular(5)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(5)),
        ),
        controller: _postSaveController.expController,
        onChanged: (value) {
          _postSaveController.formListener();
        },
      )),
    );
  }

  Widget buildContinueBtn() {
    if (!_postSaveController.continueBtnStatus.value) {
      return Container(
        width: 150,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey,
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              final snackBar = SnackBar(
                elevation: 6.0,
                behavior: SnackBarBehavior.floating,
                content: Text("Gerekli alanları doldur"),
                backgroundColor: Colors.red.withOpacity(0.7),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(pageContext).showSnackBar(snackBar);
            },
            child: Text(
              "Devam Et",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
      );
    }
    return Container(
      width: 150,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: Center(
        child: InkWell(
          onTap: (){
            _postSaveController.goLocationPage();
          },
          child: Text(
            "Devam Et",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }

  Future startDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().day - 1),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
      );
      if (time != null) {
        _postSaveController.setStartDate(
            DateTime(date.year, date.month, date.day, time.hour, time.minute));
      }
    }
  }

  AppBar buildTopBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Text(
        _postSaveController.selectCategoryViewModel.value.category,
        style: const TextStyle(color: Colors.black),
      ),
      bottom: PreferredSize(
        child: Container(
          color: Colors.grey.shade500,
          height: 0,
        ),
        preferredSize: const Size.fromHeight(4.0),
      ),
    );
  }
}
