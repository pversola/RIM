import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcpc_shredding/models/subject_model.dart';
import 'package:pcpc_shredding/servervices/const.dart';
import 'package:pcpc_shredding/views/bills/billdetailbyroom.dart';
import 'package:pcpc_shredding/views/bills/billpayment.dart';

import 'package:pcpc_shredding/views/bills/billroom.dart';
import 'package:pcpc_shredding/views/rooms/roomqr.dart';
import 'package:http/http.dart' as http;

import 'package:universal_html/prefer_sdk/html.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintBillPayment extends StatefulWidget {
  @override
  _PrintBillPaymentState createState() => _PrintBillPaymentState();
}

class _PrintBillPaymentState extends State<PrintBillPayment> {
  TextEditingController nameController = TextEditingController();
  bool _billloadingInProgress = true;
  bool _loadingInProgress = true;
  ScrollController _rrectController = ScrollController();
  List<BillRoomModel> billroomlist = List();
  List<RoomModel> roomlist = List();

  _creatbill() async {
    var params = {
      "projectid": Constants.projectkey,
    };

    Uri uri = Uri.parse(Constants.ip + "classroom/project/:projectid");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      try {
        roomlist.clear();
        roomlist = (json.decode(response.body)['Classrooms'] as List)
            .map((data) => new RoomModel.fromJson(data))
            .toList();
        setState(() {});
      } on Exception catch (e) {
        print("throwing new error :" + e.toString());
        throw Exception("Error on server");
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _getPayRoom(String roomid) async {
    _billloadingInProgress = false;
    setState(() {});
    var params = {
      "projectid": Constants.projectkey,
      "roomid": roomid,
      "statuspay": "false",
    };

    Uri uri = Uri.parse(Constants.ip + "bills/roomidpay:roomidpay");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      try {
        billroomlist.clear();
        billroomlist = (json.decode(response.body)['expens_bill'] as List)
            .map((data) => new BillRoomModel.fromJson(data))
            .toList();
        _billloadingInProgress = true;
        setState(() {});
      } on Exception catch (e) {
        print("throwing new error :" + e.toString());
        throw Exception("Error on server");
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  _getRoom(String roomname) async {
    var params = {"projectid": Constants.projectkey, "name": roomname};

    Uri uri = Uri.parse(Constants.ip + "classroom/roomlikename:roomlikename");
    uri.replace(queryParameters: params);
    final newURI = uri.replace(queryParameters: params);
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    final response = await http.get(newURI, headers: headers);
    if (response.statusCode == 200) {
      try {
        roomlist.clear();
        roomlist = (json.decode(response.body)['Classrooms'] as List)
            .map((data) => new RoomModel.fromJson(data))
            .toList();
        setState(() {});
      } on Exception catch (e) {
        print("throwing new error :" + e.toString());
        throw Exception("Error on server");
      }
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    _creatbill();
  }

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
                onTap: () {},
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
                top: 120,
                left: 50,
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
                  top: 120,
                  left: 300,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[50], // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: InkWell(
                          onTap: () {
                            _getRoom(nameController.text);
                          },
                          child: SizedBox(
                              width: 40, height: 40, child: Icon(Icons.search)),
                        ),
                        onTap: () {},
                      ),
                    ),
                  )),

              Positioned(
                  top: 40,
                  left: 40,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[50], // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.arrow_back)),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )),

              ///   QR Code
              Positioned(
                  top: 80,
                  left: 40,
                  child: ClipOval(
                    child: Material(
                      color: Colors.blue[50], // button color
                      child: InkWell(
                        splashColor: Colors.red, // inkwell color
                        child: SizedBox(
                            width: 40, height: 40, child: Icon(Icons.qr_code)),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: false,
                              builder: (BuildContext context) => RoomsQr(),
                            ),
                          );
                        },
                      ),
                    ),
                  )),

              // แสดงรายละเอียด การจด
              Positioned(
                top: 170,
                left: 5,
                child: new Container(
                  width: (MediaQuery.of(context).size.width) - 10,
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
                                  "",
                                  style: new TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              )
                            ]),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          left: 20,
                                          right: 20,
                                          bottom: 5),
                                      child: Container(
                                        height: (MediaQuery.of(context)
                                                .size
                                                .height) -
                                            250,
                                        width: 350,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: DraggableScrollbar.rrect(
                                          controller: _rrectController,
                                          backgroundColor: Colors.blue,
                                          alwaysVisibleScrollThumb: true,
                                          //  isAlwaysShown: true,
                                          child: ListView.builder(
                                            controller: _rrectController,

                                            //  itemCount: 100,
                                            itemExtent: 120.0,
                                            shrinkWrap: true,
                                            primary: false,
                                            //  scrollDirection: Axis.horizontal,
                                            // physics: NeverScrollableScrollPhysics(),

                                            itemCount: roomlist == null
                                                ? 0
                                                : roomlist.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return
                                                  //    Map comment = comments[index];
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  height: 150,
                                                  width: 320,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors
                                                          .lightBlue[900]),
                                                  child: InkWell(
                                                    onTap: () {
                                                      ////   แจ้งรายละเอียดการจดข้อมูลภายในรอบนั้นๆ
                                                      _getPayRoom(
                                                          roomlist[index].id);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              child: BillRoom(
                                                                index: index,
                                                                roomimage: roomlist[
                                                                        index]
                                                                    .imageurl,
                                                                roomname:
                                                                    roomlist[
                                                                            index]
                                                                        .name,
                                                                status: false,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(children: [
                                                          Container(
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .av_timer,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Container(
                                                              child: Row(
                                                                  children: [
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await _getPayRoom(
                                                                          roomlist[index]
                                                                              .id);

                                                                      Printing.layoutPdf(
                                                                          onLayout: (format) => _generatePdf(
                                                                              format,
                                                                              roomlist[index].name));
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .print,
                                                                        color: Colors
                                                                            .white))
                                                              ]))
                                                        ]),
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
                                  ],
                                ),
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
                                                height: (MediaQuery.of(context)
                                                        .size
                                                        .height) -
                                                    250,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                          watermeter:
                                                              billroomlist[
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
                                            padding: const EdgeInsets.all(8.0),
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
                              ],
                            ),
                          ],
                        )
                      : Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
                        pw.Column(children: [pw.Text(title, style: myStyleH)])
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
                            children: [pw.Text("เลขมิเตอร์", style: myStyle)]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text(
                                  billroomlist[i].waterMeter.toString().trim(),
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
}

/* 
class  RoomModel {
/*   "_id": "5f7537729dca431c1cebb796",
            "projectid": "5f02b3249dadaa5bd29f9b9c",
            "levelid": "5f02e27254a372430add1d86",
            "name": "119/221",
            "detail": "ทดสอบสร้างห้อง",
            "noti": 0,
            "status": true,
            "statusclose": false, */


  String objId;
  String projectId;
  String name;
  String detail;
 
  RoomModel._({
    this.objId,
    this.projectId,
    this.name,
    this.detail,
    
 
  });
  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return new RoomModel._(
        objId: json['_id'],
        projectId: json['projectid'],
        name: json['name'],
        detail: json['detail'],
       );
  }
}

 */
