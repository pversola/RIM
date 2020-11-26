import 'package:flutter/material.dart';

import 'package:pcpc_shredding/servervices/const.dart';

class BillRecord extends StatelessWidget {
  final int index;
  final bool status;
  final String roomname;
  final String roomimage;
  const BillRecord(
      {Key key,
      @required this.index,
      @required this.status,
      @required this.roomname,
      @required this.roomimage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        decoration: BoxDecoration(
          color: status == false ? Colors.indigo[900] : Colors.black12,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(40.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Column(children: [
                    Hero(
                      tag: roomimage,
                      child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              Constants.ip + roomimage.replaceAll('\\', '//'))),
                    )
                  ]),
                  //
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "ห้อง",
                            style: TextStyle(
                                // Colors.blue[(index * -1) % 9 * 100]
                                color: Colors.white),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(roomname,
                              style: TextStyle(color: Colors.white)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
