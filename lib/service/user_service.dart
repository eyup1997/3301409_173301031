import 'dart:io';

import 'package:gelirim/dao/api/model/auth/jwt.dart';
import 'package:gelirim/dao/api/model/user/image_req_model.dart';
import 'package:gelirim/dao/api/model/user/image_res_model.dart';
import 'package:gelirim/dao/api/model/user/login_request_model.dart';
import 'package:gelirim/dao/api/model/user/login_res_model.dart';
import 'package:gelirim/dao/api/model/user/passwordupdate_request_model.dart';
import 'package:gelirim/dao/api/model/user/register_request_model.dart';
import 'package:gelirim/dao/api/model/user/user_update_req_model.dart';
import 'package:gelirim/dao/api/user_api.dart';
import 'package:gelirim/model/user/login_view_model.dart';
import 'package:gelirim/model/user/register_view_model.dart';
import 'package:gelirim/model/user/user_view_model.dart';
import 'package:gelirim/service/return_code.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService{
  static final UserService _api=UserService._internal();
  factory UserService(){
    return _api;
  }
  UserService._internal();
  final UserApi _userApi=UserApi();
  Future<LoginCode> login(LoginViewModel viewModel)async{
    var res=await _userApi.login(LoginRequestModel(username: viewModel.username, password: viewModel.password));
    if(res==null){
      ///NOT LOGIN
      return LoginCode.UNSUCCESSFUL;
    }
    LoginResponseModel responseModel=res;
    _updateJWT(responseModel.token);
    _updateAuth(viewModel.username, viewModel.password);
    return LoginCode.SUCCESSFUL;
  }
  Future<RegisterCode> register(RegisterViewModel viewModel)async{
    var regRes=await _userApi.register(RegisterRequestModel(password: viewModel.password, email: viewModel.email, name: viewModel.name));
    if(!regRes){
      return RegisterCode.UNSUCCESSFUL;
    }
    var loginRes=await _userApi.login(LoginRequestModel(username: viewModel.email, password: viewModel.password));
    if(loginRes==null){
      return RegisterCode.UNSUCCESSFUL;
    }
    LoginResponseModel responseModel=loginRes;
    _updateJWT(responseModel.token);
    _updateAuth(viewModel.email, viewModel.password);
    return RegisterCode.SUCCESSFUL;
  }
  Future<dynamic> checkAuth()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? t=preferences.getString("jwt");
    UserViewModel viewModel=UserViewModel();
    if(t==null){
      //TODO Repeat login
      if(preferences.getString("username")==null || preferences.getString("password")==null){
        //TODO Non login system
        return AuthCode.NON_AUTH;
      }else{
        var res=await _userApi.login(LoginRequestModel(username: preferences.getString("username")!, password: preferences.getString("password")!));
        if(res==null){
          return AuthCode.NON_AUTH;
        }else{
          _updateJWT(res.token);
          var resAuth=await _userApi.auth(JWT(token: res.token));
          if(resAuth==null){
            return AuthCode.NON_AUTH;
          }else{
            viewModel.id=resAuth.id;
            viewModel.gender=resAuth.gender;
            viewModel.checkEmail=resAuth.checkEmail;
            viewModel.birthDate=resAuth.birthDate;
            viewModel.email=resAuth.email;
            viewModel.name=resAuth.name;
            viewModel.imageName=resAuth.imageName;
            return viewModel;
          }
        }
      }
    }else{
      //TODO Check JWT
      var resAuth=await _userApi.auth(JWT(token: t));
      if(resAuth==null){
        if(preferences.getString("username")==null || preferences.getString("password")==null){
          //TODO Non login system
          return AuthCode.NON_AUTH;
        }else{
          var res=await _userApi.login(LoginRequestModel(username: preferences.getString("username")!, password: preferences.getString("password")!));
          if(res==null){
            return AuthCode.NON_AUTH;
          }else{
            _updateJWT(res.token);
            var resAuth=await _userApi.auth(JWT(token: res.token));
            if(resAuth==null){
              return AuthCode.NON_AUTH;
            }else{
              viewModel.id=resAuth.id;
              viewModel.gender=resAuth.gender;
              viewModel.checkEmail=resAuth.checkEmail;
              viewModel.birthDate=resAuth.birthDate;
              viewModel.email=resAuth.email;
              viewModel.name=resAuth.name;
              viewModel.imageName=resAuth.imageName;
              return viewModel;
            }
          }
        }
      }else{
        viewModel.id=resAuth.id;
        viewModel.gender=resAuth.gender;
        viewModel.checkEmail=resAuth.checkEmail;
        viewModel.birthDate=resAuth.birthDate;
        viewModel.email=resAuth.email;
        viewModel.name=resAuth.name;
        viewModel.imageName=resAuth.imageName;
        return viewModel;
      }
    }
  }

  Future<bool> profileUpdate(UserViewModel viewModel)async{
    await checkAuth();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    JWT jwt=JWT(token: preferences.getString("jwt")!);
    var res=_userApi.updateUser(jwt, UserUpdateReqModel(name: viewModel.name,birthDate: viewModel.birthDate,gender: viewModel.gender));
    return res;
  }

  Future<bool?> profileImageUpdate(File file)async{
    await checkAuth();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    JWT jwt=JWT(token: preferences.getString("jwt")!);
    return await _userApi.updateImage(jwt, ImageReqModel(file));
  }

  Future<ImageResModel> authImage()async{
    await checkAuth();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    JWT jwt=JWT(token: preferences.getString("jwt")!);
    return await _userApi.getAuthImg(jwt);
  }

  void _updateJWT(String token)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("jwt", token);
  }
  void _updateAuth(String username,String password)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("username", username);
    preferences.setString("password", password);
  }
  Future<bool> checkPassword(String password)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    if(preferences.getString("password")!=null && preferences.getString("password")==password){
      return true;
    }
    return false;
  }

  Future<bool> updatePassword(String newPassword,String oldPassword)async{
    checkAuth();
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? token=preferences.getString("jwt");
    var res=await _userApi.updatePass(JWT(token: token!),PasswordUpdateRequestModel(newPassword: newPassword, oldPassword: oldPassword));
    if(res){
      await preferences.setString("password", newPassword);
    }
    return res;
  }
  Future<JWT> getJWT()async{
      await checkAuth();
      SharedPreferences preferences=await SharedPreferences.getInstance();
      String? token=preferences.getString("jwt");
      return JWT(token: token!);
  }
  Future logout()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("password");
    preferences.remove("username");
    preferences.remove("jwt");
  }

}