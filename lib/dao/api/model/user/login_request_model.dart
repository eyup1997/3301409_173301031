class LoginRequestModel{
  String username;
  String password;
  LoginRequestModel({required this.username,required this.password});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["username"]=username;
    map["password"]=password;
    return map;
  }
}