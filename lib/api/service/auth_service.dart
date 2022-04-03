import 'package:gelirim/api/status_code.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:gelirim/api/model/auth_model.dart';

class AuthService{
  static final AuthService _api = AuthService._internal();
  factory AuthService() {
    return _api;
  }
  AuthService._internal();

  Future<int> login(AuthLoginReqModel model)async{

    var auth=model.username+':'+model.password;
    String basicAuth='Basic '+base64Encode(utf8.encode(auth));
    var response = await http.get(Uri.parse("http://10.0.2.2:8080/api/auth"), headers: {HttpHeaders.authorizationHeader: basicAuth});
    if(response.statusCode==200){
      return SuccessfulStatusCode.login;
    }
    return ErrorStatusCode.login;
  }

  Future<dynamic> register(AuthRegisterReqModel model)async{
    var header=_createHeader();
    var body=_mapEncode(model.map());
    var response=await http.post(Uri.parse("http://10.0.2.2:8080/api/home/register"),headers: header,body: body);
    if(response.statusCode==200){
      return SuccessfulStatusCode.register;
    }
    return ErrorStatusCode.register;
  }


  Future<dynamic> auth(Token token)async{
    var _headers = _createHeadersByToken(token.token);
    var response = await http.get(Uri.parse(""), headers: _headers);
    if(response.statusCode==200){
      return AuthResModel(_jsonEncode(response));
    }else if(response.statusCode==401){
      return 401;
    }else if(response.statusCode==403){
      return 403;
    }
    return null;
  }

  String _mapEncode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }

  Map<String, dynamic> _jsonEncode(http.Response res) {
    String source = Utf8Decoder().convert(res.bodyBytes);
    return json.decode(source);
  }

  Map<String, String> _createHeadersByToken(String token) {
    return <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  Map<String,String> _createHeader(){
    return <String, String>{
      "Content-Type": "application/json"
    };
  }
}