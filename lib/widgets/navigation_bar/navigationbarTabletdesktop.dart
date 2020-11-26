import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcpc_shredding/views/bills/billpayment.dart';
import 'package:pcpc_shredding/views/billspay/billspay.dart';
import 'package:pcpc_shredding/views/config/config.dart';

import 'package:pcpc_shredding/views/home/mainbank.dart';
 

import 'package:pcpc_shredding/widgets/navigation_bar/navbaritem.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  final String bankname;
  const NavigationBarTabletDesktop({Key key, this.bankname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          /*  Positioned(
             top:10,
             left: 10,
                        child: Container(
               color:Colors.red,
               width: 500,
               height: 500,
               child: NavBarLogo(bankname: this.bankname,)),
           ),
         */

          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  height: 40,
                  width: 700,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute<bool>(
                                fullscreenDialog: false,
                                builder: (BuildContext context) => PrintBillPayment(
                                  
                                ),
                              ),
                            );
                          },
                          child: NavBarItem('งานออกบิล')),
                      SizedBox(
                        width: 60,
                      ),
                      InkWell(
                          onTap: () {
                            //  Navigator.of(context, rootNavigator: true).pushNamed( ExportCsv());
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute<bool>(
                                fullscreenDialog: false,
                                builder: (BuildContext context) =>
                                    BillPayment(bankname: this.bankname),
                              ),
                            );
                          },
                          child: NavBarItem('บันทึกจัดเก็บ')),
                      SizedBox(
                        width: 60,
                      ),
                      //DashboardScreen
                      InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute<bool>(
                        fullscreenDialog: false,
                        builder: (BuildContext context) => ConfigPage(),
                      ),
                    );    
                          },
                          child: NavBarItem('ตั้งค่า')),
                      SizedBox(
                        width: 60,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new MainBank()));
                          },
                          child: NavBarItem('LOGOUT')),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
