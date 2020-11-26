import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:pcpc_shredding/servervices/const.dart';
import 'package:pcpc_shredding/views/config/texticons.dart';

class ConfigPage extends StatefulWidget {
  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final myController = TextEditingController();
  final totalrooms = TextEditingController();
  int count = 0;
  String filltest = "";
  String feeunit = "";
  int totalroom = 0;
  /* postImage(files, url) async {
    // Find the mime type of the selected file by looking at the header bytes of the file
    final mimeTypeData =
        lookupMimeType(files.path, headerBytes: [0xFF, 0xD8]).split('/');
    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(url));
    final file = await http.MultipartFile.fromPath('image_url', files.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.fields['projectid'] = Constants.projectkey;
    imageUploadRequest.fields['levelid'] = widget.levelid;
    imageUploadRequest.fields['name'] = myController.text.toString();
    imageUploadRequest.fields['detail'] = "ทดสอบสร้างห้อง";
    imageUploadRequest.fields['realtime_key'] = widget.levelid.toString();
    imageUploadRequest.files.add(file);
    try {
      final streamedResponse = await imageUploadRequest.send();

      final response = await http.Response.fromStream(streamedResponse);
      print('Result: $response');
      if (response.statusCode != 200) {
        Navigator.of(context).pop();
        return null;
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e);
      return null;
    }
  } */

  _autoaddnew(int roomno) async {
    var url = Constants.ip + "classroom/autonew";
    var body2 = jsonEncode({
      "projectid": "5f02b3249dadaa5bd29f9b9c",
      "levelid": "5f02e27254a372430add1d86",
      "name": "119/" + roomno.toString().padLeft(3, "0"),
      "detail": "ห้องว่าง",
      "noti": "0",
      "status": "true",
      "statusclose": "false",
      "realtime_key": "xxx"
    });
    await http
        .post(url, headers: {"Content-Type": "application/json"}, body: body2)
        .then((http.Response response) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                    width: 800,
                    height: 800,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("ตั้งค่า",style: TextStyle(fontSize: 25),),
                              )],
                            ),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white60,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                              ),
                                            ),
                                            child: TextIcons(
                                                hintText: "ส่วนกลาง ตรวละ",
                                                icon: Icons.favorite,
                                                onTextChange: (String val) {
                                                  setState(() {
                                                    feeunit = val;
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 200,
                                              height: 30,
                                              child: Text(feeunit))
                                        ],
                                      ),
                                      Column(
                                        children: [],
                                      ),
                                    ],
                                  ),
                                 
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 45,
                                            color: Colors.white,
                                            child: TextIcons(
                                                hintText: "ค่าน้ำต่อหน่วย",
                                                icon: Icons.favorite,
                                                onTextChange: (String val) {
                                                  setState(() {
                                                    totalroom = int.parse(val);
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 200,
                                              height: 30,
                                              child: Text(feeunit))
                                        ],
                                      ),
                                      Column(
                                        children: [],
                                      ),
                                    ],
                                  ),
                                 
                                 
                                 
                                 
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 45,
                                            color: Colors.white,
                                            child: TextIcons(
                                                hintText: "จำนวนห้อง",
                                                icon: Icons.favorite,
                                                onTextChange: (String val) {
                                                  setState(() {
                                                    totalroom = int.parse(val);
                                                  });
                                                }),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                              width: 200,
                                              height: 30,
                                              child: Text(feeunit))
                                        ],
                                      ),
                                      Column(
                                        children: [],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            child: Center(
                                              child: FlatButton(
                                                onPressed: () async => {
                                                  for (var i = 0; i < 400; i++)
                                                    {_autoaddnew(i + 1)}
                                                },
                                                color: Colors.orange,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: <Widget>[
                                                    Icon(Icons.save),
                                                    Text("สร้าง")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
