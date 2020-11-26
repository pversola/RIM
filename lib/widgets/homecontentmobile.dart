import 'package:flutter/material.dart';
import 'package:pcpc_shredding/widgets/call_to_action/call_to_action.dart';
import 'package:pcpc_shredding/widgets/course_details/course_details.dart';

class HomeContentMobile extends StatelessWidget {
  const HomeContentMobile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
     
        child: Column(
          mainAxisSize: MainAxisSize.max,
        //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CourseDetails(),
            SizedBox(
              height: 10,
            ),
            Expanded(
               
          child: Center(
            child: CallToAction('ตกลง'),
          ),
            ),
          ],
        ),
     
    );
  }
}
