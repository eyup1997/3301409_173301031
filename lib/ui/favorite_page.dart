import 'package:flutter/material.dart';
import 'package:gelirim/ui/widget/navigator_bar_widget.dart';

class FavoritePage extends StatelessWidget implements NavigatorBarWidget{
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Favorite Page"),
        ),
      ),
    );
  }
}
