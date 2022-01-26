import 'dart:convert';

import 'package:customer/ApiKey/apikey.dart';
import 'package:customer/Login/send_otp.dart';
import 'package:customer/TabDashboard/slidebanner.dart';
import 'package:customer/TabDashboard/uptoslidebanner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: prefer_const_constructors
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int itemcount = 6;

  //  item() async{
  //   setState(() {
  //     itemcount =  itemcount == 0 ?6:0;
  //   });
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:AppBar(
      //   title:Text('yeyeyeye'),
      // ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.6,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
              ),
              Positioned.fill(
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 120),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                         '$data1',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'What you need for our services ?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 15,
                            decoration: BoxDecoration(
                                // color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(25)),
                            child: TextField(
                              // controller: phonenumber,
                              // textAlign: TextAlign.left,
                              // ignore: unnecessary_new
                              decoration: new InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: EdgeInsets.only(
                                    left: 20, right: 20, top: 5),
                                hintText: 'Search',
                                // prefixIcon: Icon(Icons.search),
                                suffixIcon: Icon(Icons.search),
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                //  getDataCustomer();
                 
                },
                child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.list_rounded,
                          color: Colors.white,
                        ),
                        Text(
                          'Olla.id',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.remove('sukses');
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SendOtp()),
                                (Route<dynamic> route) => false);
                          },
                          child: Container(
                            child: Icon(
                              Icons.add_alert_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            // childAspectRatio: 5 / 5,
                            crossAxisSpacing: 3),
                        shrinkWrap: true,
                       
                        // ignore: prefer_if_null_operators
                        itemCount: 6,
                        // data == null
                        //                 ? 0
                        //                 : data!.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 3))
                                  ],
                                ),
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    child: CircleAvatar(
                                      radius: 27,
                                      backgroundColor: Colors.white,
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://olla.ws/images/icon-image/${data![i]['image']}'),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Flexible(
                                  child: Text(
                              '${data![i]['name']}',
                                maxLines: 2,
                                style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              )),
                            ],
                          );
                        }),
                  ),
                ),
                UpSlideBanner(),
               SlideBanner()
              ],
            ),
          ),
          //
          
        ],
      ),
    );
  }

  //
  @override
  void initState() {
    super.initState();
    getDataGrid();
    // item();
    getDataCustomer();
    // getData();
    // getDataidpartner();
    //  Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     loading = true;
    //   });
    //   });
  }

  //
  List? data;
  getDataGrid() async {
    var response = await http.get(
        Uri.parse(Uri.encodeFull('https://olla.ws/api/customer/icon')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        });
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data = converDataToJson['data'];
      // ignore: avoid_print
      // print(converDataToJson);
    });
    return "Success";
  }

  //
  //name of dashboard
  String? data1;
  String? customer;
  getDataCustomer() async {
    final prefs1 = await SharedPreferences.getInstance();
    customer = prefs1.getString('customer');
    var response = await http.get(
        Uri.parse(Uri.encodeFull(
            'https://olla.ws/api/customer/customer-profile?customers_id=$customer')),
        headers: {
          "Accept": "application/json",
          "x-token-olla": KEY.APIKEY,
        }); 
    //
    setState(() {
      var converDataToJson = json.decode(response.body);
      data1 = converDataToJson['profile'][0]['name'];
      // ignore: avoid_print
      print('$data1');
    });
    return "Success";
  }
}
