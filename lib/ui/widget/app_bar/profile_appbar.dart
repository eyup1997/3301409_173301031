import 'package:flutter/material.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  late AppBar appBar;
  ProfileAppBar({Key? key,required this.appBar}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
