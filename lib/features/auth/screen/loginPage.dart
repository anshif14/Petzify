

import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';

import 'package:luna_demo/features/auth/screen/nwepage.dart';
import 'package:luna_demo/features/auth/screen/signinPage.dart';
import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/main.dart';

import 'dart:io'as platform;

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

var Userid;
var UserName;
var UserEmail;
var Userimage;

class _LoginPageState extends ConsumerState<LoginPage> {

  functionGoogle(){
    ref.watch(googlesignProv).signInWithGoogle(context);
  }

  final VideoPlayerController videoPlayerController = VideoPlayerController.asset('assets/video/cat1.mp4',);

  ChewieController ? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    chewieController =
        ChewieController(videoPlayerController: videoPlayerController,
          // aspectRatio: 9 / 20,
          aspectRatio: width*1 / height*1,
          autoPlay: true,
          looping: true,
          autoInitialize: true,
          showControls: false,


        );
    super.initState();
  }
    @override
    void dispose() {
      videoPlayerController.dispose();
      chewieController!.dispose();
      super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(child: Chewie(controller: chewieController!)),
            // Expanded(child: Chewie(controller: chewieController!)),
            // Container(
            //   height: height*1,
              // padding: EdgeInsets.all(width * 0.03),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage(imageConstants.pageimage),
              //       fit: BoxFit.cover,
              //       opacity: width * 0.00009),
             // ),
             //  child:
            Column(
                children: [
                  Container(
                    height: height * 0.15,
                    width: width * 1,
                    margin: EdgeInsets.only(top: width * 0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          ImageConstants.dogSvg,
                          width: width * 0.08,
                          height: height * 0.08,
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Let's Get Started!",
                    style: TextStyle(
                        fontSize: width * 0.07, fontWeight: FontWeight.w900,color: Pallette.white),
                  ),
                  Text(
                    "Let's dive into your account",
                    style: TextStyle(
                        fontSize: width * 0.04, color: Pallette.white,),
                  ),
                  gap,
                  Container(
                    height: height * 0.3,
                    width: width * 1,
                    // color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            functionGoogle();
                          },
                          child: Container(
                            width: width * 1,
                            height: height * 0.065,
                            margin: EdgeInsets.all(
                              width * 0.05,
                            ),
                            decoration: BoxDecoration(
                              color: Pallette.secondaryBrown,
                                borderRadius: BorderRadius.circular(width * 0.1),
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image(
                                    image: AssetImage(ImageConstants.googleicon),
                                    height: width * 0.07,
                                    width: width * 0.07),
                                Text("Continue with Google"),
                                SizedBox()
                              ],
                            ),
                          ),
                        ),
                        platform.Platform.isIOS?Container(
                          width: width * 1,
                          height: height * 0.065,
                          margin: EdgeInsets.only(
                            left: width * 0.04,
                            right: width * 0.04,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.1),
                            color: Pallette.secondaryBrown,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                  image: AssetImage(ImageConstants.appleicon),
                                  height: width * 0.07,
                                  width: width * 0.07),
                              Text("Continue with Apple"),
                              SizedBox()
                            ],
                          ),
                        ):Text(""),
                      ],
                    ),
                  ),
                  gap,
                  Container(
                    height: height * 0.15,
                    width: width * 1,
                    // color: Colors.tealAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignupPage(
                                    sign: false,
                                  ),
                                ));
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.1),
                              color: Pallette.primaryColor,
                            ),
                            child: Center(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(color: Pallette.white),
                                )),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SigninPage(),
                                ));
                          },
                          child: Container(
                            height: height * 0.05,
                            width: width * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.1),
                              color: Pallette.primaryColor,
                            ),
                            child: Center(
                                child: Text(
                                  "Sign in",
                                  style: TextStyle(color: Pallette.white),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
