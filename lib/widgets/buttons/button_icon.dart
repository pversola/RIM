import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final IconData iconname;
  const ButtonIcon(this.iconname);


  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width:30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.green[200],
      ),
      child: Icon(
        this.iconname,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
