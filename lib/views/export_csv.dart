import 'dart:convert';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:pcpc_shredding/models/shreding.dart';
 
import 'package:pcpc_shredding/servervices/apiservice.dart';

class ExportCsv extends StatefulWidget {
  ExportCsv({Key key}) : super(key: key);

  @override
  _ExportCsvState createState() => _ExportCsvState();
}

class _ExportCsvState extends State<ExportCsv> {
  bool _loadingInProgress = false;
  List<ShreddingModel> shreddinglist = List();

  createexcel() {
    var excel = Excel.createExcel();

    Sheet sheetObject = excel['001'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#1AFF1A",
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single; // or Underline.Double

    var cell = sheetObject.cell(CellIndex.indexByString("A1"));
    cell.value = 8; // dynamic values support provided;
    cell.cellStyle = cellStyle;
    excel.encode().then((onValue) {
      File(join("/Users/siriwet.c/Desktop/HSBC/form1.xlsx"))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

  

  _getShredding() {
    GETAPI.getShredingId().then((response) {
      setState(() {
        print("test loading http");
        List datas = json.decode(response.body)['message'];
        print(json.decode(response.body)['message']);
        shreddinglist =
            (datas).map((data) => new ShreddingModel.fromJson(data)).toList();
        print(shreddinglist[0].shreddingjob);
        _loadingInProgress = true;
        setState(() {});
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
      appBar: AppBar(
        title: const Text('Export To CSV'),
      ),
      body: Center(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (!_loadingInProgress) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new Center(
        child: ListView.builder(
          itemCount: shreddinglist.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: FlutterLogo(size: 56.0),
              title: SelectableText(
                  (index + 1).toString() + " " + shreddinglist[index].shreddingjob),
              subtitle: SelectableText(shreddinglist[index].createdate),
              trailing: Icon(Icons.more_vert),
            );
          },
        ),
      );
    }
  }
}
