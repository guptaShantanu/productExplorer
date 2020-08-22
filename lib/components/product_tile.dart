import 'package:flutter/material.dart';
import 'package:qartfashion/constants/constant.dart';

class ProductTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String sizes;
  final String price;
  List<Widget> sizeList = [];
  ProductTile({this.imageUrl,this.name,this.sizes,this.price});
  @override
  Widget build(BuildContext context) {
    sizeList = [];
    for(var i in sizes.split(':')){
      sizeList.add(Container(
        margin: EdgeInsets.only(right: 3.0),
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Text(i,style: TextStyle(color: Colors.white),),
      ));
    }

    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      decoration: BoxDecoration(
        boxShadow: KStandardBoxShadow,
        color: Colors.white
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(child: Text(name,style: KCardSubHeadingTextStyle,)),
                  SizedBox(height: 10.0,),
                  Container(
                    child: Wrap(
                      children: sizeList.sublist(0,sizeList.length-1),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(child: Text(price+' ₹',style: KCardSubHeadingTextStyle,)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
