class JWT{
  late String token;
  JWT({required this.token});
  Map<String,dynamic> json(){
    Map<String,dynamic> json={};
    json["token"]=token;
    return json;
  }
}