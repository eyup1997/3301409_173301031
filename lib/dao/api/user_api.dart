import 'dart:io';
import 'dart:typed_data';
import 'package:gelirim/dao/api/model/user/image_res_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:gelirim/dao/api/endpoint/base_endpoint.dart';
import 'package:gelirim/dao/api/endpoint/user_endpoint.dart';
import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/user/forgotpassword_request_model.dart';
import 'package:gelirim/dao/api/model/user/forgotpasswordtoken_request_model.dart';
import 'package:gelirim/dao/api/model/user/image_req_model.dart';
import 'package:gelirim/dao/api/model/user/login_request_model.dart';
import 'package:gelirim/dao/api/model/user/login_res_model.dart';
import 'package:gelirim/dao/api/model/user/passwordreset_request_model.dart';
import 'package:gelirim/dao/api/model/user/passwordupdate_request_model.dart';
import 'package:gelirim/dao/api/model/user/register_request_model.dart';
import 'package:gelirim/dao/api/model/user/user_response_model.dart';
import 'package:gelirim/dao/api/model/user/user_update_req_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http/http.dart';

class UserApi {
  static final UserApi _api = UserApi._internal();
  factory UserApi() {
    return _api;
  }
  UserApi._internal();

  //Auth API
  Future<LoginResponseModel?> login(LoginRequestModel model) async {
    var _headers = _createHeaders();
    var _body = _mapEncode(model.mapJson());
    var response = await http.post(Uri.parse(UserEndpoint.login),
        body: _body, headers: _headers);
    if (response.statusCode != 200) {
      return null;
    }
    return LoginResponseModel(_jsonEncode(response));
  }

  //Home API
  Future<bool> register(RegisterRequestModel model) async {
    var _headers = _createHeaders();
    var _body = _mapEncode(model.mapJson());
    var response = await http.post(Uri.parse(UserEndpoint.register),
        body: _body, headers: _headers);

    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<UserResponseModel?> auth(JWT jwt) async {
    var _headers = _createHeadersByToken(jwt.token);
    var response =
        await http.get(Uri.parse(UserEndpoint.auth), headers: _headers);
    print("XXXXXX");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return UserResponseModel(_jsonEncode(response));
    }
    return null;
  }

  Future<bool?> forgotPassword(ForgotPasswordRequestModel model) async {
    return null;
  }

  Future<bool?> checkPssToken(ForgotPasswordTokenRequestModel model) async {
    return null;
  }

  Future<bool?> resetPassword(ResetPasswordRequestModel model) async {
    return null;
  }

  //User API
  Future<bool> updateUser(JWT jwt, UserUpdateReqModel model) async {
    var headers = _createHeadersByToken(jwt.token);
    var body = _mapEncode(model.mapJson());
    var res = await http.post(Uri.parse(UserEndpoint.update),
        body: body, headers: headers);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> updatePass(JWT jwt, PasswordUpdateRequestModel model) async {
    var header=_createHeadersByToken(jwt.token);
    var body=_mapEncode(model.mapJson());
    var res=await http.post(Uri.parse(UserEndpoint.updatePass),headers: header,body: body);
    if(res.statusCode==200){
      return true;
    }
    return false;
  }

  Future<bool> updateImage(JWT jwt, ImageReqModel model) async {
    var header=_createHeadersByToken(jwt.token);
   MultipartRequest request =
   MultipartRequest("post", Uri.parse(UserEndpoint.userImage));
   request.headers.addAll(header);
   request.files.add(MultipartFile.fromBytes(
       "image", Uint8List.fromList(await File(model.file.path).readAsBytes()),
       contentType: MediaType.parse("multipart/form-data"),
       filename: "test.jpg"));
   var res=await request.send();
   print("??????????");
   print(jwt.token);
   print(res.statusCode);
      if(res.statusCode!=200){
     return false;
   }
   return true;
  }

  Future<ImageResModel> getAuthImg(JWT jwt)async{
    var _headers = _createHeadersByToken(jwt.token);
    var response = await http.get(Uri.parse(UserEndpoint.userImage), headers: _headers);
    return ImageResModel(_jsonEncode(response));
  }

  Map<String, String> _createHeaders() {
    return <String, String>{"Content-Type": "application/json"};
  }

  Map<String, String> _createHeadersByToken(String token) {
    return <String, String>{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
  }

  String _mapEncode(Map<String, dynamic> map) {
    return jsonEncode(map);
  }

  Map<String, dynamic> _jsonEncode(http.Response res) {
    String source = Utf8Decoder().convert(res.bodyBytes);
    return json.decode(source);
  }
}
