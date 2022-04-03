import 'package:gelirim/dao/api/model/enums/gender.dart';

class UserUpdateReqModel{
  late String name;
  DateTime? birthDate;
  Gender? gender;
  UserUpdateReqModel({required this.name,this.birthDate,this.gender});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["name"]=name;
    gender==null?gender=Gender.NON:gender=gender;
    map["gender"]=gender.toString().split(".").last;
    map["birthDate"]=(birthDate==null?"null":birthDate?.toIso8601String());
    return map;
  }
}