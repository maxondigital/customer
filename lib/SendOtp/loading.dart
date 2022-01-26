import 'dart:async';

import 'package:customer/SendOtp/otpnumber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/indicator/ball_scale_indicator.dart';
import 'package:loading/loading.dart';

class Login extends StatefulWidget {
    String email1;
// Get Key Data
  Login({Key? key, required this.email1})
      : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.red,
        child: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 60.0,
          ),
        ),
      ),
    );
  }
   @override
  void initState(){
    super.initState();
    startTimer();
  }
   void startTimer() async{
     Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => OtpNumber(email2:widget.email1)
        ),
      );
     });
   }
}
