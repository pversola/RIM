import 'package:flutter/material.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/navigationdrawer.dart';

class NavigationDrawerHeader extends StatelessWidget {
  const NavigationDrawerHeader({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 300,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 350,
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                )),
                child: Text("sdsdsdsd"),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: NavigationDrawer(),
          )
        ],
      ),
    );
  }
}
