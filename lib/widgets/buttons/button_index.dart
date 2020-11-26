import 'package:flutter/material.dart';

class ButtonIndex extends StatelessWidget {
  final String _index;
  const ButtonIndex(this._index);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          
          color: Colors.green),
          
      child: Center(
          child: Text(
        this._index,
        style: TextStyle(color: Colors.white, fontSize: 16),
      )),
    );
  }
}
