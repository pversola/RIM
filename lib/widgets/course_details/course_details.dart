import 'package:flutter/material.dart';
import  'package:responsive_builder/responsive_builder.dart';
 
class CourseDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      var textAlignment =
          sizingInformation.deviceScreenType == DeviceScreenType.desktop
              ? TextAlign.left
              : TextAlign.center;
      double titleSize =
          sizingInformation.deviceScreenType == DeviceScreenType.mobile
              ? 50
              : 60;
      double descriptionSize = sizingInformation.deviceScreenType == DeviceScreenType.mobile ?
      16 : 21;
      return Container(
        width: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'PCPC\nShredding',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                height: 1.2,
                fontSize: titleSize,
              ),
              textAlign: textAlignment,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              ' จากการทุ่มเทให้กับงานวิจัยอย่างจริงจังทำให้บริษัทฯสามารถพัฒนาสิ่งพิมพ์ป้องกันการปลอมแปลง ที่สนองตอบความต้องการของลูกค้าในโลกธุรกิจที่เปลี่ยนแปลงอย่างรวดเร็ว และแข่งขันกันอย่างรุนแรง ในปัจจุบันได้อย่างลงตัว.',
              style: TextStyle(
                fontSize: descriptionSize,
                height: 1.7,
              ),
              textAlign: textAlignment,
            )
          ],
        ),
      );
    });
  }
}