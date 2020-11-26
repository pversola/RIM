import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:pcpc_shredding/servervices/apiservice.dart';
import 'package:pcpc_shredding/views/home/home_view.dart';

import 'package:pcpc_shredding/views/home/mainbank.dart';
import 'constants.dart';
import 'custom_route.dart';

import 'users.dart';

class LoginScreen extends StatelessWidget {
   final String bankname;
  final String bankcode;
 // const LoginScreen({Key key}) : super(key: key);
  //LoginScreen(this.bankcode);
 
  static const routeName = '/auth';

  const LoginScreen({Key key, this.bankname, this.bankcode}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    /*  final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    ); */

    return Scaffold(
      body: Stack(
        children: [
          Container(
            /*   decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ), */
            child: FlutterLogin(
              title: Constants.appName,
              logo: 'TEST',
              logoTag: Constants.logoTag,
              titleTag: Constants.titleTag,

              messages: LoginMessages(
                usernameHint: 'อีเมล.',
                passwordHint: 'รหัสผ่าน',
                confirmPasswordHint: 'ยืนยัน',
                loginButton: 'ล็อก อิน',
                signupButton: 'ลงทะเบียน',
                forgotPasswordButton: 'ลืมรหัส?',
                recoverPasswordButton: 'ส่งความช่วยเหลือ',
                goBackButton: 'กลับ',
                confirmPasswordError: 'Not match!',
                recoverPasswordIntro: 'กรุณากรอก อีเมล์ที่ถูกต้อง !',
                recoverPasswordDescription:
                    'โปรแกรมจะส่งรหัสใหม่ไปทาง อีเมล์ ที่ลงทะเบียนไว้',
                recoverPasswordSuccess: 'Password rescued successfully',
              ),

              theme: LoginTheme(
                primaryColor: Colors.blue,
                accentColor: Colors.yellow,
                errorColor: Colors.deepOrange,
                pageColorLight: Colors.grey,
                pageColorDark: Colors.grey,
                titleStyle: TextStyle(
                  color: Colors.yellow,
                  fontFamily: 'Quicksand',
                  letterSpacing: 4,
                ),
              ),

              // messages: LoginMessages(
              //   usernameHint: 'Username',
              //   passwordHint: 'Pass',
              //   confirmPasswordHint: 'Confirm',
              //   loginButton: 'LOG IN',
              //   signupButton: 'REGISTER',
              //   forgotPasswordButton: 'Forgot huh?',
              //   recoverPasswordButton: 'HELP ME',
              //   goBackButton: 'GO BACK',
              //   confirmPasswordError: 'Not match!',
              //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
              //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
              //   recoverPasswordSuccess: 'Password rescued successfully',
              // ),
              // theme: LoginTheme(
              //   primaryColor: Colors.teal,
              //   accentColor: Colors.yellow,
              //   errorColor: Colors.deepOrange,
              //   pageColorLight: Colors.indigo.shade300,
              //   pageColorDark: Colors.indigo.shade500,
              //   titleStyle: TextStyle(
              //     color: Colors.greenAccent,
              //     fontFamily: 'Quicksand',
              //     letterSpacing: 4,
              //   ),
              //   // beforeHeroFontSize: 50,
              //   // afterHeroFontSize: 20,
              //   bodyStyle: TextStyle(
              //     fontStyle: FontStyle.italic,
              //     decoration: TextDecoration.underline,
              //   ),
              //   textFieldStyle: TextStyle(
              //     color: Colors.orange,
              //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
              //   ),
              //   buttonStyle: TextStyle(
              //     fontWeight: FontWeight.w800,
              //     color: Colors.yellow,
              //   ),
              //   cardTheme: CardTheme(
              //     color: Colors.yellow.shade100,
              //     elevation: 5,
              //     margin: EdgeInsets.only(top: 15),
              //     shape: ContinuousRectangleBorder(
              //         borderRadius: BorderRadius.circular(100.0)),
              //   ),
              //   inputTheme: InputDecorationTheme(
              //     filled: true,
              //     fillColor: Colors.purple.withOpacity(.1),
              //     contentPadding: EdgeInsets.zero,
              //     errorStyle: TextStyle(
              //       backgroundColor: Colors.orange,
              //       color: Colors.white,
              //     ),
              //     labelStyle: TextStyle(fontSize: 12),
              //     enabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
              //       borderRadius: inputBorder,
              //     ),
              //     focusedBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
              //       borderRadius: inputBorder,
              //     ),
              //     errorBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
              //       borderRadius: inputBorder,
              //     ),
              //     focusedErrorBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
              //       borderRadius: inputBorder,
              //     ),
              //     disabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.grey, width: 5),
              //       borderRadius: inputBorder,
              //     ),
              //   ),
              //   buttonTheme: LoginButtonTheme(
              //     splashColor: Colors.purple,
              //     backgroundColor: Colors.pinkAccent,
              //     highlightColor: Colors.lightGreen,
              //     elevation: 9.0,
              //     highlightElevation: 6.0,
              //     shape: BeveledRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
              //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
              //   ),
              // ),
              emailValidator: (value) {
                if (!value.contains('@') || !value.endsWith('.com')) {
                  return "Email must contain '@' and end with '.com'";
                }
                return null;
              },

              passwordValidator: (value) {
                if (value.isEmpty) {
                  return 'Password is empty';
                }
                return null;
              },


              onLogin: (loginData) {
                print('Login info');
                print('Name: ${loginData.name}');
                print('Password: ${loginData.password}');
                return _loginUser(loginData);
              },
              onSignup: (loginData) {
                print('Signup info');
                print('Name: ${loginData.name}');
                print('Password: ${loginData.password}');
                return _loginUser(loginData);
              },
              onSubmitAnimationCompleted: () {
                ServerStatus.bankCode = '030';
              
                SetBank.setBank('030');

                Navigator.of(context).pushReplacement(FadePageRoute(
                  builder: (context) => HomeView(
                    bankname: 'gsb',
                  ),
                ));
              },
              onRecoverPassword: (name) {
                print('Recover password info');
                print('Name: $name');
                return _recoverPassword(name);
                // Show new password dialog
              },
              showDebugButtons: true,
            ),
          ),






          
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) - 50,
            left: 140,
            child: IconButton(
                padding: new EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 50,
                ),
                tooltip: 'เลือกธนาคาร',
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (BuildContext context) => new MainBank()));
                }),
          ),
          Positioned(
              top: (MediaQuery.of(context).size.height / 2) * 0.1,
              left: (MediaQuery.of(context).size.width / 2) - 75,
              child: Hero(
                tag:'gsb',
                child: CircleAvatar(
                  radius: 70.5,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage( ServerStatus.imageUrl + 'gsb' + '.png'),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
