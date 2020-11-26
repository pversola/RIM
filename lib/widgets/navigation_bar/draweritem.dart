import 'package:flutter/material.dart';
 
import 'package:pcpc_shredding/widgets/navigation_bar/navbaritem.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 30),
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 10),
          NavBarItem(title),
        ],
      ),
    );
  }
}
