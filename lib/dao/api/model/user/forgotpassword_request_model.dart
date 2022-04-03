class ForgotPasswordRequestModel{
  late String email;
  ForgotPasswordRequestModel({required this.email});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["email"]=email;
    return map;
  }
}