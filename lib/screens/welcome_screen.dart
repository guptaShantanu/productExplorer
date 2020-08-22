import 'package:flutter/material.dart';
import 'package:qartfashion/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double opacity = 0.0;
  
  @override
  void initState() {
    startSplash();
    super.initState();
  }

  void startSplash(){

    Future.delayed(Duration(milliseconds: 100),(){
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(Duration(seconds: 2),(){
      Navigator.push(context,MaterialPageRoute(builder: (context){
        return LoginScreen();
      }));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: AnimatedOpacity(
            opacity: opacity,
            duration: Duration(seconds: 2),
            child: Hero(
              tag: 'logo',
                child: Text('QART',style: TextStyle(fontSize: 30.0,fontFamily: 'Lobster'),)),
          ),
        ),
      ),
    );
  }
}
