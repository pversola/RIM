import 'package:flutter/material.dart';

class TextIcons extends StatelessWidget {
  final Function(String) onTextChange;
  final IconData icon;
  final String hintText;
  const TextIcons({Key key, @required this.onTextChange,@required   this.icon,@required  this.hintText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(     
        child: TextField(
          onChanged: (text) {
            onTextChange(text);
          },
          decoration: InputDecoration(
              icon: Icon(icon),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 10.0),
              ),
              hintText: hintText),
        ),
      ),
    );
  }
}
