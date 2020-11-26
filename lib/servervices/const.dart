import 'package:flutter/material.dart';
class Constants{

static String appName = "DIGITAL NETWORK";
/* static String ip="http://localhost:5050/"; */
 static String ip="http://192.168.43.135:5050/";
static String userid="5ef47eae8286ee95605ec685";
static String userimage="";
static String projectkey="5f02b3249dadaa5bd29f9b9c";
static String appBadgeSupported="";
  //Colors for theme
//  Color(0xfffcfcff);
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.red;
  static Color darkAccent = Colors.red[400];
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color ratingBG =Colors.yellow[600];

  static Color cycleborderdarkBG = Colors.black26;
  static Color cycleborderratingBG = Colors.yellow ;

 static Color mainColor = Color(0XFF252331);
  static Color darkColor = Color(0XFF1e1c26);
  static Color blueColor = Color(0XFF2c75fd);
 
 Constants._();
  static const double padding =20;
  static const double avatarRadius =80;


  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    
    indicatorColor:cycleborderdarkBG,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: darkBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: lightAccent,
//      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: darkBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    indicatorColor:cycleborderratingBG,
    scaffoldBackgroundColor: darkBG,
    
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
//      iconTheme: IconThemeData(
//        color: darkAccent,
//      ),
    ),
  );


 




}
