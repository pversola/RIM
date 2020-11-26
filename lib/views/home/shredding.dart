import 'dart:convert';
 

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:pcpc_shredding/models/shreding.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:pcpc_shredding/views/home/joblist.dart';

import 'jobdetails.dart';
// ignore_for_file: always_specify_types
// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
//import 'package:pcpc_shredding/views/home/joblist.dart';

class Shredding extends StatefulWidget {
  final String bankname;
  Shredding({Key key, this.bankname}) : super(key: key);

  @override
  _ShreddingState createState() => _ShreddingState();
}

class _ShreddingState extends State<Shredding> {
  final myjob = TextEditingController();
  final df = new DateFormat('dd-MM-yyyy');
  bool _loadingInProgress = false;

  double xx = 90;
  double _left = 20;
  double _top = 90;
  double _rightadd = 30;
  double _topadd = 75;

  bool selected = false;
  bool addselected = false;
  TextEditingController nameController = TextEditingController();
/*   double _right = 20;
  double _bottom = 20; */
/*   List<String> litems = [
    "CSP20200805",
    "CSP20200806",
    "CSP20200807",
    "CSP20200808"
  ];

  List<Key> keys = [
    Key("Network"),
    Key("NetworkDialog"),
    Key("Flare"),
    Key("FlareDialog"),
    Key("Asset"),
    Key("AssetDialog")
  ]; */

  List<Key> keys = [
    Key("Network"),
    Key("NetworkDialog"),
    Key("Flare"),
    Key("FlareDialog"),
    Key("Asset"),
    Key("AssetDialog")
  ];

  List<ShreddingModel> shreddinglist = List();
  _getShredding() {
    shreddinglist.clear();
    GETAPI.getShreding().then((response) {
      setState(() {
        print("get data : " + response.contentLength.toString());
        if (response.contentLength == 52) {
          _loadingInProgress = true;
        } else if (response.contentLength == 116) {
          _loadingInProgress = true;
        } else {
          if (json.decode(response.body)['message'].toString() != "[]") {
            List datas = json.decode(response.body)['message'];
            shreddinglist = (datas)
                .map((data) => new ShreddingModel.fromJson(data))
                .toList();
            _loadingInProgress = true;
            setState(() {});
          }
        }
      });
    });
  }

  initState() {
    super.initState();
    _getShredding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*   appBar: AppBar(
        title: const Text('Create Sherdding job'),
        elevation: 0,
        actions: [
          // action button
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showdialog();
            },
          ),
        ],
      ), */
      body: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
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
                              height: 100,
                              width: MediaQuery.of(context).size.width - 20,
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Image.asset(
                                        "assets/images/inventory.png",
                                        fit: BoxFit.cover),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Positioned(
                    top: 30,
                    left: 30,
                    child: new Container(
                      width: 230.0,
                      height: 40.0,
                      child: new Text('PCPC Sherdding.' + ServerStatus.bankCode,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0)),
                    ),
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
                                borderSide:
                                    new BorderSide(color: Colors.white)),
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
                                  width: 40,
                                  height: 40,
                                  child: Icon(Icons.search)),
                            ),
                            onTap: () {},
                          ),
                        ),
                      )),

                  Positioned(
                      top: 60,
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
                  ),

// Header
                  Positioned(
                    top: 155,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                      ),
                      child: JoblistPage(),
                    ),
                  ),

// Details
                  Positioned(
                    top: 200,
                    child: new Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 350.0,
                      decoration: new BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: new ListView.builder(
                          itemCount: shreddinglist.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctxt, int index) =>
                              buildBody(ctxt, index),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 75,
                    right: 75,
                    child: InkWell(
                      onTap: () {
                        xx = xx - 20;
                        setState(() {});
                      },
                      child: new Container(
                        width: 40.0,
                        height: 40.0,
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
                                new ExactAssetImage("assets/images/export.png"),
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
                        setState(() {});
                      },
                      child: new Container(
                        width: 40.0,
                        height: 40.0,
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
                                "assets/images/settings.png"),
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
                            width:
                                3, //                   <--- border width here
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(15.0),
                            bottomRight: const Radius.circular(15.0),
                          ),
                          image: new DecorationImage(
                              image:
                                  new ExactAssetImage("assets/images/home.png"),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                                  padding: const EdgeInsets.all(
                                                      18.0),
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
                                                              ServerStatus
                                                                  .bankAdd,
                                                              /*    overflow: TextOverflow.ellipsis, */

                                                              style: new TextStyle(
                                                                  color: Colors
                                                                      .grey),
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
        ),
      ),
    );
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
                                            _loadingInProgress = false;
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
                                                );
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

  BoxDecoration myBoxDecoration(int ww) {
    return BoxDecoration(
      color: Colors.green[ww],
      border: Border.all(
        color: Colors.green, //                   <--- border color
        width: 1.0,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(24.0) //         <--- border radius here
          ),
    );
  }

  Widget buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 200,
              child: Text("xxxx"),
            ),
            SizedBox(
              width: 200,
              child: Text("bbb"),
            )
          ],
        ),
      ],
    );
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 130,
            ),
            SizedBox(
              width: 200,
              child: Text(
                shreddinglist[index].shreddingjob,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                shreddinglist[index].totalBox.toString(),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  shreddinglist[index].totalChq.toString(),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              width: 160,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  DateFormat("yyyy-MM-dd").format(DateFormat("yyyy-MM-dd")
                      .parse(shreddinglist[index].createdate)),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              width: 140,
              // color: Colors.yellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: shreddinglist[index].statusshredding
                          ? IconButton(
                              padding: new EdgeInsets.all(0.0),
                              icon: Icon(Icons.delete_forever,
                                  color: Colors.grey),
                              tooltip:
                                  'ซองงานนี้ไม่สามารถลบได้\nเนื่องจากมีการเพิ่มกล่องและยืนยันไปแล้ว',
                              onPressed: () {
                                //  showconfirm(index);
                              },
                            )
                          : IconButton(
                              padding: new EdgeInsets.all(0.0),
                              icon: Icon(Icons.delete,
                                  color: ThemeData().accentColor),
                              tooltip: 'ลบซองงาน',
                              onPressed: () {
                                showconfirm(index);
                              },
                            )),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: IconButton(
                      padding: new EdgeInsets.all(2.0),
                      color: Colors.red,
                      icon: Icon(Icons.list, color: Colors.blue),
                      tooltip: 'รายละเอียดซองงาน',
                      onPressed: () {
                        _gotoDetail(index);

                        /*  showconfirm(index); */
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: IconButton(
                      padding: new EdgeInsets.all(2.0),
                      color: Colors.red,
                      icon: Icon(Icons.import_export, color: Colors.blue),
                      tooltip: 'รายละเอียดซองงาน',
                      onPressed: () {
                        _gotoDetail(index);

                        /*  showconfirm(index); */
                      },
                    ),
                  ),
                  /*       SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: IconButton(
                      padding: new EdgeInsets.all(0.0),
                      icon: Icon(Icons.account_box, color: Colors.cyanAccent),
                      tooltip: 'ลบซองงาน',
                      onPressed: () {
                        /*  showconfirm(index); */
                      },
                    ),
                  ), */
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _gotoDetail(int index) async {
    await Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute<bool>(
        fullscreenDialog: false,
        builder: (BuildContext context) => JobDetails(
          jobno: shreddinglist[index].shreddingjob,
          bankname: widget.bankname,
        ),
      ),
    );

    _getShredding();
  }

  showdialog() async {
    await showDialog<String>(
      context: context,
      child: new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                controller: myjob,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'ชื่อซองงาน', hintText: 'CSP20200801-1'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('บันทึก'),
              onPressed: () {
                //   litems.add(myjob.text);
                setState(() {
                  myjob.text = "";
                  Navigator.pop(context);
                });
              })
        ],
      ),
    );
  }

  showconfirm(int index) async {
    await showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              key: keys[3],
              image: Image.asset(
                "assets/images/delete.gif",
                fit: BoxFit.cover,
              ),
              entryAnimation: EntryAnimation.RIGHT,
              title: Text(
                'การลบซองงาน',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                'คุณต้องการลบซองงานหมายเลข ' +
                    shreddinglist[index].shreddingjob +
                    "\n ออกจากระบบ ใช่หรือไม่ ?",
                textAlign: TextAlign.center,
              ),
              onOkButtonPressed: () {
                //   litems.removeWhere((item) => item == litems[index]);

                DELETEAPI
                    .deleteShreding(
                      shreddinglist[index].shreddingjob,
                    )
                    .then(
                      (resalt) => _getShredding(),
                    );

                setState(() {
                  Navigator.of(context).pop();
                });
              },
            ));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    // const imageProvider = const  AssetImage('assets/images/home.png');

    var data = await rootBundle.load("assets/fonts/Sarabun-Medium.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(font: myFont);
    final pdf = pw.Document();
    
    for (var i = 0; i < 400; i++) {
      pdf.addPage(
        pw.Page(
          //    pageFormat: format,
          pageFormat: PdfPageFormat.a5,
          orientation: pw.PageOrientation.landscape,

          build: (context) {
            return pw.Container(
                child: pw.Row(children: [
              pw.SizedBox(
                width: 200,
                height: 200,
                child:  pw.Text(
                  "ห้องหมายเลข ที่ยังไม่ได้จ่ายค่าส่วนกลาง :" + i.toString(),style: myStyle
                ),
              ),
              pw.SizedBox(
                width: 200,
                child: pw.Text(
                  "Test Printing for RIM:" + i.toString(),
                ),
              ),
              pw.SizedBox(
                width: 200,
                child: pw.Text('ทดสอบบบบ' + i.toString(), style: myStyle),
              ),
            ]));
          },
        ),
      );
    }

    return pdf.save();
  }




}
