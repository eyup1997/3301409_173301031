class PasswordUpdateRequestModel{
  late String newPassword;
  late String oldPassword;
  PasswordUpdateRequestModel({required this.newPassword,required this.oldPassword});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["newPassword"]=newPassword;
    map["oldPassword"]=oldPassword;
    return map;
  }
}