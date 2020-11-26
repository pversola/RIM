import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcpc_shredding/models/subject_model.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:pcpc_shredding/servervices/const.dart';
import 'package:pcpc_shredding/views/billpopup/CustomDialogBox.dart';
import 'package:pcpc_shredding/views/bills/billdetailbyroom.dart';
import 'package:pcpc_shredding/views/bills/billrecord.dart';

import 'package:pcpc_shredding/views/bills/PdfDemo.dart';
import 'package:pcpc_shredding/views/config/config.dart';
import 'package:pcpc_shredding/widgets/buttons/button_icon.dart';
import 'package:pcpc_shredding/widgets/buttons/button_index.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class BillPayment extends StatefulWidget {
  final String bankname;
  final String backcode;
  const BillPayment({Key key, this.bankname, this.backcode}) : super(key: key);
  @override
  _BillPaymentState createState() => _BillPaymentState();
}

class _BillPaymentState extends State<BillPayment> {
  double xx = 90;
  bool _loadingInProgress = false;
  bool _billloadingInProgress = true;

  double _left = 20;
  double _top = 90;
  double _rightadd = 30;
  double _topadd = 75;
  String hh = "ห้องหมายเลขที่ยังไม่ได้จ่ายค่าส่วนกลาง :".toString().trim();
  String _details = "";
  bool selected = false;
  bool addselected = false;
  TextEditingController nameController = TextEditingController();

  List<BillRoomModel> billroomlist = List();
  List<SubjectModel> objdatalist = List();
  List<UsersModel> userlist = List();
  List<RoomModel> projectlist = List();
  List<ChecklistModel> checklist = List();
  List<BillModel> studenlist = List();
  final myChecklist = TextEditingController();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentyear;
  List _year = ["2020", "2021", "2022", "2023", "2024"];
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String year in _year) {
      items.add(
        new DropdownMenuItem(
          value: year,
          child: new Text(
            year,
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      );
    }
    return items;
  }

  String message;
  String channelId = "1000";
  String channelName = "FLUTTER_NOTIFICATION_CHANNEL";
  String channelDescription = "FLUTTER_NOTIFICATION_CHANNEL_DETAIL";

  bool isFav = false;
  var isLoading = false;
  String tabselectedname = "ห้องพัก";
  String tabselectedeng = "hotel_room";
  String jobid = "";
  SocketIO socketIO;

  String _roomid = "";

  Future<ChecklistModel> futureAlbum;

  Future _fetchData() async {
    //  'http://192.168.43.135:5050/classroom/roomlists/:projectid?projectid=5f02b3249dadaa5bd29f9b9c')
    var params = {
      "classroomid": "5f02dc4e54a372430add1d7e",
    };
    var paramsbill = {
      "projectid": Constants.projectkey,
    };
    Uri uri = Uri.parse(Constants.ip + "classroom/roomlists/:projectid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: paramsbill);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      /*   checklist.clear();
        List datas = json.decode(response.body);
        checklist = (datas)
            .map((data) => new ChecklistModel.fromJson(data['checklists']))
            .toList(); */

      print(json.decode(response.body)['billlist'] as List);

      checklist = (json.decode(response.body)['billlist'] as List)
          .map((data) => new ChecklistModel.fromJson(data))
          .toList();
      setState(() {
        _loadingInProgress = true;

        print(checklist.length);
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future _fetchDataBill(String roomkey) async {
    _billloadingInProgress = false;
    setState(() {});
    //  'http://192.168.43.135:5050/classroom/roomlists/:projectid?projectid=5f02b3249dadaa5bd29f9b9c')
    var params = {
      "classroomid": "5f02dc4e54a372430add1d7e",
    };

    _roomid = roomkey;
    var paramsbill = {
      "projectid": Constants.projectkey,
      'roomid': roomkey,
      'billid': jobid
    };
    Uri uri = Uri.parse(Constants.ip + "bills/billbyjobid:billbyjobid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: paramsbill);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['expens_bill'] as List);
      billroomlist.clear();
      billroomlist = (json.decode(response.body)['expens_bill'] as List)
          .map((data) => new BillRoomModel.fromJson(data))
          .toList();
      setState(() {
        _billloadingInProgress = true;
        print(billroomlist.length);
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _fetchDataDetails(String _id) async {
    jobid = _id;
    _loadingInProgress = false;
    setState(() {
      isLoading = true;
    });

    var params = {
      "billid": _id,
    };

    Uri uri = Uri.parse(Constants.ip + "classroom/billrecode/:billid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      studenlist.clear();
      billroomlist.clear();
      studenlist = new List<BillModel>();
      var categoryJson =
          json.decode(response.body)['billlist'][0]['roomlist'][0] as List;
      for (int i = 0; i < categoryJson.length; i++) {
        studenlist.add(new BillModel.fromJson(categoryJson[i]));
      }

      setState(() {
        _loadingInProgress = true;
        print(studenlist.length);
        print(studenlist.length);
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentyear = _dropDownMenuItems[0].value;
    super.initState();

    tabselectedname = "ผู้เช่า";
    tabselectedeng = "hotel_renter";
    _fetchData();
    // futureAlbum = fetchAlbum();
    print(futureAlbum);
    // _loadDatalist();
    socketIO = SocketIOManager().createSocketIO(Constants.ip, '/');
    //Call init before doing anything with socket
    socketIO.init();
    //Subscribe to an event to listen to
    socketIO.subscribe('5f02dc4e54a372430add1d7e', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      _fetchData();
      print("xxxx remain_group_a " + data["remain"]);
    });
    socketIO.connect();
  }

  _creatbill(BuildContext context) async {
    var params = {
      "projectid": Constants.projectkey,
    };

    Uri uri = Uri.parse(Constants.ip + "classroom/project:projectid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      try {
        projectlist = (json.decode(response.body)['Classrooms'] as List)
            .map((data) => new RoomModel.fromJson(data))
            .toList();
        setState(() {});
      } on Exception catch (e) {
        print("throwing new error :" + e.toString());
        throw Exception("Error on server");
      }

      /*  projectlist.clear(); 

      List datas = json.decode(response.body);
      projectlist = (datas)
          .map((data) => new UsersModel.fromJson(data['Classrooms'][0]))
          .toList();
      setState(() {}); */
    } else {
      throw Exception('Failed to load photos');
    }

    if (projectlist.length > 0) {
      var myList = List();
      for (int i = 0; i < projectlist.length; i++) {
        myList.add({
          "roomid": projectlist[i].id,
          "img": projectlist[i].imageurl,
          "roomname": projectlist[i].name,
          "meter_water": projectlist[i].water,
          "status_water": false,
          "status": false
        });
      }
      var url = Constants.ip + "projects/billlist";
      var body = jsonEncode({
        "projectid": Constants.projectkey,
        "detail": myChecklist.text,
        "roomlist": myList,
        "realtime_key": "create" //widget.classroomId.toString()
      });

      http
          .post(url, headers: {"Content-Type": "application/json"}, body: body)
          .then((http.Response response) {
        _fetchData();
        Navigator.of(context).pop();
      });
    }
  }

  ScrollController _rrectController = ScrollController();
  ScrollController _jobController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width - 10,
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/inventory.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(25.0),
                                bottomRight: Radius.circular(25.0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    CupertinoPageRoute<bool>(
                      fullscreenDialog: false,
                      builder: (BuildContext context) => PdfDemo(),
                    ),
                  );
                },
                child: Positioned(
                  top: 30,
                  left: 30,
                  child: new Container(
                    width: 230.0,
                    height: 40.0,
                    child: new Text('PCPC Sherdding.',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0)),
                  ),
                ),
              ),

              Positioned(
                top: 80,
                left: 250,
                child: new Container(
                    width: 230.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: new DropdownButton(
                        value: _currentyear,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    )),
              ),

              Positioned(
                top: 20,
                left: 250,
                child: new Container(
                  width: 230.0,
                  height: 40.0,
                  child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white)),
                        labelText: 'ค้นหาหมายเลขซองงาน',
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.green,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                      onSubmitted: (value) {
                        /*  print(value); */

                        // litems.add(nameController.text);

                        nameController.clear();

                        setState(() {
                          FocusScope.of(context).previousFocus();
                        });
                        // or do whatever you want when you are done editing
                        // call your method/print values etc
                      }),
                ),
              ),

              Positioned(
                  top: 20,
                  left: 485,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[50], // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: InkWell(
                          onTap: () {
                            Printing.layoutPdf(
                                onLayout: (format) => _generatePdf(
                                    format, "xxxx f sdfasdf sdfsd sdf "));
                          },
                          child: SizedBox(
                              width: 40, height: 40, child: Icon(Icons.search)),
                        ),
                        onTap: () {},
                      ),
                    ),
                  )),

              Positioned(
                  top: 80,
                  left: 485,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[50], // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.calendar_today)),
                        onTap: () {},
                      ),
                    ),
                  )),

              Positioned(
                top: 170,
                child: new Container(
                  width: 300,
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: new BoxDecoration(
                    color: Colors.blueGrey[900],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [SizedBox(height: 40)],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 280,
                              height: MediaQuery.of(context).size.height - 300,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 1, bottom: 1, left: 8, right: 8),
                                child: DraggableScrollbar.rrect(
                                  controller: _jobController,
                                  backgroundColor: Colors.blue,
                                  alwaysVisibleScrollThumb: true,
                                  child: ListView.builder(
                                    controller: _jobController,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: checklist == null
                                        ? 0
                                        : checklist.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          _details = checklist[index].detail;
                                          _fetchDataDetails(
                                              checklist[index].objid);
                                        },
                                        child: Container(
                                          width: 280,
                                          height: 80,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 28, bottom: 2),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 70,
                                                      width: 220,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: Colors
                                                              .yellow[200]),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                ButtonIndex(
                                                                    (index + 1)
                                                                        .toString()),
                                                                Text(checklist[
                                                                        index]
                                                                    .detail)
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5,
                                                                    right: 5),
                                                            child: Container(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        "2020-11-11",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blue[200]),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          _showCupertinoDialog(
                                                                              context,
                                                                              checklist[index].detail,
                                                                              checklist[index].objid);
                                                                        },
                                                                        child: ButtonIcon(
                                                                            Icons.delete),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    //  Text("bbbbb",style: TextStyle(color:Colors.white,fontSize: 30),)    ,
                                                    /*  ObjChecklist(                                       
                                                      indexrow: index + 1,
                                                      checklistid: checklist[index].objid,
                                                      name: checklist[index].detail,
                                                      objdate: checklist[index].objdate,
                                                      descryption: checklist[index].detail,
                                                      projecttype: 'hotel',
                                                      menutype: 'checklist',
                                                    ),    */
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

// แสดงรายละเอียด การจด
              Positioned(
                top: 170,
                left: 320,
                child: new Container(
                  width: (MediaQuery.of(context).size.width * 0.7) - 10,
                  height: MediaQuery.of(context).size.height - 200,
                  decoration: new BoxDecoration(
                    color: Colors.blueGrey[900],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: _loadingInProgress == true
                      ? Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _details,
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ]),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height) -
                                            250,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height) -
                                              300,
                                          width: 350,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          child: DraggableScrollbar.rrect(
                                            controller: _rrectController,
                                            backgroundColor: Colors.blue,
                                            alwaysVisibleScrollThumb: true,
                                            //  isAlwaysShown: true,
                                            child: ListView.builder(
                                              controller: _rrectController,

                                              //  itemCount: 100,
                                              // itemExtent: 80.0,
                                              shrinkWrap: true,
                                              primary: false,
                                              //  scrollDirection: Axis.horizontal,
                                              // physics: NeverScrollableScrollPhysics(),

                                              itemCount: studenlist == null
                                                  ? 0
                                                  : studenlist.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return
                                                    //    Map comment = comments[index];
                                                    Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            width: 200,
                                                            height: 80,
                                                            color: Colors.white,
                                                            child: InkWell(
                                                              onTap: () {
                                                                ////   แจ้งรายละเอียดการจดข้อมูลภายในรอบนั้นๆ
                                                                _fetchDataBill(
                                                                    studenlist[
                                                                            index]
                                                                        .objid);
                                                              },
                                                              child: BillRecord(
                                                                index: index,
                                                                roomimage:
                                                                    studenlist[
                                                                            index]
                                                                        .imageurl,
                                                                roomname:
                                                                    studenlist[
                                                                            index]
                                                                        .name,
                                                                status:
                                                                    studenlist[
                                                                            index]
                                                                        .status,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 80,
                                                          height: 80,
                                                          child: FlatButton(
                                                            onPressed:
                                                                () async => {
                                                              await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CustomDialogBox(
                                                                      roomname: studenlist[index]
                                                                              .name,
                                                                      projectid:
                                                                          Constants
                                                                              .projectkey,
                                                                      billid: this
                                                                          .jobid,
                                                                      roomid: studenlist[
                                                                              index]
                                                                          .objid,
                                                                      title: "จดบันทึก: " +
                                                                          studenlist[index]
                                                                              .name,
                                                                      descriptions:
                                                                          "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                                                                      text:
                                                                          "บันทึก",
                                                                      imagefile:
                                                                          studenlist[index]
                                                                              .imageurl,
                                                                    );
                                                                  }),
                                                              _fetchDataBill(
                                                                  _roomid)
                                                            },
                                                            color:
                                                                Colors.orange,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                Icon(Icons
                                                                    .calculate),
                                                                Text(
                                                                    "จดมิดเตอร์")
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 1, left: 1, right: 1),
                                          child: Container(
                                            width: 350,
                                            height: 48,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0),
                                              ),
                                              color: Colors.green,
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                    child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child:
                                                              Text("ยอดการจด"),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("8/400"),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(children: [
                                  Container(
                                    child: _billloadingInProgress
                                        ? Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 5),
                                                child: Container(
                                                  height:
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .height) -
                                                          250,
                                                  width: 350,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                  child: ListView.builder(
                                                      itemCount: billroomlist ==
                                                              null
                                                          ? 0
                                                          : billroomlist.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return BillDetailbyRoom(
                                                            commonFee:
                                                                billroomlist[
                                                                        index]
                                                                    .commonFee,
                                                            waterUnit:
                                                                billroomlist[
                                                                        index]
                                                                    .waterUnit,
                                                            watermeter: billroomlist[
                                                                    index]
                                                                .waterMeter,
                                                            waterprice:
                                                                billroomlist[
                                                                        index]
                                                                    .waterPrice,
                                                            othdetails:
                                                                billroomlist[
                                                                        index]
                                                                    .othDetails,
                                                            othexpense:
                                                                billroomlist[
                                                                        index]
                                                                    .othExpense,
                                                            id: billroomlist[
                                                                    index]
                                                                .objId);
                                                      }),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Container(
                                                    child:
                                                        CircularProgressIndicator(
                                                            backgroundColor:
                                                                Colors.blue)),
                                              ),
                                            ),
                                          ),
                                  ),
                                ]),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),

              /*             Positioned(
                top: 100,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(20.0),
                      bottomRight: const Radius.circular(20.0),
                    ),
                  ),
                ),
              ), */

              Positioned(
                top: 75,
                right: 75,
                child: InkWell(
                  onTap: () {
                    xx = xx - 20;
                    setState(() {
                   //   createexcel();
                    Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new ConfigPage()));
                   
                    });
                  },
                  child: new Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 2, //                   <--- border width here
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),
                      ),
                      image: new DecorationImage(
                        image: new ExactAssetImage("assets/images/export.png"),
                      ),
                    ),
                    /* child: Row(
                      children: [Text("Back")],
                    ), */
                  ),
                ),
              ),

              Positioned(
                top: 75,
                right: 120,
                child: InkWell(
                  onTap: () {
                    xx = xx + 20;
                    setState(() {
                      onaleartcreatbill(context);
                    });
                  },
                  child: new Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 2, //                   <--- border width here
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),
                      ),
                      image: new DecorationImage(
                        image:
                            new ExactAssetImage("assets/images/settings.png"),
                      ),
                    ),
                    /* child: Row(
                      children: [Text("Back")],
                    ), */
                  ),
                ),
              ),

//Home
              Positioned(
                top: 75,
                right: 165,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: new Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: new BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 3, //                   <--- border width here
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15.0),
                        bottomRight: const Radius.circular(15.0),
                      ),
                      image: new DecorationImage(
                          image: new ExactAssetImage("assets/images/home.png"),
                          fit: BoxFit.cover),
                    ),
                    /* child: Row(
                      children: [Text("Back")],
                    ), */
                  ),
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                left: _left,
                top: _top,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                      _left = selected ? 180 : 20;
                      _top = selected ? 60 : 90;
                    });
                  },
                  child: AnimatedContainer(
                    width: selected ? 360.0 : 120.0,
                    height: selected ? 570.0 : 120.0,
                    color: Colors.transparent,
                    alignment: AlignmentDirectional.topCenter,
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: Container(
                      width: selected ? 340.0 : 120.0,
                      height: selected ? 560.0 : 120.0,
                      child: Column(
                        children: [
                          Hero(
                            tag: widget.bankname,
                            child: Container(
                              width: selected ? 340.0 : 120.0,
                              height: selected ? 340.0 : 120.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width:
                                      2, //                   <--- border width here
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      15.0), //         <--- border radius here
                                ),
                                image: new DecorationImage(
                                  image: new NetworkImage(
                                      ServerStatus.imageUrl +
                                          widget.bankname +
                                          ".png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              child: selected
                                  ? Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 322,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.white,
                                                width:
                                                    5, //                   <--- border width here
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                    15.0), //         <--- border radius here
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(ServerStatus
                                                          .bankNameTh),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        height: 130,
                                                        child: Text(
                                                          ServerStatus.bankAdd,
                                                          /*    overflow: TextOverflow.ellipsis, */

                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                          maxLines: 5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Row(
                                      children: [],
                                    ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              _buildBody()
            ],
          ),
        ),
      ),
    );

    // ignore: dead_code
  }

  void changedDropDownItem(String selectedyear) {
    setState(() {
      _currentyear = selectedyear;
    });
  }

  Widget _buildBody() {
    if (_loadingInProgress) {
      return new
          //Add Job

          AnimatedPositioned(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        top: _topadd,
        right: _rightadd,
        child: InkWell(
          onTap: () {
            setState(() {
              addselected = !addselected;
              _rightadd = addselected ? 180 : 30;
              _topadd = addselected ? 120 : 75;
            });
            //  showdialog();
          },
          child: AnimatedContainer(
            alignment: AlignmentDirectional.topCenter,
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            width: addselected ? 550 : 40.0,
            height: addselected ? 250 : 40.0,
            child: Container(
              width: addselected ? 550 : 40.0,
              height: addselected ? 250 : 40.0,
              child: addselected
                  ? Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: addselected ? 450 : 40.0,
                              height: addselected ? 250 : 40.0,
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.white,
                                  width:
                                      2, //                   <--- border width here
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(80.0),
                                  bottomRight: const Radius.circular(80.0),
                                ),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(20),
                                          child: Text("กรุณากรอก หมายเลขซองงาน",
                                              style: TextStyle(fontSize: 20))),
                                      Container(
                                          margin: EdgeInsets.only(
                                              left: 50, right: 50),
                                          child: TextField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              border: OutlineInputBorder(),
                                              labelText: 'ซองงาน',
                                            ),
                                            onChanged: (text) {
                                              setState(() {
                                                //you can access nameController in its scope to get
                                                // the value of text entered as shown below
                                                //fullName = nameController.text;
                                              });
                                            },
                                          )),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: RaisedButton(
                                          onPressed: () {
                                            // litems.add(nameController.text);
                                            /*   _loadingInProgress = false;
                                            setState(() {});
                                            POSTAPI
                                                .postShreding(
                                                    nameController.text)
                                                .then(
                                                  (value) => setState(() {
                                                    nameController.text = "";
                                                    _getShredding();
                                                    addselected = !addselected;
                                                    _rightadd =
                                                        addselected ? 180 : 30;
                                                    _topadd =
                                                        addselected ? 120 : 75;
                                                  }),
                                                ); */
                                          },
                                          color: Colors.blue[100],
                                          child: const Text('เพิ่มซองงาน',
                                              style: TextStyle(fontSize: 16)),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              width: addselected ? 50 : 40.0,
                              height: addselected ? 50 : 40.0,
                              decoration: new BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.white,
                                  width:
                                      2, //                   <--- border width here
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(10.0),
                                  bottomRight: const Radius.circular(10.0),
                                ),
                                image: new DecorationImage(
                                  image: new ExactAssetImage(
                                      "assets/images/add.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: addselected ? 150 : 40.0,
                          height: addselected ? 150 : 40.0,
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: Colors.white,
                              width:
                                  2, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              bottomRight: const Radius.circular(10.0),
                            ),
                            image: new DecorationImage(
                              image:
                                  new ExactAssetImage("assets/images/add.png"),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            /* child: Row(
                          children: [Text("Back")],
                        ), */
          ),
        ),
      );
    } else {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
  }

  createexcel() {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['SheetName'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;

    // printing cell-type
    print("CellType: " + cell.cellType.toString());

    ///
    /// Inserting and removing column and rows

    // insert column at index = 8
    sheetObject.insertColumn(8);

    // remove column at index = 18
    sheetObject.removeColumn(18);

    // insert row at index = 82
    sheetObject.removeRow(82);

    // remove row at index = 80
    sheetObject.removeRow(80);
    String outputFile = "/Users/siriwet.c/Desktop/Oon/form1.xlsx";
    excel.encode().then((onValue) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

  Future onaleartcreatbill(context) async {
    await Alert(
        context: context,
        title: "สร้างรอบบิล",
        content: Column(
          children: <Widget>[
            TextField(
              controller: myChecklist,
              decoration: InputDecoration(
                icon: Icon(Icons.list),
                labelText: 'รอบบิล',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => _creatbill(context),
            child: Text(
              "สร้าง",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Future configroom(context) async {
    await Alert(
        context: context,
        title: "บันทึกค่าน้ำ",
        content: Column(
          children: <Widget>[
            TextField(
              controller: myChecklist,
              decoration: InputDecoration(
                icon: Icon(Icons.list),
                labelText: 'เลขมิเตอร์',
              ),
            )
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => _creatbill(context),
            child: Text(
              "บันทึก",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    // const imageProvider = const  AssetImage('assets/images/home.png');

    var data = await rootBundle.load("assets/fonts/THSarabun.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(font: myFont);
    var myStyleH = pw.TextStyle(font: myFont, fontSize: 20);
    final pdf = pw.Document();

    for (var i = 0; i < billroomlist.length; i++) {
      const imageProvider = const AssetImage('assets/images/settings.png');
      final PdfImage sig1 = await pdfImageFromImageProvider(
          pdf: pdf.document, image: imageProvider);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a5,
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          height: 20,
                          width: 20,
                          child: pw.BarcodeWidget(
                            data: jsonEncode({
                              "TypeQR": "bill",
                              "Reference": billroomlist[i].objId,
                              "ReferenceOwner": billroomlist[i].projectId,
                            }),
                            width: 150,
                            height: 150,
                            barcode: pw.Barcode.qrCode(),
                          ),
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Container(
                          height: 20,
                          width: 300,
                          decoration: const pw.BoxDecoration(
                            border: pw.BoxBorder(
                                bottom: true,
                                width: 0.5,
                                color: PdfColors.grey),
                          ),
                          child: pw.Image(sig1),
                        ),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Column(children: [pw.Text("xxx", style: myStyleH)])
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [pw.Text("ยอดค้างจ่าย", style: myStyle)]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].commonFee.toString().trim(),
                                  style: myStyle)
                            ])
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Column(
                            children: [pw.Text("ยอดรอบบิล", style: myStyleH)])
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [pw.Text("ค่าส่วนกลาง", style: myStyle)]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].commonFee.toString().trim(),
                                  style: myStyle)
                            ])
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [pw.Text("ค่าน้ำ", style: myStyle)]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].waterPrice.toString().trim(),
                                  style: myStyle)
                            ])
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].othDetails.toString().trim(),
                                  style: myStyle)
                            ]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].othExpense.toString().trim(),
                                  style: myStyle)
                            ])
                      ]),
                ],
              ),
            );
          },
        ),
      );
    }

/*     final file = File("example.pdf");
await file.writeAsBytes(pdf.save()); */
    return pdf.save();
  }

  _showCupertinoDialog(context, String _details, String objid) {
    showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
        title: new Text("แจ้งเตื่อนการลบ"),
        content: new RichText(
          text: TextSpan(
            text: 'คุณต้องการลบรอบบิล ',
            style: TextStyle(color: Colors.black),
            /*defining default style is optional */
            children: <TextSpan>[
              TextSpan(
                  text: _details,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blueAccent)),
              TextSpan(
                  text: ' ใช่หรือไม่', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text('Yes'),
              onPressed: () {
                var url = Constants.ip +
                    "projects/delete/billlist?projectid=" +
                    objid;
                /* var body = jsonEncode({
        "projectid": objid,
  
      }); */
                http.delete(url, headers: {
                  "Content-Type": "application/json"
                }).then((http.Response response) {
                  _fetchData();
                  setState(() {
                    studenlist.clear();
                    Navigator.pop(context);
                  });
                });
              }),
          CupertinoDialogAction(
              child: Text('No'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
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

class BillRoomModel {
  String objId;
  String projectId;
  String roomId;
  String billId;
  String ownerid;
  int waterMeter;
  int waterUnit;
  int waterPrice;
  int commonFee;
  int othExpense;
  String othDetails;
  String billtype;
  bool statusPay;
  bool statusApprove;
  BillRoomModel._({
    this.objId,
    this.projectId,
    this.roomId,
    this.billId,
    this.ownerid,
    this.waterMeter,
    this.waterUnit,
    this.waterPrice,
    this.commonFee,
    this.othExpense,
    this.othDetails,
    this.billtype,
    this.statusPay,
    this.statusApprove,
  });
  factory BillRoomModel.fromJson(Map<String, dynamic> json) {
    return new BillRoomModel._(
        objId: json['_id'],
        projectId: json['projectid'],
        roomId: json['roomid'],
        billId: json['billid'],
        ownerid: json['ownerid'],
        waterMeter: json['water_meter'],
        waterUnit: json['water_unit'],
        waterPrice: json['water_price'],
        commonFee: json['common_fee'],
        othExpense: json['oth_expense'],
        othDetails: json['oth_details'],
        billtype: json['bill_type'],
        statusPay: json['status_pay'],
        statusApprove: json['status_approve']);
  }
}
