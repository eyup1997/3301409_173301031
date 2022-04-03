import 'package:flutter/material.dart';
import 'package:gelirim/controller/page/post_save_controller.dart';
import 'package:gelirim/model/enums.dart';
import 'package:gelirim/model/post/post_view_model.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowNewPost extends StatelessWidget {
  late double height;
  late double width;
  late double fontSize1;
  late double fontSize2;
  PostSaveController _postSaveController = Get.put(PostSaveController());
  ShowNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    fontSize1 = (width * height) / 18044;
    fontSize2 = (width * height) / 22044;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Yeni Oyun Ön İzleme",
          style: const TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey.shade500,
            height: 0,
          ),
          preferredSize: const Size.fromHeight(4.0),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildTopInfo(),
              buildGameInfo(),
              buildLocationInfo(),
              SizedBox(height: height/40,),
              buildBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopInfo() {
    return Container(
        width: width / 1.05,
        height: height / 8,
        margin: EdgeInsets.only(top: height / 50),
        padding: EdgeInsets.only(top: 20, left: width / 20),
        decoration: BoxDecoration(
          color: HexColor("FF3641").withOpacity(0.6),
          borderRadius: BorderRadius.circular((width * height) / 50000),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "Oyun",
                      style: TextStyle(
                          fontSize: fontSize1, color: HexColor("FF00D6")),
                    ),
                  ),
                  Expanded(
                    child: Text("Kategori",
                        style: TextStyle(
                            fontSize: fontSize1, color: HexColor("FF00D6"))),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width / 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                        _postSaveController.postViewModel.value.gameName,
                        style: TextStyle(
                            fontSize: fontSize1, color: Colors.white)),
                  ),
                  Expanded(
                    child: Text(
                        _postSaveController.postViewModel.value.categoryName,
                        style: TextStyle(
                            fontSize: fontSize1, color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget buildGameInfo() {
    return Container(
      width: width / 1.05,
      height: height / 2.6,
      margin: EdgeInsets.only(top: height / 50),
      padding: EdgeInsets.only(top: height / 70, left: width / 30),
      decoration: BoxDecoration(
        color: HexColor("FF3641").withOpacity(0.6),
        borderRadius: BorderRadius.circular((width * height) / 50000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Oyun Bilgileri",
            style: TextStyle(color: Colors.white, fontSize: fontSize2),
          ),
          Container(
              color: Colors.grey,
              width: width / 1.13,
              height: height / 5.5,
              padding: EdgeInsets.only(left: width / 30, top: height / 55),
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            "İhtiyaç duyulan kişi sayısı",
                            style: TextStyle(
                                fontSize: fontSize1 / 1.2, color: Colors.black),
                          )),
                          Text("Başlama Zamanı",
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.black)),
                          Text("Bitiş zamanı",
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.black)),
                          Text("Oyun süresi",
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width / 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              _postSaveController
                                  .postViewModel.value.wantedCount
                                  .toString(),
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.white)),
                          Text(
                              _postSaveController.postViewModel.value.startDate
                                  .toString(),
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.white)),
                          Text(
                              _postSaveController.postViewModel.value.finishDate
                                  .toString(),
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.white)),
                          Text(
                              _postSaveController
                                      .postViewModel.value.postTime.time
                                      .toString() +
                                  (_postSaveController.postViewModel.value
                                              .postTime.timeType ==
                                          PostTimeType.HOUR
                                      ? " Saat"
                                      : " Dakika"),
                              style: TextStyle(
                                  fontSize: fontSize1 / 1.3,
                                  color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              )),
          Container(
            width: width / 1.13,
            height: 115,
            color: Colors.red,
            padding: EdgeInsets.only(left: width / 30, top: height / 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text("Açıklama"),
                ),
                Container(
                  height: 70,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(_postSaveController.postViewModel.value.explanation,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLocationInfo() {
    if(_postSaveController.postViewModel.value.locationType==LocationType.CLOSE){
      return Container(
        width: width / 1.05,
        height: height / 8,
        margin: EdgeInsets.only(top: height / 50),
        //padding: EdgeInsets.only(top: height/70, left: width / 30),
        decoration: BoxDecoration(
          color: HexColor("FF3641").withOpacity(0.6),
          borderRadius: BorderRadius.circular((width * height) / 50000),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Top info text
            Text(
              "Konum Bilgisi",
              style: TextStyle(color: Colors.white, fontSize: fontSize2),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Text("Adres ayarlanmadı"),
            ),

          ],
        ),
      );
    }
    return Container(
      width: width / 1.05,
      height: height / 2.6,
      margin: EdgeInsets.only(top: height / 50),
      //padding: EdgeInsets.only(top: height/70, left: width / 30),
      decoration: BoxDecoration(
        color: HexColor("FF3641").withOpacity(0.6),
        borderRadius: BorderRadius.circular((width * height) / 50000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Top info text
          Text(
            "Konum Bilgisi",
            style: TextStyle(color: Colors.white, fontSize: fontSize2),
          ),
          //Maps
          Container(
            margin: EdgeInsets.all(5),
            color: Colors.grey,
            height: height / 4.5,
            child: buildMaps(),
          ),
          //Address info text
          Container(
            margin: EdgeInsets.all(10),
            child: Text("Adres Tarifi"),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              _postSaveController.postViewModel.value.location.address,
              style: TextStyle(color: Colors.white),
            ),
          ),
          //address full
        ],
      ),
    );
  }

  Widget buildBtn() {
    return InkWell(
      onTap: (){
        _postSaveController.postSave();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: height/30),
        height: height/13,
        width: width/2.5,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular((width * height) / 50000),
        ),
        child: Center(
          child: Text("Ilanı Yayınla",style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  Widget buildMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: {_postSaveController.mapPlexMarker.value},
      initialCameraPosition: getMapPostion(),
      onTap: (value) {
        _postSaveController.setMarker(value);
      },
      onMapCreated: (GoogleMapController controller) {
        _postSaveController.googleMapController.value.complete(controller);
      },
    );
  }

  CameraPosition getMapPostion(){
    return CameraPosition(
      target: LatLng(_postSaveController.postViewModel.value.location.lat, _postSaveController.postViewModel.value.location.long),
      zoom: 14.3,
    );
  }
}
