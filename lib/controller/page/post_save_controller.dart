import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gelirim/controller/page/post_show_controller.dart';
import 'package:gelirim/model/enums.dart';
import 'package:gelirim/model/post/game_view_model.dart';
import 'package:gelirim/model/post/post_view_model.dart';
import 'package:gelirim/service/post_service.dart';
import 'package:gelirim/ui/post_pages/auth_post_page.dart';
import 'package:gelirim/ui/post_save_pages/post_localtion_page.dart';
import 'package:gelirim/ui/post_save_pages/post_save_page.dart';
import 'package:gelirim/ui/post_save_pages/show_new_post.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class PostSaveController extends GetxController {
  PostService _postService = PostService();
  var loading = true.obs;
  var categoryViewModels = <GameCategoryViewModel>[].obs;
  var gameViewModels = <GameViewModel>[].obs;
  var selectCategoryViewModel = GameCategoryViewModel().obs;
  var postViewModel = PostViewModel().obs;
  var startDateSelect = false.obs;
  var startDateText = "".obs;
  var selectHourTime = true.obs;
  var gameTimeController = TextEditingController();
  var wantedCountController = TextEditingController();
  var expController = TextEditingController();
  var addressFullController = TextEditingController();
  var continueBtnStatus = false.obs;

  Rx<int> selectGameId = 1.obs;
  PostSaveController() {
    setCategories();
  }
  Future setCategories() async {
    categoryViewModels.value = await _postService.getAllCategory();
    loading.value = false;
    categoryViewModels.value.forEach((element) {
      print("x");
      print(element.category);
    });
  }

  void selectCategory(int index) async {
    loading.value = true;
    selectCategoryViewModel.value = categoryViewModels.value[index];
    gameViewModels.value =
        await _postService.getByCat(selectCategoryViewModel.value);
    loading.value = false;
    Get.to(PostSavePage());
  }

  List<DropdownMenuItem<int>> getGameDropMenu() {
    List<DropdownMenuItem<int>> items = [];
    gameViewModels.forEach((element) {
      items.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.id,
      ));
    });
    return items;
  }

  var selectGameName = " ".obs;
  void selectGame(int id) {
    selectGameId.value = id;
    postViewModel.value.gameId = id;
    gameViewModels.value.forEach((element) {
      if (id == element.id) {
        selectGameName.value = element.name;
      }
    });
    print(selectGameName.value);
  }

  void setStartDate(DateTime time) {
    startDateSelect.value = true;
    postViewModel.value.startDate = time;
    startDateText.value = "Tarih:" +
        postViewModel.value.startDate.year.toString() +
        "/" +
        postViewModel.value.startDate.month.toString() +
        "/" +
        postViewModel.value.startDate.day.toString() +
        "  Saat:" +
        postViewModel.value.startDate.hour.toString() +
        ":" +
        postViewModel.value.startDate.minute.toString();
    formListener();
  }

  void formListener() {
    if (postViewModel.value.gameId != null &&
        postViewModel.value.startDate != null &&
        wantedCountController.value.text.isNotEmpty &&
        expController.value.text.isNotEmpty) {
      if (!selectHourTime.value) {
        if (int.parse(gameTimeController.value.text) > 10) {
          continueBtnStatus.value = true;
          print("TRUE1");
        } else {
          continueBtnStatus.value = false;
          print("FALSE");
        }
      } else {
        continueBtnStatus.value = true;
        print("TRUE2");
      }
    } else {
      continueBtnStatus.value = false;
      print("FALSE");
    }
  }

  void goLocationPage() {
    Get.to(PostLocationSavePage());
  }

  void deneme(String s) {
    print(s.trim());
  }

  //TODO Location
  var selectMarkerStatus = false.obs;
  final CameraPosition googleMapCamera = CameraPosition(
    target: LatLng(37.87172, 32.49191),
    zoom: 14.3,
  );
  var googleMapController = Completer().obs;

  var mapPlexMarker = Marker(
          markerId: MarkerId("_mapPlex"),
          infoWindow: InfoWindow(title: "Oyun Alanı"),
          icon: BitmapDescriptor.defaultMarker,
          position: LatLng(55, 55))
      .obs;

  var addressFull = "ADRES".obs;
  void setMarker(LatLng latLng) {
    selectMarkerStatus.value = true;
    mapPlexMarker.value = Marker(
        markerId: MarkerId("_mapPlex"),
        infoWindow: InfoWindow(title: "Oyun Alanı"),
        icon: BitmapDescriptor.defaultMarker,
        position: latLng);
    deneme2(latLng);
  }

  void deneme2(LatLng latLng) async {
    Placemark placemark =
        (await placemarkFromCoordinates(latLng.latitude, latLng.longitude))[0];
    addressFull.value = placemark.administrativeArea.toString() +
        "/" +
        placemark.subAdministrativeArea.toString() +
        "/" +
        placemark.street.toString() +
        "/" +
        placemark.thoroughfare.toString() +
        "/No:" +
        placemark.name.toString();
    addressFullController.text = addressFull.value;
  }

  var locationNon = false.obs;

  void ctnShowPage() {
    postViewModel.value.gameName = selectGameName.value;
    postViewModel.value.categoryName = selectCategoryViewModel.value.category;
    postViewModel.value.explanation = expController.value.text;
    postViewModel.value.wantedCount=int.parse(wantedCountController.value.text);
    postViewModel.value.postTime.time=int.parse(gameTimeController.value.text);
    if (selectHourTime.value) {
      postViewModel.value.finishDate = postViewModel.value.startDate
          .add(Duration(hours: int.parse(gameTimeController.value.text)));
      postViewModel.value.postTime.timeType=PostTimeType.HOUR;
    } else {
      postViewModel.value.finishDate = postViewModel.value.startDate
          .add(Duration(minutes: int.parse(gameTimeController.value.text)));
      postViewModel.value.postTime.timeType=PostTimeType.MIN;
    }
    if(!locationNon.value){
      postViewModel.value.locationType=LocationType.OPEN;
      PostLocation location=PostLocation();
      location.address=addressFullController.value.text;
      location.lat=mapPlexMarker.value.position.latitude;
      location.long=mapPlexMarker.value.position.longitude;
      postViewModel.value.location=location;
    }else{
      postViewModel.value.locationType=LocationType.CLOSE;
    }
    Get.to(ShowNewPost());
  }
  void postSave(){
    PostService service=PostService();
    PostShowController postShowController;
    service.savePost(postViewModel.value).then((value) => {
      postShowController=Get.put(PostShowController()),
      postShowController.authPost.value=value!,
      Get.to(AuthPostPage()),
    });
  }
}
