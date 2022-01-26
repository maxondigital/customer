// ignore_for_file: deprecated_member_use

import 'dart:convert';

import 'package:customer/ApiKey/apikey.dart';
import 'package:customer/Login/send_otp.dart';
import 'package:customer/SendOtp/loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: prefer_const_constructors
// ignore: use_key_in_widget_constructors
class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: sized_box_for_whitespace
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.yellow,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 3.5),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('gambar/login.png'),
                  ),
                ),
              ),
              //
              SizedBox(
                height: 10,
              ),
              //
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                          // color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        controller: fullname,
                        // textAlign: TextAlign.left,
                        // ignore: unnecessary_new
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(left: 20, right: 20, top: 5),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 20,
                    ),
                    //
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                          // color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        controller: phonenumber,
                        // textAlign: TextAlign.left,
                        // ignore: unnecessary_new
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(left: 20, right: 20, top: 5),
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 20,
                    ),
                    //
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                          // color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(25)),
                      child: TextField(
                        controller: email,
                        // textAlign: TextAlign.left,
                        // ignore: unnecessary_new
                        decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding:
                              EdgeInsets.only(left: 20, right: 20, top: 5),
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey[300]),
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                              borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 20,
                    ),
                    //
                    GestureDetector(
                      onTap: (){
                        regiter();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    //
                    SizedBox(
                      height: 10,
                    ),
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont have an account '),
                        // ignore: avoid_unnecessary_containers
                        GestureDetector(
                          onTap: () {
                             Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SendOtp()),
            (Route<dynamic> route) => false);
                          },
                          // ignore: avoid_unnecessary_containers
                          child: Container(
                            child: Text(
                              'Login ',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  TextEditingController fullname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController email = TextEditingController();
  //
  late String emaill;
   regiter() {
    // var random = randomAlphaNumeric(32).toLowerCase();
    // String myUrl = "http://45.13.132.61:3000/reseller/signup";
    String myUrl = "https://olla.ws/api/customer/register";
    http.post(Uri.parse(Uri.encodeFull(myUrl)), headers: {
      'Accept': 'application/json',
      "x-token-olla": KEY.APIKEY,
    }, body: {
      "name": fullname.text,
      "email": email.text,
      "mobile_phone": phonenumber.text, 
      // "verification_code": '$data',
      // "reset_code": "",
      // "role": "4",
      // "status": 'active'
    }).then((response) {
      // ignore: avoid_print
      var jsonObj = json.decode(response.body)['status'];
      print(response.body);
      // print(jsonObj1);
        // print(jsonObj['errors']['']);
      if (jsonObj==400) {
        // print(jsonObj);
        // var data1=jsonObj['message'];
        // print(data1);
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Dialog(
          
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
              margin: EdgeInsets.only(top:20),
              decoration: BoxDecoration(
                color:Colors.white,
                shape:BoxShape.rectangle,
                borderRadius: BorderRadius.circular(17),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow:[
                  BoxShadow(
                    color:Colors.black26,
                    blurRadius:10.0,
                    offset: Offset(0.0,10.0),
                  ),
                ]
              ),
              child:Padding(
                padding: const EdgeInsets.only(top:70.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(height: 10,),
                    Text('Maaf!!!',style: TextStyle(fontFamily: 'Comfortaa',fontSize: 13,fontWeight: FontWeight.w900)),
                    SizedBox(height: 10,),
                    Text('Data Yang Anda Masukkan Sudah Ada',style: TextStyle(fontFamily: 'Comfortaa',fontSize: 13,fontWeight: FontWeight.w900)),
                ],),
              )
            ),
            Positioned(
              // bottom: 10,
               top: 0,
              left:16,
              right:16,
              // ignore: sized_box_for_whitespace
              child:Container(
                height: 80,
                width: 80,
                child: Image.asset('gambar/login.png')),
            )
          ],
        ),
  );
      },
    );
      
    
                
        // setState(() {
        //   data = '${jsonObj['data']['verification_code']}';
        //   statusinactive = '${jsonObj['data']['status']}';
        //   namauser = '${jsonObj['data']['user_name']}';
        //   emailuser = '${jsonObj['data']['email']}';
        // });
      }else{
        print('sukses');
  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        SendOtp()));
      }
      // print('$statusinactive');
      // return print(json);
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
