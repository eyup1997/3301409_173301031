class ForgotPasswordTokenRequestModel{
  late String token;
  ForgotPasswordTokenRequestModel({required this.token});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["token"]=token;
    return map;
  }
}