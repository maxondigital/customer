// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:customer/Dashboard/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:customer/ApiKey/apikey.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors

// ignore: must_be_immutable
class OtpNumber extends StatefulWidget {
  @override
    // ignore: override_on_non_overriding_member
    String email2;
// Get Key Data
  OtpNumber({Key? key, required this.email2})
      : super(key: key);
  // ignore: annotate_overrides
  State<OtpNumber> createState() => _OtpNumberState();
}

class _OtpNumberState extends State<OtpNumber> {
//   late String alamat;
//   void kirim()async{
//  SharedPreferences preferences = await SharedPreferences.getInstance();
//           alamat = preferences.getString('partnerid')??'';
//   }
//   //
//     // late String alamat;
//   void kirim1( String otp)async{
//  final preff1 =
//                                         await SharedPreferences.getInstance();
//                                     preff1.setString('partnerid', otp);
//                                     // print('11111');
//   }

//  final BoxDecoration pinPutDecoration = BoxDecoration(
//     color: Colors.yellow,
//     borderRadius: BorderRadius.circular(5.0),
//   );
  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.blue, width: 3),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          Container(
            margin: EdgeInsets.only(),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('gambar/login.png'),
              ),
            ),
          ),
          //
          Text(
            'Verification',
            style: TextStyle(fontSize: 20),
          ),
          //
          SizedBox(
            height: 10,
          ),
          //
          Text(
            'Enter Code',
            style: TextStyle(fontSize: 15),
          ),
          //
          SizedBox(
            height: 10,
          ),
          //
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: PinPut(
              validator: (s) {
                if (s!.contains('')) return null;
                return 'NOT VALID';
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              withCursor: true,
              fieldsCount: 6,
              fieldsAlignment: MainAxisAlignment.spaceAround,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
              eachFieldMargin: EdgeInsets.only(
                top: 20,
              ),
              eachFieldWidth: 50.0,
              eachFieldHeight: 80.0,
              onSubmit: (String pin) {
                // kirim();
                addData();
              },
              controller: otp,
              submittedFieldDecoration: _pinPutDecoration,
              selectedFieldDecoration: _pinPutDecoration.copyWith(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: Colors.blue,
                ),
              ),
              followingFieldDecoration: _pinPutDecoration.copyWith(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(color: Colors.blue, width: 3),
              ),
              pinAnimationType: PinAnimationType.scale,
            ),
          ),
          //
          SizedBox(
            height: 20,
          ),
          //
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text('Expiry code in'),
              SizedBox(
                width: 5,
              ),
              Text(
                '00:41',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          //
          SizedBox(
            height: 20,
          ),
          //
          const Flexible(
              child: Padding(
            padding: EdgeInsets.only(left: 60, right: 60),
            child: Text(
              'Verification code has been sent to your registered email account',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          )),
          //
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child:'$sukses'.contains('200')? GestureDetector(
              onTap: (){
                // ignore: avoid_print
                print('sukses');
               Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Dashboard()),
            (Route<dynamic> route) => false);
            //
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ):Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 15,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(25)),
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
              ),
            ),
          //
        ],
      ),
    );
  }
  //
  TextEditingController otp = TextEditingController();
  //
   int? sukses;
   int? customer;
  //  int? customerid;
   addData() {
    // var random = randomAlphaNumeric(32).toLowerCase();
    // String myUrl = "http://45.13.132.61:3000/reseller/signup";
    String myUrl = "https://olla.ws/api/customer/otp";
    http.post(Uri.parse(Uri.encodeFull(myUrl)), headers: {
      'Accept': 'application/json',
       "x-token-olla": KEY.APIKEY,
      // "imei": "123456"
    }, body: {
      "email":widget.email2,
      "otp": otp.text,
    }).then((response) async {
      var jsonObj = json.decode(response.body);
      setState(() {
        // customerid = jsonObj['customer_data']['customers_id'];
      sukses = jsonObj['message']['code'];
      customer = jsonObj['message']['customer_data'][0]['customers_id'];
      });
      print(customer);
      // ignore: avoid_print
      print(jsonObj);
      if (response.statusCode == 200) {
        // print(jsonObj['customer_id']);
          final preff1 =
                                        await SharedPreferences.getInstance();
                                    preff1.setString('sukses', '$sukses');
                                    //
                                      final preff2 =
                                        await SharedPreferences.getInstance();
                                    preff1.setString('customer', '$customer');
        setState(() {
          // pengenalid = jsonObj['customer_id'];
          // _incrementCounter();
        });
        // ignore: avoid_print
        print(jsonObj);

        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (BuildContext context) => SendOtpNumber()),
        //     (Route<dynamic> route) => false);
        // setState(() {
        //   data = '${jsonObj['data']['verification_code']}';
        //   statusinactive = '${jsonObj['data']['status']}';
        //   namauser = '${jsonObj['data']['user_name']}';
        //   emailuser = '${jsonObj['data']['email']}';
        // });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(17),
                          // ignore: prefer_const_literals_to_create_immutables
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 10.0),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text('Maaf!!!',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Masukkan Data Anda Dengan Benar',
                                style: TextStyle(
                                    fontFamily: 'Comfortaa',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900)),
                          ],
                        ),
                      )),
                  Positioned(
                    // bottom: 10,
                    top: 0,
                    left: 16,
                    right: 16,
                    // ignore: sized_box_for_whitespace
                    child: Container(
                        height: 80,
                        width: 80,
                        child: Image.asset('gambar/login.png')),
                  )
                ],
              ),
            );
          },
        );
      }
      // print('$statusinactive');
      // return print('$data');
      //   return showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (BuildContext context) {
      //         return WillPopScope(
      //           onWillPop: () async => false,
      //           child: GestureDetector(onTap: () {
      //             Navigator.pop(context);
      //             // Navigator.pushAndRemoveUntil(
      //             //     context,
      //             //     MaterialPageRoute(
      //             //         builder: (BuildContext context) => HomeScreen()),
      //             //     (Route<dynamic> route) => false);
      //           }, child: StatefulBuilder(
      //             builder: (BuildContext context, StateSetter setState) {
      //               return SimpleDialog(
      //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //                 contentPadding: EdgeInsets.zero,
      //                 titlePadding: EdgeInsets.only(bottom: 0),
      //                 title: Column(
      //                   children: [
      //                     Container(
      //                       decoration: BoxDecoration(
      //                       color:Colors.deepPurple[400],
      //                         borderRadius: BorderRadius.only(topLeft:Radius.circular(10),topRight: Radius.circular(10))
      //                       ),
      //                       height:20,
      //                     ),
      //                     SizedBox(height:15),
      //                     Text('Akun Belum Aktiv'),
      //                     SizedBox(height:15),
      //                     RaisedButton(
      //                       child:Text('Verifikasi Akun'),
      //                       onPressed: (){
      //                         // _launchMap();
      //                       },
      //                     ),
      //                     SizedBox(height:15),
      //                   ],
      //                 )
      //               );
      //             },
      //           )),
      //         );
      //       });
      // } else {}
    });
//
//
  }
}
