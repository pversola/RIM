import 'package:flutter/material.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:pcpc_shredding/widgets/call_to_action/call_to_action.dart';

class ChequeDetails extends StatefulWidget {
  @override
  _ChequeDetailsState createState() => _ChequeDetailsState();
}

class _ChequeDetailsState extends State<ChequeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 2, //                   <--- border width here
                    ),
                    borderRadius: BorderRadius.circular(15),
                    /*   image: new DecorationImage(
                            image: new NetworkImage(
                                  ServerStatus.imageUrl   
                           + ServerStatus.bankName + ".png"),
                            fit: BoxFit.cover,
                          ), */
                  ),
                ),
                // CallToAction('ตกลง'),
                Positioned(
                  top: 20,
                  left: 200,
                  child: Container(
                    width: 200,
                    height: 40,
                    child: TextField(
                        // controller: nameController,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                            labelText: 'Scan กล่องเช็ค',
                            prefixIcon: const Icon(
                              Icons.center_focus_weak,
                              color: Colors.green,
                            )),
                        onSubmitted: (value) {
                          /*   POSTAPI.postShredingDetails(widget.jobno, value).then(
                            (resalt) => _getShreddingdetail(resalt.body),
                          ); */

                          // PATCHAPI.patchShreding(widget.jobno, false, false ) ;

                          /*    nameController.clear(); */

                          setState(() {
                            FocusScope.of(context).previousFocus();
                          });
                          // or do whatever you want when you are done editing
                          // call your method/print values etc
                        }),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 420,
                  child: InkWell(
                    onTap: (){
                      
                    },
                                      child: Container(
                        width: 120, height: 40, child: CallToAction('ค้นหา')),
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Hero(
                    tag: ServerStatus.bankName,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          /*  border: Border.all(color: Colors.green, width: 1), */
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              ServerStatus.imageUrl +
                                  ServerStatus.bankName +
                                  ".png",
                            ),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                ),

                Positioned(
                  top: 12,
                  left: 12,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [Text("Detail")],
            )
          ],
        ),
      ),
    ));
  }
}
