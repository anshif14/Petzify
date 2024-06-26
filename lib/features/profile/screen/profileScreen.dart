
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';

import 'package:luna_demo/features/auth/screen/loginPage.dart';

import 'package:luna_demo/features/home/screen/home.dart';

import 'package:luna_demo/features/profile/screen/editProfile.dart';
import 'package:luna_demo/features/myads/screen/myAds.dart';
import 'package:luna_demo/features/order/screen/myOrder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';


class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  Position ?_currentLocation;
  late bool servicePermission=false;
  late  LocationPermission permission;
  String _currentAdress ="";
  Future<Position> _getCurrentLocation() async {
    servicePermission =await Geolocator.isLocationServiceEnabled();
    permission=await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
  _getAddressFromCoordinates() async{
    try{
      List<Placemark> placemark =await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAdress ="${place.locality},${place.country}";
      });
    }catch (e){

    }
  }

  fetch()async{
    _currentLocation =await _getCurrentLocation();
    await _getAddressFromCoordinates();
    setState(() {

    });
  }



  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }


  bool toggle = false;

  @override



  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text("Profile",
              style:
                  TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.w600)),
          toolbarHeight: height * 0.06,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: width * 0.04,
            left: width * 0.04,
            bottom: width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: height * 0.11,
                width: width * 1,
                decoration: BoxDecoration(
                    // color: Pallette.profile,
                    gradient: LinearGradient(
                        colors: [
                          Pallette.primaryColor,
                          Pallette.secondaryBrown,
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        stops: [0.725, 0.3]),
                    // color: Pallette.primaryColor,
                    borderRadius: BorderRadius.circular(width * 0.03),
                    border: Border.all(
                      color: Pallette.primaryColor.withOpacity(0.7),
                      width: width * 0.005,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                          spreadRadius: 1,
                          offset: Offset(0, 4)),
                    ]),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      right: width * 0.06,
                      top: width * 0.02,
                      bottom: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: width * 0.09,
                            backgroundColor: Pallette.primaryColor,
                            child: CircleAvatar(
                              backgroundColor: Pallette.secondaryBrown,
                              radius: width * 0.085,
                              backgroundImage: NetworkImage(
                                  currentUserModel!.images
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width*0.5,
                                child: Text(currentUserModel!.name,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: Pallette.white,
                                    )),
                              ),
                             _currentAdress.isNotEmpty?Text(
                                _currentAdress,
                                style: TextStyle(
                                  fontSize: width * 0.035,
                                  color: Pallette.white,
                                ),
                              ):Text("Kerala",style: TextStyle(color: Pallette.white,fontSize: width * 0.035,),)
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => editProfile(place: _currentAdress,),
                                  ));
                            },
                            child: Container(
                                height: height * 0.05,
                                width: width * 0.07,
                                child: Icon(
                                  Icons.edit,
                                  color: Pallette.white,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: width * 1,
                decoration: BoxDecoration(
                  color: Pallette.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                      spreadRadius: 2,
                      // offset: Offset(0, 0)
                    ),
                  ],
                  borderRadius: BorderRadius.circular(width * 0.02),
                  // border: Border.all(color: Pallette.primaryColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => myOrder(),
                            ));
                      },
                      child: ListTile(
                        // leading: CircleAvatar(
                        //   radius: width*0.068,
                        //   backgroundColor: Pallette.primaryColor,
                        //   child: CircleAvatar(
                        //     radius: width*0.06,
                        //     backgroundColor: Colors.white,
                        //   ),
                        // ),
                        leading: Container(
                          width: width * 0.13,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstants.order),
                                  scale: width * 0.035,
                                  alignment: AlignmentDirectional(0.1, 0)),
                              shape: BoxShape.circle,
                              color: Color(0xfff8f6f4),
                              border: Border.all(
                                  color: Pallette.primaryColor,
                                  width: width * 0.006)),
                        ),
                        title: Text("My Order",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        subtitle: Text("Make changes to your order"),
                        subtitleTextStyle: TextStyle(
                            fontSize: width * 0.035, color: Colors.grey.shade600),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Pallette.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => myAds(),
                            ));
                      },
                      child: ListTile(
                        leading: Container(
                          width: width * 0.13,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstants.ads),
                                  scale: width * 0.055,
                                  alignment: AlignmentDirectional(0.25, 0)),
                              shape: BoxShape.circle,
                              color: Color(0xfff8f6f4),
                              border: Border.all(
                                  color: Pallette.primaryColor,
                                  width: width * 0.006)),
                        ),
                        title: Text("My Ads",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        subtitle: Text("Make changes to your ads"),
                        subtitleTextStyle: TextStyle(
                            fontSize: width * 0.035, color: Colors.grey.shade600),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Pallette.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                   SizedBox(height: height*0.01,),
                    // ListTile(
                    //   leading:Container(
                    //     height: height*0.06,
                    //     width: width*0.13,
                    //     decoration: BoxDecoration(
                    //         shape: BoxShape.circle,
                    //         color: Color(0xfff8f6f4),
                    //         border: Border.all(color: Pallette.primaryColor,width: width*0.006)
                    //
                    //     ),
                    //
                    //   ),
                    //   title: Text("Face ID / Touch ID",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.w600,
                    //       )),
                    //   subtitle: Text("Manage your device security "),
                    //   subtitleTextStyle: TextStyle(
                    //       fontSize: width*0.035,
                    //       color: Colors.grey.shade600
                    //   ),
                    //
                    //   trailing:  Stack(
                    //     children: [
                    //       InkWell(
                    //         onTap: () {
                    //           toggle = !toggle;
                    //           setState(() {});
                    //         },
                    //         child: Container(
                    //           height: height * 0.032,
                    //           width: width * 0.12,
                    //           decoration: BoxDecoration(
                    //             color: toggle ? Pallette.primaryColor:Pallette.primaryColor.withOpacity(0.4),
                    //             borderRadius: BorderRadius.circular(width * 0.05),
                    //           ),
                    //         ),
                    //       ),
                    //       AnimatedPositioned(
                    //           duration: Duration(milliseconds: 200),
                    //           left: toggle ? width * 0.05: width * 0.009,
                    //           right: toggle ? width * 0.009 : width * 0.05,
                    //           top: width*0.008,
                    //           child: InkWell(
                    //             onTap: () {
                    //               toggle = !toggle;
                    //               setState(() {});
                    //             },
                    //             child: AnimatedContainer(
                    //               duration: Duration(milliseconds: 200),
                    //               curve: Curves.easeIn,
                    //               height: width * 0.055,
                    //               width: width * 0.055,
                    //               decoration: BoxDecoration(
                    //                   color: Pallette.white, shape: BoxShape.circle),
                    //             ),
                    //           ))
                    //     ],
                    //   ),
                    // ),

                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          barrierColor: Colors.black.withOpacity(0.5),
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              content: Text("Are you Sure\nYou Want to Log Out !",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * 0.045)),
                              actions: [
                                CupertinoDialogAction(
                                  textStyle:
                                      TextStyle(color: Colors.grey.shade800),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  textStyle:
                                      TextStyle(color: Pallette.primaryColor),
                                  onPressed: () async {
                                    SharedPreferences _prefs = await SharedPreferences.getInstance();
                                    _prefs.remove('email');
                                    // _prefs.remove("login");
                                    currentUserModel=null;
                                    fav.clear();
                                    _prefs.clear();
                                    GoogleSignIn().signOut();
                                    FirebaseAuth.instance.signOut();
                                    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => LoginPage(),), (route) => false);
                                  },
                                  child: Text("Confirm"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      // onTap: () {
                      //     showCupertinoModalPopup(
                      //       barrierColor: Colors.black.withOpacity(0.5),
                      //       context: context,
                      //       builder: (context) {
                      //         return CupertinoActionSheet(
                      //           actions: [
                      //             CupertinoActionSheetAction(
                      //               onPressed: () {
                      //
                      //               },
                      //               child: Text("Log Out",
                      //                   style: TextStyle(
                      //                       fontWeight: FontWeight.w400,
                      //                       fontSize: width * 0.05)),
                      //               isDefaultAction: true,
                      //             ),
                      //           ],
                      //           cancelButton: CupertinoActionSheetAction(
                      //               onPressed: () {
                      //                 Navigator.pop(context);
                      //               },
                      //               child: Text(
                      //                 "Cancel",
                      //                 style: TextStyle(
                      //                     fontWeight: FontWeight.w700,
                      //                     fontSize: width * 0.05),
                      //               )),
                      //         );
                      //       },
                      //     );
                      //
                      // },
                      child: ListTile(
                        leading: Container(

                          width: width * 0.13,
                          decoration: BoxDecoration(

                              image: DecorationImage(
                                  image: AssetImage(ImageConstants.logout),
                                  scale: width * 0.045,
                                  alignment: AlignmentDirectional(0.2, 0)),
                              shape: BoxShape.circle,
                              color: Color(0xfff8f6f4),
                              border: Border.all(
                                  color: Pallette.primaryColor,
                                  width: width * 0.006)),
                        ),
                        title: Text("Log Out",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        trailing: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Pallette.primaryColor,
                          size: width * 0.05,
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01,)
                  ],
                ),
              ),
              Container(
                width: width * 1,
                height: height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                      spreadRadius: 2,
                      // offset: Offset(0, 4)
                    ),
                  ],
                  color: Pallette.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ListTile(
                      leading: Container(
                        height: height * 0.06,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageConstants.customerSupport),
                              scale: width * 0.035,
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xfff8f6f4),
                            border: Border.all(
                                color: Pallette.primaryColor,
                                width: width * 0.006)),
                      ),
                      title: Text("Help & Support",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Pallette.primaryColor,
                        size: width * 0.05,
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        height: height * 0.06,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageConstants.aboutapp),
                              scale: width * 0.035,
                            ),
                            shape: BoxShape.circle,
                            color: Color(0xfff8f6f4),
                            border: Border.all(
                                color: Pallette.primaryColor,
                                width: width * 0.006)),
                      ),
                      title: Text("About App",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          )),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Pallette.primaryColor,
                        size: width * 0.05,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }
}
