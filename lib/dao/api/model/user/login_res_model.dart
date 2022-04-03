class LoginResponseModel{
  late String token;
  LoginResponseModel(Map<String,dynamic> json){
    json["token"]!=null?token=json["token"]:token="NULL";
  }
}