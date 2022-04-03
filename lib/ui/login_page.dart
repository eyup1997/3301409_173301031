import 'package:flutter/material.dart';
import 'package:gelirim/controller/login_controller.dart';
import 'package:gelirim/ui/widget/unicorn_outline_button.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100,left: 35,),
              child: Text("Gelirim",style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),),
            ),
            buildPage(),
            Obx(()=>buildBtn()),
          ],
        ),
      ),
    );
  }
  Widget buildPage(){
    return Obx((){
      if(_loginController.loading.value){
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 500,
            width: 400,
            margin: EdgeInsets.only(top: 200, left: 35, right: 35),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6.0)
                ]),
            child: Center(
              child: LoadingBouncingLine.circle(size: 70,backgroundColor: Colors.blue,),
            ),
          ),
        );
      }else{
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 400,
            width: 400,
            margin: EdgeInsets.only(top: 200, left: 35, right: 35),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 3.0),
                      blurRadius: 6.0)
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildScreenSelect(),
                  buildScreen(),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
  Widget buildScreenSelect() {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 50),
            child: TextButton(
              onPressed: () {
                if (!_loginController.loginScreen.value) {
                  _loginController.changeScreen();
                }
              },
              child: buildLoginButton(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 50),
            child: TextButton(
              onPressed: () {
                if (_loginController.loginScreen.value) {
                  _loginController.changeScreen();
                }
              },
              child: buildRegisterButton(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildScreen() {
    return Obx(() {
      if (_loginController.loginScreen.value) {
        return buildLoginForm();
      } else {
        return buildRegisterForm();
      }
    });
  }

  Widget buildLoginButton() {
    return Obx(() {
      if (_loginController.loginScreen.value) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.blue),
              )),
          child: const Text(
            "Giriş Yap",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        );
      }
      return Container(
        child: const Text(
          "Giriş Yap",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    });
  }

  Widget buildRegisterButton() {
    return Obx(() {
      if (!_loginController.loginScreen.value) {
        return Container(
          decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: Colors.blue),
              )),
          child: const Text(
            "Kayıt Ol",
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        );
      }
      return Container(
        child: const Text(
          "Kayıt Ol",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    });
  }

  Widget buildLoginForm() {
    return Container(
      margin: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              buildLoginStatusText(),
              TextFormField(
                controller: _loginController.loginEmailController,
                onChanged: (String? value){
                  _loginController.loginEmailChange(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              buildEmailValidatorText(),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: _loginController.loginPasswordController,
                onChanged: (String? value){
                  _loginController.loginPasswordChange(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Şifre",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    return  Container(
      margin: EdgeInsets.all(30),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              controller: _loginController.registerEmailController,
              onChanged: (String? value){
                _loginController.registerEmailChange(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.email),
                hintText: "Email",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            buildUseEmailText(),
            buildEmailValidatorText(),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              controller: _loginController.registerPasswordController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              onChanged: (String? value){
                _loginController.registerPasswordChange(value);
              },
            ),
            buildPasswordValidatorText(),
            SizedBox(height: 20,),
            TextFormField(
              obscureText: true,
              onChanged: (String? value){
                _loginController.registerPasswordRepeatChange(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.lock),
                hintText: "Şifre Tekrar",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
            buildPasswordRepeatValidatorText(),

          ],
        ),

      ),
    );
  }

  Widget buildBtn(){
    if(_loginController.btnStatus.value){
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.only(top: 570),
          child: UnicornOutlineButton(
            strokeWidth: 4,
            radius: 100,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purpleAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.purple,
              size: 30,
            ),
            onPressed: () {
              if(_loginController.loginScreen.value){
                //Login
                _loginController.login();
              }else{
                //register
                _loginController.register();
              }
            },
          ),
        ),
      );
    }else{
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
  }
  Widget buildLoginStatusText(){
    if(_loginController.successLogin.value){
      return Container(
        margin: const EdgeInsets.only(top: 5,left: 3),
        child: const Text("Giriş asdf Hatalı",style: TextStyle(color: Colors.red),),
      );
    }
    else if(_loginController.errorLogin.value){
      return Container(
        margin: const EdgeInsets.only(top: 5,left: 3),
        child: const Text("Giriş Bilgileri Hatalı",style: TextStyle(color: Colors.red),),
      );
    }
    return const SizedBox(height: 0,width: 0,);
  }

  Widget buildUseEmailText(){
    if(_loginController.useEmail.value){
      return Column(
        children: [
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                margin: const EdgeInsets.only(top: 5,left: 10),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5,left: 3),
                child: const Text("Bu email kullanılıyor"),
              )
            ],
          ),
        ],
      );
    }
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }
  Widget buildEmailValidatorText(){
    if(!_loginController.emailValidatorTextStatus.value){
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: const EdgeInsets.only(top: 5,left: 10),
              decoration: BoxDecoration(
                  color: buildValidatorTextColor("email"),
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5,left: 3),
              child: const Text("Email formatında olmalı"),
            )
          ],
        ),
      ],
    );
  }
  Widget buildPasswordValidatorText(){
    if(!_loginController.passwordValidatorTextStatus.value){
      return const SizedBox(
        width: 0,
        height: 0,
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(top: 5,left: 10),
              decoration: BoxDecoration(
                  color: buildValidatorTextColor("minChar"),
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 3),
              child: Text("En az 6 karekter içermeli"),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(top: 5,left: 10),
              decoration: BoxDecoration(
                  color: buildValidatorTextColor("char"),
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 3),
              child: Text("En az 1 harf ve 1 rakam içermeli"),
            )
          ],
        ),
      ],
    );
  }
  Widget buildPasswordRepeatValidatorText(){
    if(!_loginController.passwordRepeatValidatorTextStatus.value){
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              margin: EdgeInsets.only(top: 5,left: 10),
              decoration: BoxDecoration(
                  color: buildValidatorTextColor("passwordRepeat"),
                  borderRadius: BorderRadius.circular(100)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5,left: 3),
              child: Text("Şifre ile tekrarı aynı olmalı"),
            )
          ],
        ),
      ],
    );
  }
  Color buildValidatorTextColor(String field){
    switch(field){
      case "minChar":
        if(_loginController.passwordMinChar.value){
          return Colors.green;
        }return Colors.red;
      case "char":
        if(_loginController.passwordChar.value){
          return Colors.green;
        }return Colors.red;
      case "passwordRepeat":
        if(_loginController.passwordRepeat.value){
          return Colors.green;
        }return Colors.red;
      case "email":
        if(_loginController.emailText.value){
          return Colors.green;
        }return Colors.red;
    }
    return Colors.red;
  }
}
