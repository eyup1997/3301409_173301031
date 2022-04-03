import 'package:gelirim/api/model/auth_model.dart';
import 'package:gelirim/api/service/auth_service.dart';
import 'package:gelirim/api/status_code.dart';
import 'package:gelirim/model/auth_model.dart';
import 'package:gelirim/model/form_model/login_form_model.dart';
import 'package:gelirim/model/form_model/register_form_model.dart';
import 'package:gelirim/model/jwt_model.dart';
import 'package:gelirim/model_convertor/auth_model_convertor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController{
  final AuthService  _authService=AuthService();
  var box=GetStorage();
  var authModel=AuthModel().obs;


  Future<bool> login(LoginFormModel loginFormModel)async{
    var response=await _authService.login(AuthModelConvertor.convert(loginFormModel));
    if(response==SuccessfulStatusCode.login){
      box.write("username", loginFormModel.email);
      box.write("password", loginFormModel.password);
      return true;
    }
    return false;

  }
  Future<bool> checkAuth()async{
    if(box.read("username")==null || box.read("password")==null){
      return false;
    }
      return await login(LoginFormModel(password: box.read("password"), email: box.read("username")));
  }

  Future<bool> register(RegisterFormModel registerFormModel)async{
    var serviceResponse=await _authService.register(AuthModelConvertor.convertRegisterModel(registerFormModel));
    if(serviceResponse==SuccessfulStatusCode.register){
      box.write("username",registerFormModel.email);
      box.write("password", registerFormModel.password);
      return true;
    }
    return false;
  }
}