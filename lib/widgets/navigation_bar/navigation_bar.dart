import 'package:flutter/material.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/navigationbarTabletdesktop.dart';
import 'package:pcpc_shredding/widgets/navigation_bar/navigationbarmobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBar extends StatelessWidget {
  final String bankname;
  const NavigationBar({Key key, this.bankname}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(
        bankname: this.bankname,
      ),
      tablet: NavigationBarTabletDesktop(
        bankname: this.bankname,
      ),
    );
  }
}
