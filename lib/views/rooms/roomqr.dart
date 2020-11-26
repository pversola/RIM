import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RoomsQr extends StatefulWidget {
  @override
  _RoomsQrState createState() => _RoomsQrState();
}

class _RoomsQrState extends State<RoomsQr> {
  @override
  Widget build(BuildContext context) {
     /*    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;   */
    return Scaffold(
      body: GridView.count(
      
        crossAxisCount:6 ,
      
        children: List.generate(50,(index){
      
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
      width: 100,
      height: 100,
              child: QrImage(
                    data: "xxxxxxxx",
                    version: QrVersions.auto,
                    size:   100.0,)
      
            ),
          );
      
        }),
      
      ),
    );
  }
}
