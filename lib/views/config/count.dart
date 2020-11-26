import 'package:flutter/material.dart';

class Count extends StatelessWidget {
  final int count;
  final VoidCallback onCountSelected;
  final Function(int) onCountChange;
  final Function(String) onTextChange;

  Count({
    @required this.count,
    @required this.onCountChange,
    this.onTextChange,
    this.onCountSelected,
  });
//  final totalrooms = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            onCountChange(1);
          },
        ),
        FlatButton(
          child: Text("$count"),
          onPressed: () => onCountSelected(),
        ),
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            onCountChange(-1);
          },
        ),
        Container(
          height: 20,
          width: 100,
          child: TextField(
            onChanged: (text) {
              onTextChange(text);
            },
            // controller: totalrooms,
            decoration: InputDecoration(
                icon: Icon(Icons.home_work),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 5.0),
                ),
                hintText: 'จำนวน'),
          ),
        ),
      ],
    );
  }
}
