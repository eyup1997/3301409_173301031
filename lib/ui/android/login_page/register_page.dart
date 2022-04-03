import 'package:flutter/material.dart';
import 'package:gelirim/controller/login_and_register_controller.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final LoginAndRegisterController _loginController =
      Get.put(LoginAndRegisterController());
  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            iconSize: 5,
            icon: Image.asset("assets/back_btn_dart.png"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: HexColor("151F36"),
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      backgroundColor: HexColor("151F36"),
      body: Obx(() => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 30,
            ),
            _buildLoginTxt(),
            _buildLoginForm(),
            SizedBox(
              height: 30,
            ),
            _buildLoginBtn(),
            SizedBox(
              height: 40,
            ),
            _buildOAuth(),
            //_buildVersion()
          ],
        ),
      ),
    );
  }

  Widget _buildLoginTxt() {
    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Text(
        "Kayıt Ol",
        style: TextStyle(color: Colors.white, fontSize: 35),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      margin: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              buildRegisterMessage(),
              //Email field
              TextFormField(
                controller: _loginController.registerEmailController,
                onChanged: (String? value) {
                  if (value != null) {
                    _loginController.listenerRegisterEmailForm(value);
                  }
                },
                decoration: emailDecoration(),
              ),
              buildEmailValidText(),
              //End email field

              SizedBox(
                height: 20,
              ),

              //Name field
              /* TextFormField(
                controller: _loginController.denemeNameController,
                onChanged: (String? value){
                  if(value!=null){
                    _loginController.listenerRegisterNameForm(value);
                  }
                },
                decoration: nameDecoration(),
              ),
              _buildNameValidText(),
              //End name field
              */
              TextFormField(
                controller: _loginController.denemeNameController,
                onChanged: (String? value) {
                  if (value != null) {
                    _loginController.listenerRegisterNameForm(value);
                  }
                },
                decoration: nameDecoration(),
              ),
              _buildNameValidText(),
              SizedBox(
                height: 20,
              ),

              //Password field
              TextFormField(
                controller: _loginController.registerPasswordController,
                obscureText: true,
                onChanged: (String? value) {
                  if (value != null) {
                    _loginController.listenerRegisterPasswordForm(value);
                  }
                },
                decoration: passwordDecoration(),
              ),
              buildPasswordValidText(),
              //End password field

              SizedBox(
                height: 20,
              ),

              //Password repeat field
              TextFormField(
                controller: _loginController.registerPasswordRepeatController,
                obscureText: true,
                onChanged: (String? value) {
                  if (value != null) {
                    _loginController.listenerRegisterPasswordRepeatForm(value);
                  }
                },
                decoration: passwordRepeatDecoration(),
              ),
              buildPasswordRepeatValidText(),
              //End password repeat field
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    if (!_loginController.registerBtnStatus.value) {
      return InkWell(
        onTap: () {},
        child: Container(
          height: 50,
          width: 200,
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              "Kayıt Ol",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      );
    } else if (_loginController.registerLoading.value) {
      return Container(
        height: 50,
        width: 200,
        margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.grey,
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return InkWell(
      onTap: () {
        _loginController.register();
      },
      child: Container(
        height: 50,
        width: 200,
        margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: HexColor("0DCD2C"),
        ),
        child: Center(
          child: Text(
            "Kayıt Ol",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildOAuth() {
    return Container(
      child: Column(
        children: [
          Text(
            "ya da",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: 250,
            child: Row(
              children: [
                Expanded(child: Image.asset("assets/facebook_icon.png")),
                Expanded(child: Image.asset("assets/google_icon.png")),
                Expanded(child: Image.asset("assets/twitter_icon.png")),
              ],
            ),
          )
        ],
      ),
    );
  }

  InputDecoration emailDecoration() {
    if (_loginController.registerEmailValidStatus.value) {
      //Valid email
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(
          Icons.alternate_email,
          color: Colors.white,
        ),
        hintText: "Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 2.0),
        ),
      );
    }
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(Icons.alternate_email),
      hintText: "Email",
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(7),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  InputDecoration nameDecoration() {
    if (_loginController.registerNameValidStatus.value) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        hintText: "Ad Soyad",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 2.0),
        ),
      );
    }
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: const Icon(Icons.person),
      hintText: "Ad Soyad",
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(7),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  InputDecoration passwordDecoration() {
    if (_loginController.registerPasswordValidStatus.value) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: "Şifre",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 2.0),
        ),
      );
    }
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(Icons.lock),
      hintText: "Şifre",
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(7),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  InputDecoration passwordRepeatDecoration() {
    if (_loginController.registerPasswordRepeatValidStatus.value) {
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.white,
        ),
        hintText: "Şifre Tekrar",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400, width: 2.0),
        ),
      );
    }
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      prefixIcon: Icon(Icons.lock),
      hintText: "Şifre Tekrar",
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(7),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  Widget buildEmailValidText() {
    if (_loginController.registerEmailValidStatus.value) {
      return Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Text(
            "Email formatında olmalı",
            style: TextStyle(color: Colors.red),
          )
        ],
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget _buildNameValidText() {
    if (_loginController.registerNameValidStatus.value) {
      return Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Text(
            "Ad Soyad alanı en az 6 karakter içermeli",
            style: TextStyle(color: Colors.red),
          )
        ],
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget buildPasswordValidText() {
    if (_loginController.registerPasswordValidStatus.value) {
      return Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Text(
            "Şifre en az 6 en fazle 12 karakter",
            style: TextStyle(color: Colors.red),
          )
        ],
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget buildPasswordRepeatValidText() {
    if (_loginController.registerPasswordRepeatValidStatus.value) {
      return Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Text(
            "Şifre tekrarı yanlış",
            style: TextStyle(color: Colors.red),
          )
        ],
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget buildRegisterMessage() {
    if (_loginController.usedEmail.value) {
      return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(3),
        color: Colors.grey.withOpacity(0.1),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Email kullanılıyor!",
                  style: TextStyle(color: Colors.red,fontSize: 17),
                ),
                SizedBox(height: 5,),
                InkWell(
                  child: Text("Şifremi unuttum",style: TextStyle(color: Colors.blue,fontSize: 16),),
                )
              ],
            ),
          ),
        ),
      );
    }
    return SizedBox();
  }
}
