import 'package:gelirim/model/enums.dart';

class PostReqModel{
  late int gameId;
  late DateTime startDate;
  late DateTime finishDate;
  late String explanation;
  late int wantedCount;
  late LocationType locationType;
  double? longitude;
  double? latitude;
  String? address;
  late int postTime;
  late PostTimeType timeType;
  Map<String,dynamic> map(){
    Map<String,dynamic> map={};
    map["gameId"]=gameId;
    map["startDate"]=startDate.toIso8601String();
    map["finishDate"]=finishDate.toIso8601String();
    map["timeType"]=timeType.toString().split(".").last;
    map["postTime"]=postTime;
    map["wantedCount"]=wantedCount;
    map["explanation"]=explanation;
    map["locationType"]=locationType.toString().split(".").last;
    if(locationType==LocationType.OPEN){
      map["lat"]=latitude;
      map["lon"]=longitude;
      map["address"]=address;
    }
    return map;
  }
}