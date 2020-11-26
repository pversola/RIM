import 'package:flutter/material.dart';

class JoblistPage extends StatefulWidget {
  JoblistPage({Key key}) : super(key: key);

  @override
  _JoblistPageState createState() => _JoblistPageState();
}

class _JoblistPageState extends State<JoblistPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(
            width: 160,
          ),
          SizedBox(
              width: 200,
              child: Text('JOB ID',
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 15.2,
                    fontWeight: FontWeight.bold,
                  ))),
          SizedBox(
              width: 200,
              child: Text('TOTAL BOX',
                  style: TextStyle(
                    height: 3.0,
                    fontSize: 15.2,
                    fontWeight: FontWeight.bold,
                  ))),
          SizedBox(
            width: 200,
            child: Text(
              'TOTAL CHEQUE',
              style: TextStyle(
                height: 3.0,
                fontSize: 15.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              'JOB DATE',
              style: TextStyle(
                height: 3.0,
                fontSize: 15.2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
