import 'package:flutter/material.dart';
import 'package:gelirim/ui/android/login_page/login_page.dart';
import 'package:gelirim/ui/android/login_page/register_page.dart';
import 'package:gelirim/ui/android/login_page/widget/oauth_btn_widget.dart';
import 'package:gelirim/ui/widget/hex_color.dart';
import 'package:get/get.dart';

class LoginRegisterSelectPage extends StatelessWidget {
   LoginRegisterSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("151F36"),
      body: _buildPage(),
      //bottomNavigationBar: BottomAppBar(
      //         child:Container(
      //           color: HexColor("151F36"),
      //           child: Text("rrrrrrrrr"),
      //         ),
      //         elevation: 0,
      //       ),
    );
  }

  Widget _buildPage(){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 100,),
          _buildGelirimText(),
          SizedBox(height: 100,),
          _buildLoginBtn(),
          SizedBox(height: 50,),
          _buildRegisterBtn(),
          SizedBox(height: 50,),
          _buildOAuth(),
        ],
      ),
    );
  }

  Widget _buildGelirimText(){
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20),
      child: Image.asset('assets/gelirim_first_text.png'),
    );
  }

  Widget _buildLoginBtn(){
    return InkWell(
      onTap: (){
        Get.to(LoginPage());
      },
      child: Container(
        height: 50,
        width: 300,
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

   Widget _buildRegisterBtn(){
     return InkWell(
       onTap: (){
        Get.to(RegisterPage());
       },
       child: Container(
         height: 50,
         width: 300,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(7),
           color: HexColor("FFFFFF"),
         ),
         child: Center(
           child: Text("Kayıt Ol",style: TextStyle(color:HexColor("0DCD2C") ,fontSize: 20),),
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

   Widget _buildVersion(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text("aAAsd"),
    );
   }

}
