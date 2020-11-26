import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcpc_shredding/servervices/const.dart';
import 'package:http/http.dart' as http;

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Image img;
  final String imagefile;
  final String roomid;
  final String billid;
  final String projectid;
  final String roomname;
  const CustomDialogBox(
      {Key key,
      @required this.projectid,
      @required this.roomid,
      @required this.billid,
      @required this.roomname,
      this.title,
      this.descriptions,
      this.text,
      this.img,
      this.imagefile})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  final myChecklist = TextEditingController();
  @override
  void initState() {
    super.initState();
    this.myChecklist.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 400,
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding + 30,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: myChecklist,
                decoration: InputDecoration(
                  icon: Icon(Icons.list),
                  labelText: 'เลขมิเตอร์',
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      //  Navigator.of(context).pop();
                      _fetchDataBill();
                    },
                    child: Text(
                      widget.text,
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          top: 10,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                Constants.ip + widget.imagefile.replaceAll('\\', '//')),
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Future _fetchDataBill() async {
    var url1 = Constants.ip + "bills/delete:billbyid";
    var body1 = jsonEncode({
      "projectid": Constants.projectkey,
      "roomid": widget.roomid,
      "billid": widget.billid,
    });

    await http
        .post(url1, headers: {"Content-Type": "application/json"}, body: body1)
        .then(
      (http.Response response) {
        var url = Constants.ip + "bills/add:manualbills";
        var body2 = jsonEncode({
          "projectid": widget.projectid,
          "roomid": widget.roomid,
          "billid": widget.billid,
          "ownerid": "5f067135d6cc5d4ba1ce8bdf",
          "water_meter": myChecklist.text,
          "water_unit": "10",
          "water_price": "500",
          "common_fee": "600",
          "oth_expense": "140",
          "oth_details": "ค่าขนมน้องๆ",
          "roomname":widget.roomname
        });

        http
            .post(url,
                headers: {"Content-Type": "application/json"}, body: body2)
            .then((http.Response response) {
          Navigator.of(context).pop();
        });
      },
    );
  }
}
