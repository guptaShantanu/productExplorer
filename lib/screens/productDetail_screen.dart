import 'package:flutter/material.dart';
import 'package:qartfashion/components/custom_button.dart';
import 'package:qartfashion/components/description_tile.dart';
import 'package:qartfashion/components/grid6.dart';
import 'package:qartfashion/constants/constant.dart';

class ProductDetail extends StatefulWidget {
  final Map productData;
  final bool searchedData;
  ProductDetail({this.productData,this.searchedData=true});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Widget> sizeList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData() {
    List sizes = [];
    if(widget.searchedData){
      sizes = widget.productData['AvailableSizes'].split(':');
    }else{
      sizes = widget.productData['AvailableSizes'];
    }

    for (var item in sizes) {
      sizeList.add(Expanded(
        child: Container(
//          height: 45.0,
//          width: 45.0,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration:
              BoxDecoration(color: Colors.black, shape: BoxShape.circle),
          child: Text(
            item,
            style: TextStyle(
                color: Colors.white, fontFamily: 'Monte', fontSize: 18.0),
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
         backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
        title: Text('QART Fashion',style: KCardSubHeadingTextStyle,),
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.productData['ImageUrl']),
                          fit: BoxFit.fill)),
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                      Grid6(imageUrl: widget.productData['ImageUrl'],),
                    ],
                  )
//                  child: Text(
//                    widget.productData['Description'],
//                    style: KProductImageTextStyle
//                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.productData['MRP'].toString() + ' ₹',
                    style: KPriceTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                DescriptionTile(
                  heading: 'Category',
                  value: widget.productData['Category'],
                ),
                SizedBox(
                  height: 10.0,
                ),
                DescriptionTile(
                  heading: 'Color',
                  value: widget.productData['Color'],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      boxShadow: KStandardBoxShadow,
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Available sizes'),
                      SizedBox(
                        height: 5.0,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: sizeList,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    'Other details',
                    style: KProductImageTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: KStandardBoxShadow,
                      color: Colors.white,
                      border: Border.all(width: 1.0, color: Colors.black)),
                ),
                Container(
                  margin: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child: CustomButton(
                    label: 'Add to cart',

                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
