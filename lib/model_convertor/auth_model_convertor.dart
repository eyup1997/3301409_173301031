import 'package:gelirim/api/model/auth_model.dart';
import 'package:gelirim/model/auth_model.dart';
import 'package:gelirim/model/form_model/login_form_model.dart';
import 'package:gelirim/model/form_model/register_form_model.dart';

class AuthModelConvertor{
  static AuthLoginReqModel convert(LoginFormModel loginFormModel){
   return AuthLoginReqModel(username: loginFormModel.email,password: loginFormModel.password);
  }
  static AuthModel convertToAuth(AuthResModel authResModel){
    AuthModel model=AuthModel();
    model.gender=authResModel.gender;
    //model.birthDate=authResModel.birthDate;
    model.email=authResModel.email;
    model.name=authResModel.name;
    return model;
  }
  static AuthRegisterReqModel convertRegisterModel(RegisterFormModel registerFormModel){
    return AuthRegisterReqModel(email: registerFormModel.email, password: registerFormModel.password, name: registerFormModel.name);
  }
}