import 'package:flutter/material.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:pcpc_shredding/widgets/call_to_action/call_to_action.dart';
import 'package:pcpc_shredding/widgets/course_details/course_details.dart';
import 'package:pcpc_shredding/widgets/navbarlogo.dart';

class HomeContentDesktop extends StatefulWidget {
  @override
  _HomeContentDesktopState createState() => _HomeContentDesktopState();
}

class _HomeContentDesktopState extends State<HomeContentDesktop> {
  @override
  Widget build(BuildContext context) {
    
    return Stack(
      children: [
        Row(
          children: <Widget>[
            CourseDetails(),
            Expanded(
              child: Center(
                child: CallToAction('ตกลง'),
              ),
            )
          ],
        ),
         NavBarLogo(
              bankname: ServerStatus.bankName,
            
            ) 
      ],
    );
  }
}

/* 
class _ShreddingState extends State<Shredding> {

class HomeContentDesktop extends StatelessWidget {
  const HomeContentDesktop({Key key}) : super(key: key);
  @override
 
}
 */
