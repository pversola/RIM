import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
 

class ObjChecklist extends StatelessWidget {
  final String checklistid;
  final int indexrow;
  final String name;
  final String descryption;
  final String objdate;
  final String menutype;
  final String projecttype;
  const ObjChecklist(
      {Key key,
      @required this.indexrow,
      @required this.checklistid,
      @required this.name,
      @required this.descryption,
      @required this.objdate,
      @required this.menutype,
      @required this.projecttype})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),



      
     /*  child: ListTile(
        leading: Icon(
          Icons.list,
          size: 50.0,
          color: Theme.of(context).accentColor,
        ),
        // title: Text("$checklistid"),
        title: Text("$indexrow"),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                /*   SmoothStarRating(
                  starCount: 2,
                  color: Constants.ratingBG,
                  allowHalfRating: true,
                  rating: 5.0,
                  size: 12.0,
                ),*/
                //  Text("$indexrow"),
                ButtonIndex("$indexrow"),
              
                SizedBox(width: 6.0),
                Text(
                  "$objdate",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.0),
            Text(
              "$descryption",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ), */
    );
  }




  
}
