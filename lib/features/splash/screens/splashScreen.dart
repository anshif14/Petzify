import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/auth/screen/loginPage.dart';
// import 'package:luna_demo/core/features/home/navbar.dart';
import 'package:luna_demo/main.dart';

import '../../home/navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    Future.delayed(Duration(seconds: 2)).then((value) => 
    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => LoginPage(),))
    );
    
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(

backgroundColor: Color(0xfff8f6f4),
      body:Center(
        child: Container
          (
          decoration: BoxDecoration(
              color: Color(0xfff8f6f4),

              image: DecorationImage(image: AssetImage(imageConstants.logo),fit: BoxFit.cover)
          ),
          height: MediaQuery.of(context).size.height*0.5,
          width: MediaQuery.of(context).size.width*0.8,
        ),
      )
    );
  }
}
