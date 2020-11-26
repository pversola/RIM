import 'package:flutter/material.dart';

import 'package:pcpc_shredding/servervices/const.dart';

class BillRoom extends StatelessWidget {
  final int index;
  final bool status;
  final String roomname;
  final String roomimage;
  const BillRoom(
      {Key key,
      @required this.index,
      @required this.status,
      @required this.roomname,
      @required this.roomimage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:2.0,left: 2),
      child: Container(
        width: 200,
          decoration: BoxDecoration(
              color: status == false
                  ? Colors.brown[500]
                  : Colors.black12,
              borderRadius:     BorderRadius.only(
                 topLeft: Radius.circular(10.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(40.0),
            ),boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.4),
        spreadRadius: 2,
        blurRadius: 2,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(children: [
                      CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                              Constants.ip + roomimage.replaceAll('\\', '//')))
                    ]),
                    //
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "เบอร์ห้อง",
                              style: TextStyle(
                                // Colors.blue[(index * -1) % 9 * 100]
                                  color:Colors.white),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(roomname,
                                style: TextStyle(color: Colors.black38)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )

          /*  child: ListTile(
                                                        leading: CircleAvatar(
                                                          radius: 30.0,
                                                          //Image.network(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            Constants.ip +
                                                                studenlist[index]
                                                                    .imageurl
                                                                    .replaceAll(
                                                                        '\\', '//'),
                                                          ),
                                                        ),
                                                        title: Text(
                                                          studenlist[index].name,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black38),
                                                        ),
                                                        trailing: Switch(
                                                          value: studenlist[index]
                                                                  .status
                                                              ? false
                                                              : true,
                                                          onChanged: (v) async {
                                                            if (v) {
                                                              studenlist[index]
                                                                  .status = false;

                                                              //  _countlist();
                                                            } else {
                                                              studenlist[index]
                                                                  .status = true;

                                                              //  _countlist();
                                                            }
                                                          },
                                                          activeColor:
                                                              Theme.of(context)
                                                                  .accentColor,
                                                        ),
                                                        subtitle: Column(
                                                          children: <Widget>[
                                                            SizedBox(height: 7.0),
                                                            Text(
                                                              "xxxx",
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentColor,
                                                              ),
                                                              maxLines: 3,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ), */
          ),
    );
  }
}
