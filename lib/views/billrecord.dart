import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:flutter/material.dart';
import 'package:pcpc_shredding/servervices/const.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BillRecord extends StatefulWidget {
  final String checklistid;
  final String projecttype;
  BillRecord({Key key, this.checklistid, @required this.projecttype})
      : super(key: key);

  @override
  _BillRecordState createState() => _BillRecordState();
}

class _BillRecordState extends State<BillRecord> {
  bool isFav = false;
  var isLoading = false;
  var totalcheck = 0;
  String tabselectedname = "วิชา";
  String tabselectedeng = "course";
  List<BillModel> studenlist = List();
  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    var params = {
      "billid": widget.checklistid,
    };

    Uri uri = Uri.parse(Constants.ip + "classroom/billrecode/:billid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      studenlist = new List<BillModel>();
      var categoryJson =
          json.decode(response.body)['billlist'][0]['roomlist'][0] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        studenlist.add(new BillModel.fromJson(categoryJson[i]));
      }

      setState(() {});
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            "จดบลิ",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1, // this will be set when a new tab is tapped
          onTap: (int index) {
            setState(() {
              //   this.index = index;
              _onAlertButtonsPressed(context);
              print("ok");
            });
            // _navigateToScreens(index);
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: studenlist.length.toString()),
            BottomNavigationBarItem(
                icon: new Icon(Icons.save), label: 'บันทึก'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: totalcheck.toString())
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            //  scrollDirection: Axis.horizontal,
            // physics: NeverScrollableScrollPhysics(),

            itemCount: studenlist == null ? 0 : studenlist.length,
            itemBuilder: (BuildContext context, int index) {
              return
                  //    Map comment = comments[index];
                  ListTile(
                leading: CircleAvatar(
                  radius: 25.0,
                  //Image.network(
                  backgroundImage: NetworkImage(
                    Constants.ip +
                        studenlist[index].imageurl.replaceAll('\\', '//'),
                  ),
                ),
                title: Text(studenlist[index].name),
                trailing: Switch(
                  value: studenlist[index].status ? false : true,
                  onChanged: (v) async {
                    if (v) {
                      studenlist[index].status = false;

                      _countlist();
                    } else {
                      studenlist[index].status = true;

                      _countlist();
                    }
                  },
                  activeColor: Theme.of(context).accentColor,
                ),
                subtitle: Column(
                  children: <Widget>[
                    SizedBox(height: 7.0),
                    Text(
                      "xxxx",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  _countlist() {
    var b = 1;
    totalcheck = 0;
    for (int i = 0; i < studenlist.length; i++) {
      if (studenlist[i].status == true) {
        totalcheck += b;
      }
    }
    setState(() {});
  }

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "บันทึกการเช็คชื่อ",
      desc: "ต้องการบันทึกรายการเช็คชื่อใช่หรือ.",
      buttons: [
        DialogButton(
          child: Text(
            "ใช่",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "ยกเลิก",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}

class BillModel {
  String objid;
  String name;
  bool status;
  String imageurl;
  BillModel._({
    this.objid,
    this.name,
    this.status,
    this.imageurl,
  });
  factory BillModel.fromJson(Map<String, dynamic> json) {
    return new BillModel._(
      objid: json['roomid'],
      name: json['roomname'],
      status: json['status'],
      imageurl: json['img'],
    );
  }
}
