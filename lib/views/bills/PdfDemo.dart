 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
class PdfDemo extends StatefulWidget {
  @override
  _PdfDemoState createState() => _PdfDemoState();
}

class _PdfDemoState extends State<PdfDemo> {

  var data;

    var myFont;
    var myStyle;
    var pdf;
    var bytes;
    var blob;
    loadData() async {
      data = await rootBundle.load("assets/fonts/THSarabun.ttf");
      myFont = pw.Font.ttf(data);
      myStyle = pw.TextStyle(font: myFont);
      pdf = pw.Document();
      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("รายการที่ต้องการจะจ่ายค่าเข่าติดต่อพนักงาน",
                  style: myStyle),
            );
          }));
      bytes = pdf.save();
      blob = html.Blob([bytes], 'application/pdf');
    }

  @override
    initState() {
      super.initState();
       loadData();
    }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Open"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, "_blank");
                html.Url.revokeObjectUrl(url);
              },
            ),
            RaisedButton(
              child: Text("Download"),
              onPressed: () {
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'some_name.pdf';
                html.document.body.children.add(anchor);
                anchor.click();
                html.document.body.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}