import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/auth/controller/auth_controller.dart';
import 'package:luna_demo/features/auth/screen/nwepage.dart';
import 'package:luna_demo/features/auth/screen/signinPage.dart';
import 'package:luna_demo/features/auth/screen/signupPage.dart';
import 'package:luna_demo/features/home/screen/navbar.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    chewieController = ChewieController(videoPlayerController: videoPlayerController,
    aspectRatio: width*1/height*1,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,


    );

    @override
    void dispose() {
      videoPlayerController.dispose();
      chewieController!.dispose();
      super.dispose();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Expanded(child: Chewie(controller: chewieController!)),
          Container(
            // padding: EdgeInsets.all(width * 0.03),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage(imageConstants.pageimage),
            //       fit: BoxFit.cover,
            //       opacity: width * 0.00009),
            // ),
            child: Column(
              children: [
                Container(
                  height: height * 0.15,
                  width: width * 1,
                  margin: EdgeInsets.only(top: width * 0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        imageConstants.dogSvg,
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
                            color: Colors.grey,
                              borderRadius: BorderRadius.circular(width * 0.1),
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                  image: AssetImage(imageConstants.googleicon),
                                  height: width * 0.07,
                                  width: width * 0.07),
                              Text("Continue with Google"),
                              SizedBox()
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: width * 1,
                        height: height * 0.065,
                        margin: EdgeInsets.only(
                          left: width * 0.04,
                          right: width * 0.04,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            color: Colors.grey),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(
                                image: AssetImage(imageConstants.appleicon),
                                height: width * 0.07,
                                width: width * 0.07),
                            Text("Continue with Apple"),
                            SizedBox()
                          ],
                        ),
                      ),
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
          ),
        ],
      ),
    );
  }
}
