import 'package:flutter/material.dart';
import 'package:pcpc_shredding/widgets/navbarlogo.dart';
 

class NavigationBarMobile extends StatelessWidget {
  final String bankname;
  const NavigationBarMobile({Key key,this.bankname}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 80,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
               onPressed: () => Scaffold.of(context).openDrawer(), 
          ),
          NavBarLogo(bankname: this.bankname,)
        ],
      ),
    );
  }
}
