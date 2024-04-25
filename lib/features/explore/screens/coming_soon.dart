import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/main.dart';

class comingSoon extends StatefulWidget {
  const comingSoon({super.key});

  @override
  State<comingSoon> createState() => _comingSoonState();
}

class _comingSoonState extends State<comingSoon> {
  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.doglottie),
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height*0.4,
                width: width*1,
                child: Center(
                  child:Lottie.asset(ImageConstants.loading),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
