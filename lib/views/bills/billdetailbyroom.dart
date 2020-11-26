import 'package:flutter/material.dart';

class BillDetailbyRoom extends StatelessWidget {
  final id;
  final commonFee;
  final waterUnit;
  final watermeter;
  final waterprice;
  final othexpense;
  final othdetails;
  const BillDetailbyRoom(
      {Key key,
      @required this.id,
      @required this.commonFee,
      @required this.waterUnit,
      @required this.watermeter,
      @required this.waterprice,
      @required this.othexpense,
      @required this.othdetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 300,
              height: 230,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  border: Border.all(width: 2.0, color: Colors.grey)),
                  
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("- ค่าส่วนกลาง")],
                        ),
                        Column(children: [Text(commonFee.toString())]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text("- หน่วยการใช้น้ำ")],
                        ),
                        Column(children: [Text(waterUnit.toString())]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text('- ค่าน้ำ\บาท')],
                        ),
                        Column(children: [Text(waterprice.toString())]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [Text('- เลขมิเตอร์ปัจจุบัน')],
                        ),
                        Column(children: [Text(watermeter.toString())]),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      decoration: BoxDecoration(color: Colors.green),
                      child: Row(                       
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text('ค่าใช้จ่ายอื่นๆ'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                othdetails,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Container(
                            width: 50,
                            child: Column(children: [
                              Text(
                                othexpense.toString(),
                              )
                            ])),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 220,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('รวมยอดสุทธิ',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        Container(
                            width: 50,
                            child: Column(children: [
                              Text(
                                (othexpense + waterprice + commonFee)
                                    .toString(),
                              )
                            ])),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
