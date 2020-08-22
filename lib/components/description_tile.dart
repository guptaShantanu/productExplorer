import 'package:flutter/material.dart';
import 'package:qartfashion/constants/constant.dart';

class DescriptionTile extends StatelessWidget {
  final String heading;
  final String value;
  DescriptionTile({this.heading="",this.value=""});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      decoration: BoxDecoration(
        boxShadow: KStandardBoxShadow,
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(heading),
          SizedBox(height: 5.0,),
          Text(value,style: KCardSubHeadingTextStyle,)
        ],
      ),
    );
  }
}
