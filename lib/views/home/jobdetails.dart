import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pcpc_shredding/models/boxdetail.dart';

import 'package:pcpc_shredding/models/shredingdetail.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:intl/intl.dart';

class JobDetails extends StatefulWidget {
  final String jobno;
  final String bankname;
  final String bankcode;
  JobDetails({Key key, @required this.jobno, this.bankcode, this.bankname})
      : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  TextEditingController nameController = TextEditingController();
  final ScrollController _controllerOne = ScrollController();
  final formatCurrency = new NumberFormat.simpleCurrency();
  bool _loadingInProgress = true;
  bool _noData = false;
  bool showboxcolor = false;
  bool showcolor = false;
  bool _showJob = true;
  int _gTotal = 0;
  double _gValue = 0;
  List<ShreddingDetailModel> shreddinglist = List();
  List<CheckInfoModel> checkinfolist = List();

  _getShreddingdetail(Object tmpData) {
    print(tmpData);
    _getShredding();
  }

  _getShredding() {
    setState(() {
      // _loadingInProgress = true;
      _noData = false;
    });
    GETAPI.getShredingDetail(widget.jobno).then((response) {
      setState(() {
        //  print(json.decode(response.body)['message']);
        if (json.decode(response.body)['message'].toString() != "[]") {
          List datas = json.decode(response.body)['message'];
          shreddinglist = (datas)
              .map((data) => new ShreddingDetailModel.fromJson(data))
              .toList();

          setState(() {
            for (var i = 0; i < shreddinglist.length; i++) {
              _gTotal = _gTotal + shreddinglist[i].totalchq;
              _gValue = _gValue + shreddinglist[i].totalvalue;
            }
            _loadingInProgress = false;
            _noData = false;
          });
        } else {
          setState(() {
            _noData = true;
            _loadingInProgress = false;
          });
        }
        /*   */
      });
    });
  }

  _getBoxDetail(String boxno) async {
    setState(() {
      // _loadingInProgress = true;
      _noData = false;
    });
    await GETAPI.getBoxDetail(boxno).then((response) {
      setState(() {
        //  print(json.decode(response.body)['message']);
        if (json.decode(response.body)['message'].toString() != "[]") {
          List datas = json.decode(response.body)['message'];
          checkinfolist =
              (datas).map((data) => new CheckInfoModel.fromJson(data)).toList();

          setState(() {
            for (var i = 0; i < checkinfolist.length; i++) {
              // print(checkinfolist[i].curBoxSetNo);
              _gTotal = 0;
              _gValue = 0;
            }
            _loadingInProgress = false;
            _noData = false;
          });
        } else {
          setState(() {
            _noData = true;
            _loadingInProgress = false;
          });
        }
        /*   */
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
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              height: 150,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  color: Colors.white,
                  width: 5, //                   <--- border width here
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0), //         <--- border radius here
                ),
              ),
            ),
            buildBody(),
            Positioned(
              top: 7,
              left: 80,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.home, color: Colors.green),
                ),
              ),
            ),

            Positioned(
              top: 7,
              left:  80,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _showJob = true;
                    });
                  },
                  child: _showJob
                      ? Container()
                      : Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child:
                              Icon(Icons.arrow_back_ios, color: Colors.green),
                        )),
            ),

            /// Logo
            Positioned(
              top: 50,
              left: 30,
              child: InkWell(
                  onTap: () {
                    setState(() {
                      _showJob = true;
                    });
                  },
                  child: Hero(
                    tag: widget.bankname,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 2, //                   <--- border width here
                        ),
                        borderRadius: BorderRadius.circular(15),
                        image: new DecorationImage(
                          image: new NetworkImage(
                                ServerStatus.imageUrl   
                         + widget.bankname + ".png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )),
            ),

            Positioned(
              top: 10,
              left: 280,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("ซองงานหมายเลข " + widget.jobno,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text("หมายเลขบาร์โค๊ตกล่องเช๊ค",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 40,
              left:600,
              child: Container(
                width: 200,
                height: 40,
                child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.white)),
                        labelText: 'Scan กล่องเช็ค',
                        prefixIcon: const Icon(
                          Icons.center_focus_weak,
                          color: Colors.green,
                        )),
                    onSubmitted: (value) {
                      POSTAPI.postShredingDetails(widget.jobno, value).then(
                            (resalt) => _getShreddingdetail(resalt.body),
                          );

                      // PATCHAPI.patchShreding(widget.jobno, false, false ) ;

                      nameController.clear();

                      setState(() {
                        FocusScope.of(context).previousFocus();
                      });
                      // or do whatever you want when you are done editing
                      // call your method/print values etc
                    }),
              ),
            )  
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    if (!_loadingInProgress) {
      return _noData
          ? Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 155),
              height: MediaQuery.of(context).size.height - 250,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(
                  color: Colors.white,
                  width: 5, //                   <--- border width here
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0), //         <--- border radius here
                ),
              ),
              child: Scrollbar(
                // isAlwaysShown: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 1000,
                      height: 50,
                      margin: EdgeInsets.only(top: 10),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 150,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("ลำดับ"),
                              )),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("หมายเลขกล่อง"),
                            ),
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("จำนวนเช็ค"),
                            ),
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("จำนวนเช็ค(เรียกคืน)"),
                            ),
                          ),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("รวมยอดเงิน"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Container(
                            width: 1000,
                            height: MediaQuery.of(context).size.height - 350,
                            decoration: new BoxDecoration(
                              color: Colors.white10,
                              border: Border.all(
                                color: Colors.green,
                                width:
                                    1, //                   <--- border width here
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(20.0),
                                bottomRight: const Radius.circular(20.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Text(
                                  "No Data !",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(
              margin:
                  EdgeInsets.only(left: 20, right: 20, top: 155, bottom: 20),
              height: MediaQuery.of(context).size.height - 50,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                border: Border.all(
                  color: Colors.white,
                  width: 5, //                   <--- border width here
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0), //         <--- border radius here
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 1000,
                      height: 50,
                      margin: EdgeInsets.only(top: 10),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 150,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("ลำดับ"),
                              )),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("หมายเลขกล่อง"),
                            ),
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("จำนวนเช็ค"),
                            ),
                          ),
                          Container(
                            width: 150,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("จำนวนเช็ค(เรียกคืน)"),
                            ),
                          ),
                          Container(
                            width: 200,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("รวมยอดเงิน"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: _showJob
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                new Container(
                                  width: 1000,
                                  height:
                                      MediaQuery.of(context).size.height - 350,
                                  decoration: new BoxDecoration(
                                    color: Colors.white10,
                                    border: Border.all(
                                      color: Colors.green,
                                      width:
                                          1, //                   <--- border width here
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Scrollbar(
                                      controller: _controllerOne,
                                      isAlwaysShown: true,
                                      child: new ListView.builder(
                                        itemCount: shreddinglist.length,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext ctxt, int index) =>
                                                buildJobBody(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Container(
                                  width: 1000,
                                  height:
                                      MediaQuery.of(context).size.height - 350,
                                  decoration: new BoxDecoration(
                                    color: Colors.white10,
                                    border: Border.all(
                                      color: Colors.green,
                                      width:
                                          1, //                   <--- border width here
                                    ),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: const Radius.circular(20.0),
                                      bottomRight: const Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Scrollbar(
                                      controller: _controllerOne,
                                      isAlwaysShown: true,
                                      child: new ListView.builder(
                                        itemCount: checkinfolist.length,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext ctxt, int index) =>
                                                buildBoxBody(index),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    Container(
                      width: 1000,
                      height: 70,
                      margin: EdgeInsets.only(top: 10),
                      decoration: new BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(20.0),
                          bottomRight: const Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("ยอดกล่องรวม"),
                                Text("ยอดเงินรวม"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(NumberFormat.decimalPattern()
                                    .format(_gTotal)),
                                Text(NumberFormat.decimalPattern()
                                    .format(_gValue))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
    } else {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
  }

  Widget buildBoxBody(index) {
    if ((index % 2) == 0) {
      showboxcolor = true;
    } else {
      showboxcolor = false;
    }

    return Row(
      children: [
        Container(
          color: showboxcolor ? Colors.blue.shade100 : Colors.red.shade50,
          width: 148,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: Text((index + 1).toString()),
          ),
        ),
        Container(
          color: showboxcolor ? Colors.blue.shade100 : Colors.red.shade50,
          width: 200,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Text(checkinfolist[index].curBoxSetNo),
            ),
          ),
        ),
        Container(
          color: showboxcolor ? Colors.blue.shade100 : Colors.red.shade50,
          width: 200,
          height: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: Text(checkinfolist[index].itmId),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildJobBody(index) {
    if ((index % 2) == 0) {
      showcolor = true;
    } else {
      showcolor = false;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 138,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Text((index + 1).toString()),
            ),
          ),
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 200,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                child: Text(shreddinglist[index].boxsetno),
              ),
            ),
          ),
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 150,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(shreddinglist[index].totalchq.toString()),
            ),
          ),
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 150,
            height: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(shreddinglist[index].totalreq.toString()),
            ),
          ),
          Container(
              color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
              width: 200,
              height: 30,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    NumberFormat.decimalPattern()
                        .format(shreddinglist[index].totalvalue),
                    style: new TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.right),
              )),
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 50,
            height: 30,
            child: SizedBox(
              height: 20.0,
              width: 20.0,
              child: IconButton(
                  padding: new EdgeInsets.all(0.0),
                  icon: Icon(Icons.list, color: Colors.blue),
                  tooltip: 'รายละเอียดภายในกล่อง',
                  onPressed: () {
                    setState(() {
                      _showJob = false;
                      _loadingInProgress = true;
                      _getBoxDetail(shreddinglist[index].boxsetno);
                    });
                  }),
            ),
          ),
          Container(
            color: showcolor ? Colors.blue.shade100 : Colors.red.shade50,
            width: 50,
            height: 30,
            child: SizedBox(
              height: 20.0,
              width: 20.0,
              child: IconButton(
                padding: new EdgeInsets.all(0.0),
                icon: Icon(Icons.delete, color: Colors.blue),
                tooltip: 'ลบกล่องออกจากซองงาน',
                onPressed: () {
                  DELETEAPI
                      .deleteShredingDetails(
                          widget.jobno, shreddinglist[index].boxsetno)
                      .then(
                        (resalt) => _getShreddingdetail(resalt),
                      );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
