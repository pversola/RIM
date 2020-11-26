import 'package:flutter/material.dart';

import 'package:pcpc_shredding/widgets/centered_view/centered_view.dart';
import 'package:pcpc_shredding/widgets/homecontentdesktop.dart';
import 'package:pcpc_shredding/widgets/homecontentmobile.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/navigation_bar.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/navigationdrawerheader.dart';

import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  final String bankname;
  const HomeView({Key key, this.bankname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawerHeader()
            : null,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(bankname: this.bankname,),
              Expanded(
                child: ScreenTypeLayout(
                  mobile: HomeContentMobile(),
                  desktop: HomeContentDesktop(),
                ),
              )
            ],
          ),
        ),
      ),
    );

    /*  sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavigationDrawerHeader()
            : null , */
  }
}
