import 'package:gelirim/dao/api/endpoint/base_endpoint.dart';

class UserEndpoint{
  //Home
  static const String register=BaseEndpoint.base+"/home/register";
  static const String forgotPassword=BaseEndpoint.base+"/home/forgotPassword";
  static const String checkPassToken=BaseEndpoint.base+"/home/checkPasswordToken";
  static const String resetPass=BaseEndpoint.base+"/home/resetPassword";
  //Auth
  static const String login=BaseEndpoint.base+"/auth/login";
  //User
  static const String auth=BaseEndpoint.base+"/user";
  static const String update=BaseEndpoint.base+"/user";
  static const String userImage=BaseEndpoint.base+"/user/image";
  static const String updatePass=BaseEndpoint.base+"/user/password";
  static const String post=BaseEndpoint.base+"/user/post";
  static const String posts=BaseEndpoint.base+"/user/posts";
}