import 'package:flutter/material.dart';

class Grid6 extends StatelessWidget {
  final String imageUrl;
  Grid6({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  GridBox(imageUrl: imageUrl),
                  VerticalLine(),
                  GridBox(imageUrl: imageUrl,),
                  VerticalLine(),
                  GridBox(imageUrl: imageUrl,)
                ],
              ),
            ),
          ),
          HorizontalLine(),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  GridBox(imageUrl: imageUrl),
                  VerticalLine(),
                  GridBox(imageUrl: imageUrl,),
                  VerticalLine(),
                  GridBox(imageUrl: imageUrl,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 1,
    width: MediaQuery.of(context).size.width,
    color: Colors.black,);
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: 1,
      height: MediaQuery.of(context).size.width,
      color: Colors.black,);
  }
}

class GridBox extends StatelessWidget {
  const GridBox({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill
          ),
        ),
      ),
    );
  }
}
