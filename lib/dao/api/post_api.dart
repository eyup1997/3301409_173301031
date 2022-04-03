import 'package:gelirim/dao/api/endpoint/post_endpoint.dart';
import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/post/game.dart';
import 'package:gelirim/dao/api/model/post/post_req_model.dart';
import 'package:gelirim/dao/api/model/post/post_res_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';

import 'endpoint/user_endpoint.dart';

class PostApi{
  static final PostApi _api = PostApi._internal();
  factory PostApi() {
    return _api;
  }
  PostApi._internal();
  Future<List<GameCategoryResModel>?> getAllCategory()async{
    var header=_createHeaders();
    var res=await http.get(Uri.parse(PostEndpoint.allGameCategory),headers: header);
    if(res.statusCode==200){
      return GameCategoryResModel.getInstance(_jsonEncodeList(res));
    }
    return null;
  }
  Future<List<GameResModel>?> getGamesByCatId(int id)async{
    var header=_createHeaders();
    var res=await http.get(Uri.parse(PostEndpoint.allGameByCategory+id.toString()),headers: header);
    if(res.statusCode==200){
      return GameResModel.getInstace(_jsonEncodeList(res));
    }
    return null;
  }
  Future<bool> savePost(JWT jwt,PostReqModel model)async{
    var header=_createHeadersByToken(jwt.token);
    var body=_mapEncode(model.map());
    var res=await http.post(Uri.parse(PostEndpoint.savePost),headers: header,body: body);
    if(res.statusCode==200){
      return true;
    }
    return false;
  }
  Future<AuthPostResModel?> getAuthLastPost(JWT jwt)async{
    var header=_createHeadersByToken(jwt.token);
    var res=await http.get(Uri.parse(UserEndpoint.post),headers: header);
    if(res.statusCode==200){
      print("---------------------------");
      return AuthPostResModel(_jsonEncode(res));
    }
    return null;
  }
  Future<List<AuthPostResModel>?> getAuthPosts(JWT jwt)async{
    var header=_createHeadersByToken(jwt.token);
    var res=await http.get(Uri.parse(UserEndpoint.posts),headers: header);
    if(res.statusCode==200){
      return AuthPostResModel.mapList(_jsonEncodeList(res));
    }
    return null;
  }
  Future<AuthPostResModel?> getAuthPost(JWT jwt,int id)async{
    var header=_createHeadersByToken(jwt.token);
    var body=_mapEncode(<String,dynamic>{"id":id});
    var res=await http.post(Uri.parse(UserEndpoint.post),headers: header,body: body);
    print(res.body);
    if(res.statusCode==200){
      return AuthPostResModel(_jsonEncode(res));
    }
    return null;
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
  List<dynamic> _jsonEncodeList(http.Response response){
    String source = Utf8Decoder().convert(response.bodyBytes);
    return json.decode(source);
  }
}