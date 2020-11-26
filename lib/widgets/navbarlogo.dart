import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';

/* class NavBarLogo extends StatelessWidget {
  final String bankname;
  const NavBarLogo({Key key, this.bankname}) : super(key: key); */
class NavBarLogo extends StatefulWidget {
  final String bankname;

  NavBarLogo({Key key, this.bankname}) : super(key: key);
  @override
  _NavBarLogoState createState() => _NavBarLogoState();
}

class _NavBarLogoState extends State<NavBarLogo> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
  /*   double _left = 20;
    double _top = 90; */
    print(ServerStatus.imageUrl + widget.bankname + ".png");
    return /* Stack(
      children: [
        Container(
          width: selected ? 360.0 : 200.0,
          height: selected ? 560.0 : 250.0,
          child: AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            left: _left,
            top: _top,
            child: InkWell(
              onTap: () {
                setState(() {
                  this.selected = !selected;
                  _left = selected ? 180 : 20;
                  _top = selected ? 60 : 90;
                });
              },
              child: AnimatedContainer(
                width: selected ? 360.0 : 200.0,
                height: selected ? 570.0 : 250.0,
                color: Colors.transparent,
                alignment: AlignmentDirectional.topCenter,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                child: Container(
                  width: selected ? 340.0 : 200.0,
                  height: selected ? 560.0 : 250.0,
                  child: Column(
                    children: [
                      Hero(
                        tag: widget.bankname,
                        child: Container(
                          width: selected ? 340.0 : 200.0,
                          height: selected ? 340.0 : 250.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                              width:
                                  2, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  15.0), //         <--- border radius here
                            ),
                            image: new DecorationImage(
                              image: new NetworkImage(ServerStatus.imageUrl +
                                  widget.bankname +
                                  ".png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          child: selected
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 322,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.white,
                                            width:
                                                5, //                   <--- border width here
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                15.0), //         <--- border radius here
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 3,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(ServerStatus.bankNameTh),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 270,
                                                    height: 130,
                                                    child: Text(
                                                      ServerStatus.bankAdd,
                                                      /*    overflow: TextOverflow.ellipsis, */

                                                      style: new TextStyle(
                                                          color: Colors.grey),
                                                      maxLines: 5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Row())
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ); */

       Hero(
      tag: widget.bankname,
      child: SizedBox(
        height: 250,
        width: 200,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
              width: 5, //                   <--- border width here
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15.0), //         <--- border radius here
            ),
            image: new DecorationImage(
              image: new NetworkImage(
                     ServerStatus.imageUrl  + widget.bankname + ".png"),
              fit: BoxFit.cover,
            ),
          ), /* Image.asset(''assets/images/'+ bankname +'.png), */
        ),
      ),
    );   
  }
}
