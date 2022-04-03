import 'package:gelirim/dao/api/model/enums/gender.dart';
import 'package:gelirim/dao/api/model/enums/role.dart';
import 'package:intl/intl.dart';

class UserResponseModel{
  late int id;
  late String name;
  late String email;
  late String imageName;
  late bool checkEmail;
  late Role role;
  DateTime? birthDate;
  Gender? gender;
  UserResponseModel(Map<String,dynamic> json){
    json["id"]!=null?id=json["id"]:id=0;
    json["name"]!=null?name=json["name"]:name=" ";
    json["email"]!=null?email=json["email"]:email=" ";
    json["checkEmail"]!=null?checkEmail=json["checkEmail"]:checkEmail=false;
    json["gender"]!=null?gender=_mapGender(json["gender"]):gender=Gender.NON;
    json["imageName"]!=null?imageName=json["imageName"]:imageName=" ";
    //TODO DATE
    if(json["birthDate"]!=null){
      var date=DateTime.fromMillisecondsSinceEpoch(json["birthDate"]);
      birthDate=date;
      print(date.toString());
    }else{
      birthDate=null;
    }
    print(imageName);
  }
  Gender _mapGender(String g){
    Gender gender=Gender.NON;
    switch(g){
      case "MALE":gender=Gender.MALE;break;
      case "FEMALE":gender=Gender.FEMALE;break;
    }
    return gender;
  }
}