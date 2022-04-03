import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class DenemeController extends GetxController{
  //TODO ------------------- GEO
  var lat="FIND".obs;
  var long="FIND".obs;
  var address="FIND".obs;
  late StreamSubscription<Position> streamSubscription;
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getLocation();
  }

  getLocation()async{
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      await Geolocator.openLocationSettings();
      return Future.error("Location service disabled");
    }
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        return Future.error("Location permission denied");
      }
    }
    if(permission ==LocationPermission.deniedForever){
      return Future.error("-----------------");
    }
    streamSubscription=Geolocator.getPositionStream().listen((event) {
      lat.value=event.latitude.toString();
      long.value=event.longitude.toString();
       getAddress(event);
    });
  }

  Future<void> getAddress(Position position)async{
    List<Placemark> placemark=await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark addressPlacemark=placemark[0];
    address.value="Locality:"+addressPlacemark.locality.toString()+"----Country"+addressPlacemark.country.toString()+"----Street:"+addressPlacemark.street.toString()+
        "---Name:"+addressPlacemark.name.toString()+"----CADDE"+addressPlacemark.thoroughfare.toString()+"----AreaAdmin:"+addressPlacemark.administrativeArea.toString()+"---areaSub"+addressPlacemark.subAdministrativeArea.toString();;
  }

}