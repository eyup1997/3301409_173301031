class AuthLoginReqModel{
  String username;
  String password;
  AuthLoginReqModel({required this.username,required this.password});
  Map<String,dynamic> map(){
    Map<String,dynamic> map={};
    map["username"]=username;
    map["password"]=password;
    return map;
  }
}

class AuthRegisterReqModel{
  String email;
  String name;
  String password;
  AuthRegisterReqModel({required this.email,required this.password, required this.name});
  Map<String,dynamic> map(){
    Map<String,dynamic> map={};
    map["email"]=email;
    map["password"]=password;
    map["name"]=name;
    return map;
  }
}

class AuthLoginResModel{
  late String jwt;
  AuthLoginResModel(Map<String,dynamic> map){
    jwt=map["token"];
  }
}
class AuthResModel{
  late int id;
  late String name;
  late String email;
  late String gender;
  late String birthDate;
  AuthResModel(Map<String,dynamic> map){
    id=map["id"];
    name=map["name"];
    email=map["email"];
    map["gender"]==null?gender="":gender=map["gender"];
    map["birthDate"]==null? birthDate="":birthDate=map["birthDate"];
  }
}
class Token{
  String token;
  Token({required this.token});
}