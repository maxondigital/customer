import 'package:flutter/material.dart';

class UpSlideBanner extends StatefulWidget{
  @override
  State<UpSlideBanner> createState() => _UpSlideBannerState();
}

class _UpSlideBannerState extends State<UpSlideBanner> {
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(left:10,right:10 ,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text('Our Recommendation'),
        Text('View all'),
      ],),
    );
  } 
}