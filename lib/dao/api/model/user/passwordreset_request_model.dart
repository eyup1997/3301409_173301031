class ResetPasswordRequestModel{
  late String newPassword;
  ResetPasswordRequestModel({required this.newPassword});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["newPassword"]=newPassword;
    return map;
  }
}