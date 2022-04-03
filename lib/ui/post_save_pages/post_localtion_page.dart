import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gelirim/controller/page/post_save_controller.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PostLocationSavePage extends StatelessWidget {

  PostSaveController _postSaveController=Get.put(PostSaveController());
  PostLocationSavePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        centerTitle: true,
        title: Text(
          _postSaveController.selectGameName.value,
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
      body: Obx((){
        return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(value: _postSaveController.locationNon.value,
                                onChanged: (value){
                                  _postSaveController.locationNon.value=value!;
                              }),
                            Text("Konum Kullanma")
                          ],
                        ),
                        buildGoogleMap(),
                        SizedBox(height: 20,),
                        buildAddressFormText(),
                        buildAddressFullForm(),
                        SizedBox(height: 20,),
                        buildContinueBtn()
                      ],
                    ),
                  ),
        );
      }),
    );
  }

  Widget buildGoogleMap(){
    if(_postSaveController.locationNon.value){
      return SizedBox(height: 20,);
    }
    if(_postSaveController.selectMarkerStatus.value){
      return Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
        ),
        height: 400,
        width: double.infinity,
        child: GoogleMap(
          gestureRecognizers:Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
          markers: {_postSaveController.mapPlexMarker.value},
          mapType: MapType.normal,
          initialCameraPosition: _postSaveController.googleMapCamera,
          onTap: (value){
            if(value!=null){
              _postSaveController.setMarker(value);
            }
          },
          onMapCreated: (GoogleMapController controller) {
            _postSaveController.googleMapController.value.complete(controller);
          },
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
      ),
      height: 400,
      width: double.infinity,
      child: GoogleMap(
        gestureRecognizers:Set()
          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
        mapType: MapType.normal,
        initialCameraPosition: _postSaveController.googleMapCamera,
        onTap: (value){
          _postSaveController.setMarker(value);
        },
        onMapCreated: (GoogleMapController controller) {
          _postSaveController.googleMapController.value.complete(controller);
        },
      ),
    );
  }
  Widget buildAddressFormText() {
    if(_postSaveController.locationNon.value){
      return SizedBox(height: 20,);
    }
    return Container(
      //color: Colors.black,
      width: double.infinity,
      margin: EdgeInsets.only(left: 20),
      child: Text(
        "Adres tarifi",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
  Widget buildAddressFullForm(){
    if(_postSaveController.locationNon.value){
      return SizedBox(height: 20,);
    }
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Form(
          child: TextFormField(
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("FF4D00"), width: 2.0),
                  borderRadius: BorderRadius.circular(5)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(5)),
            ),
            controller: _postSaveController.addressFullController,
            onChanged: (value) {
              _postSaveController.formListener();
            },
          )),
    );
  }
  Widget buildContinueBtn() {

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
            _postSaveController.ctnShowPage();
          },
          child: Text(
            "Devam Et",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }

}
