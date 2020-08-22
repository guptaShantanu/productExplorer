import 'package:flutter/material.dart';
import 'package:qartfashion/constants/constant.dart';

class ProductBox extends StatelessWidget {
  final String imageURL;
  final String productSubCategory;
  final double productPrice;
  final String productCategory;
  final Function onTap;

  ProductBox(
      {this.imageURL,
      this.productSubCategory,
      this.productPrice,
      this.productCategory,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5.0),
        decoration:
            BoxDecoration(boxShadow: KStandardBoxShadow, color: Colors.white),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(imageURL),
                  fit: BoxFit.cover,
                )),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                          child: Text(
                        productCategory,
                        style: KCardSubHeadingTextStyle,
                        textAlign: TextAlign.left,
                      )),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            productPrice.toString()+' ₹',
                            style: KCardSubHeadingTextStyle,
                            textAlign: TextAlign.left,
                          )),
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            productSubCategory.toString(),
                            textAlign: TextAlign.left,
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
