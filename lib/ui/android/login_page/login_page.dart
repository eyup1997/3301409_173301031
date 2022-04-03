import 'package:flutter/material.dart';
import 'package:gelirim/controller/login_and_register_controller.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginAndRegisterController _loginController=Get.put(LoginAndRegisterController());
  LoginPage({Key? key}) : super(key: key);

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
      body: Obx((){
        return _buildPage(context);
      }),
    );
  }
  Widget _buildPage( BuildContext context){
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30,),
            _buildLoginTxt(),

            _buildLoginForm(),
            SizedBox(height: 30,),
            _buildLoginBtn(),
            SizedBox(height: 40,),
            _buildOAuth(),
            //_buildVersion()
          ],
        ),
      ),
    );
  }
  Widget _buildLoginTxt(){
    return Container(
      margin: EdgeInsets.only(left: 30),
      child: Text("Giriş Yap",style: TextStyle(color: Colors.white,fontSize: 35),),
    );
  }
  Widget _buildLoginForm(){
    return Container(
      margin: EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              _buildLoginMessage(),
              TextFormField(
                controller: _loginController.loginEmailController,
                onChanged: (String? value){
                  _loginController.listenersEmailField(value);
                },
                decoration:emailDecoration() ,
              ),
              emailValidText(),
              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                controller: _loginController.loginPasswordController,
                onChanged: (String? value){
                  _loginController.listenersPasswordField(value);
                },
                decoration: passwordDecoration(),
              ),
              passwordValidText(),
              SizedBox(height: 3,),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildLoginBtn(){
    if(_loginController.loginLoading.value){
     return Container(
        height: 50,
        width: 200,
        margin: EdgeInsets.only(left: 50,right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.grey,
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else if(_loginController.loginBtnStatus.value){
      return InkWell(
        onTap: (){
          _loginController.login();
        },
        child: Container(
          height: 50,
          width: 200,
          margin: EdgeInsets.only(left: 50,right: 50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: HexColor("0DCD2C"),
          ),
          child: Center(
            child: Text("Giriş Yap",style: TextStyle(color: Colors.white,fontSize: 20),),
          ),
        ),
      );
    }
    return InkWell(
      onTap: (){
      },
      child: Container(
        height: 50,
        width: 200,
        margin: EdgeInsets.only(left: 50,right: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.grey,
        ),
        child: Center(
          child: Text("Giriş Yap",style: TextStyle(color: Colors.white,fontSize: 20),),
        ),
      ),
    );
  }
  Widget _buildOAuth(){
    return Container(
      child: Column(
        children: [
          Text("ya da",style: TextStyle(fontSize: 20,color: Colors.white),),
          SizedBox(height: 10,),
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


  InputDecoration emailDecoration(){
    if(_loginController.emailValidStatus.value ){
      //Email valid
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(Icons.alternate_email,color: Colors.white,),
        hintText: "Email",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade400),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder:OutlineInputBorder(
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
      focusedBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }

  InputDecoration passwordDecoration(){
    if(_loginController.passwordValidStatus.value){
      //Password valid or wrong value
      return InputDecoration(
        filled: true,
        fillColor: Colors.red.shade400,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        prefixIcon: Icon(Icons.lock,color: Colors.white,),
        hintText: "Şifre",
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder:OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
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
      focusedBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
      ),
    );
  }
  Widget passwordValidText(){
    if(_loginController.passwordValidStatus.value){
      return Column(
        children: [
          SizedBox(height: 3,),
          Text("Şifre 6 karakter içermeli",style: TextStyle(color: Colors.red),)
        ],
      );
    }
    return SizedBox(height: 0,);
  }
  Widget emailValidText(){
    if(_loginController.emailValidStatus.value){
      return Column(
        children: [
          SizedBox(height: 3,),
          Text("Email formatında olmalı",style: TextStyle(color: Colors.red),)
        ],
      );
    }
    return SizedBox(height: 0,);
  }

  Widget _buildLoginMessage(){
    if(_loginController.wrongEmailOrPassword.value){
      return Container(
        margin: EdgeInsets.all(10),
        height: 30,
        color: Colors.grey.withOpacity(0.1),
        child: Center(child: Text("Giriş bilgileri hatalı",style: TextStyle(color: Colors.red),),),
      );
    }
    return SizedBox();
  }
}
