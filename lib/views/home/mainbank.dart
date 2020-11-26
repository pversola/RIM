import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pcpc_shredding/models/company.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';

import '../login.dart';

 

class MainBank extends StatefulWidget {
  @override
  _MainBankState createState() => _MainBankState();
}

class _MainBankState extends State<MainBank> {
 

  _getShredding() {
    /*  setState(() {
      // _loadingInProgress = true;
      _noData = false;
    }); */
    GETAPI.getCompany().then((response) {
      setState(() {
        //  print(json.decode(response.body)['message']);
        if (json.decode(response.body)['message'].toString() != "[]") {
          List datas = json.decode(response.body)['message'];
         ServerStatus. companylist =
              (datas).map((data) => new CompanyModel.fromJson(data)).toList();

          setState(() {
            print(ServerStatus.companylist.length);
          });
        } else {
          setState(() {});
        }
      });
    });
  }

  initState() {
    super.initState();
    if (ServerStatus.appfirstload == true) {
      ServerStatus.appfirstload = false;
      _getShredding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.grey, Colors.grey]),
      ),

      /*   decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ), */
      child: Center(
        child: Container(
          width: 570,
          height: 220,
          decoration: new BoxDecoration(
            color: Colors.white,
            /* border: Border.all(
              color: Colors.green,
              width: 1, //                   <--- border width here
            ), */
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("กรุณาเลือกธนาคาร",
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 570,
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: ServerStatus.companylist.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (BuildContext ctxt, int index) =>
                              //   Text("xxxx")

                              buildBody(index),

                          ///
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  Widget buildBody(int index) {
    return Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
                ServerStatus.bankNameTh= ServerStatus.companylist[index].companyNameTh;
                ServerStatus.bankName=ServerStatus.companylist[index].companyAbbr.toLowerCase();
                 ServerStatus.bankAdd= ServerStatus.companylist[index].companyAddress;
            Navigator.pushReplacement(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new LoginScreen(
                            bankname:
                                ServerStatus.companylist[index].companyAbbr.toLowerCase(),
                            bankcode: ServerStatus.companylist[index].companyCd,
                          ))); 
            });
          },
          child: Hero(
            tag:ServerStatus. companylist[index].companyAbbr.toLowerCase(),
            child: Container(
              width: 100,
              height: 120,              
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                   ServerStatus.imageUrl  +
                        ServerStatus.companylist[index].companyAbbr.toLowerCase() +
                        ".png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
          height: 20,
        )
      ],
    );
  }
}
