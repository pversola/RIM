import 'package:flutter/material.dart';

class TestPDF extends StatefulWidget {
  final id;
  final commonFee;
  final waterUnit;
  final watermeter;
  final waterprice;
  final othexpense;
  final othdetails;

  const TestPDF(
      {Key key,
      this.id,
      this.commonFee,
      this.waterUnit,
      this.watermeter,
      this.waterprice,
      this.othexpense,
      this.othdetails})
      : super(key: key);
  @override
  _TestPDFState createState() => _TestPDFState();
}

class _TestPDFState extends State<TestPDF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
