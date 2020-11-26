import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcpc_shredding/views/home/shredding.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/draweritem.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),
      child: ListView(
        children: <Widget>[
          DrawerItem('Home', Icons.home),
          InkWell(onTap: (){
            Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute<bool>(
                        fullscreenDialog: false,
                        builder: (BuildContext context) => Shredding(),
                      ),
                    );
          }, child: DrawerItem('Shredding Job', Icons.videocam)),
          DrawerItem('About', Icons.help),
          DrawerItem('Logout', Icons.exit_to_app),
        ],
      ),
    );
  }
}
