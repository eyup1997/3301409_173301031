class RegisterRequestModel{
  late String email;
  late String name;
  late String password;
  RegisterRequestModel({required this.password,required this.email,required this.name});
  Map<String,dynamic> mapJson(){
    Map<String,dynamic> map={};
    map["password"]=password;
    map["name"]="asd";
    map["email"]=email;
    return map;
  }
}