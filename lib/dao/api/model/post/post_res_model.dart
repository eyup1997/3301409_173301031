import 'package:gelirim/model/enums.dart';

class AuthPostResModel{
  late int id;
  late int gameId;
  late String gameName;
  late int categoryId;
  late String categoryName;
  late int wantedCount;
  late int acceptCount;
  late List<int> acceptUserIds=[];
  late List<int> requestUserIds=[];
  late LocationType locationType;
  late double lat;
  late double lon;
  late String address;
  late DateTime startDate;
  late PostTimeType timeType;
  late int time;
  late String explanation;

  AuthPostResModel(Map<String,dynamic> map){
    id=map["id"];
    gameId=map["gameId"];
    gameName=map["gameName"];
    wantedCount=map["wantedCount"];
    acceptCount=map["acceptCount"];
    categoryId=map["categoryId"];
    categoryName=map["categoryName"];
    explanation=map["explanation"];
    //acceptUserIds=map["acceptUser"];
    //requestUserIds=map["requestUser"];
    time=map["postTime"];
    locationType=_setLocationType(map["locationType"]);
    if(locationType==LocationType.OPEN){
      lat=map["lat"];
      lon=map["lon"];
      address=map["address"];
    }
    timeType=_setTimeType(map["timeType"]);
    startDate=_setStartDate(map["startDate"]);
  }
  static List<AuthPostResModel> mapList(List<dynamic> list){
    List<AuthPostResModel> models=[];
    list.forEach((element) {
      models.add(AuthPostResModel(element));
    });
    return models;
  }

  LocationType _setLocationType(String s){
    switch(s){
      case "CLOSE":return LocationType.CLOSE;
      case "OPEN":return LocationType.OPEN;
    }
    return LocationType.CLOSE;
  }
  PostTimeType _setTimeType(String s){
    switch(s){
      case "HOUR":return PostTimeType.HOUR;
      case "MIN":return PostTimeType.MIN;
    }
    return PostTimeType.HOUR;
  }
  DateTime _setStartDate(int time){
    return DateTime.fromMillisecondsSinceEpoch(time);
  }
}