import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/profile/screen/editProfile.dart';

import '../../../main.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({super.key});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff8f6f4),
      appBar: AppBar(
        backgroundColor: Color(0xfff8f6f4),
        elevation: 0,
        title:Text("Profile",style: TextStyle(
            fontSize:width*0.06,
            color: Colors.black,
            fontWeight: FontWeight.w600
        )),
        // backgroundColor: Colors.yellow,
        toolbarHeight: height*0.06,
      ),
      body: Padding(
        padding:  EdgeInsets.only(right: width*0.04,left: width*0.04,bottom: width*0.04,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height:height*0.11,
              width: width*1,
              decoration: BoxDecoration(
                // color: Pallette.profile,
                color: Pallette.primaryColor,
                borderRadius: BorderRadius.circular(width*0.02),
                border: Border.all(color: Colors.white,width: width*0.005),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    spreadRadius: 1,
                   offset: Offset(0, 4)
                  ),

                ]
              ),
              child: Padding(
                padding:  EdgeInsets.only(left: width*0.04,right: width*0.06,top: width*0.02,bottom: width*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: width*0.09,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Pallette.secondaryBrown,
                            radius: width*0.085,
                            backgroundImage: NetworkImage(
                              "https://w7.pngwing.com/pngs/86/421/png-transparent-computer-icons-user-profile-set-of-abstract-icon-miscellaneous-monochrome-computer-wallpaper.png",
                            ),
                          ),
                        ),
                        SizedBox(width: width*0.03,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Ashik Muhammed",
                            style: TextStyle(
                              fontSize: width*0.04,
                               fontWeight: FontWeight.w600,
                              color: Colors.white
                            )),
                            Text("Perintalmanna",
                            style: TextStyle(
                              fontSize: width*0.035,
                              color: Colors.white
                            ),)
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, CupertinoPageRoute(builder: (context) =>editProfile() ,));
                          },
                          child: Container(
                            height: height*0.05,
                            width: width*0.07,
                              child: SvgPicture.asset(imageConstants.editsvg)),
                        )
                      ],
                    )
                  ],
                ),
              ),
              

            ),
            Container(
              width: width*1,
              height: height*0.4,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 4)
                  ),
                ],
                borderRadius: BorderRadius.circular(width*0.02),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    // leading: CircleAvatar(
                    //   radius: width*0.068,
                    //   backgroundColor: Pallette.primaryColor,
                    //   child: CircleAvatar(
                    //     radius: width*0.06,
                    //     backgroundColor: Colors.white,
                    //   ),
                    // ),
                    leading: CircleAvatar(
                      radius: width*0.063,
                      backgroundColor: Pallette.primaryColor,
                      child: CircleAvatar(
                        radius: width*0.055,
                        backgroundColor: Color(0xfff8f6f4),
                      ),
                    ),
                    title: Text("My Order",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                    subtitle: Text("Make changes to your order"),
                    subtitleTextStyle: TextStyle(
                      fontSize: width*0.035,
                      color: Colors.grey.shade600
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Pallette.primaryColor,
                      size: width*0.05,

                    ),
                  ),
                  ListTile(
                    leading:Container(
                      height: height*0.06,
                      width: width*0.13,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfff8f6f4),
                        border: Border.all(color: Pallette.primaryColor,width: width*0.008)

                      ),

                    ),
                    title: Text("Saved Beneficiary",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text("Manage your saved account "),
                    subtitleTextStyle: TextStyle(
                        fontSize: width*0.035,
                        color: Colors.grey.shade600
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Pallette.primaryColor,
                      size: width*0.05,

                    ),
                  ),
                  ListTile(
                    leading:Container(
                      height: height*0.06,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfff8f6f4),
                          border: Border.all(color: Pallette.primaryColor,width: width*0.008)

                      ),

                    ),
                    title: Text("Face ID / Touch ID",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    subtitle: Text("Manage your device security "),
                    subtitleTextStyle: TextStyle(
                        fontSize: width*0.035,
                        color: Colors.grey.shade600
                    ),

                    trailing:  Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            toggle = !toggle;
                            setState(() {});
                          },
                          child: Container(
                            height: height * 0.032,
                            width: width * 0.12,
                            decoration: BoxDecoration(
                              color: toggle ? Pallette.primaryColor:Pallette.profile.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                            duration: Duration(milliseconds: 200),
                            left: toggle ? width * 0.05: width * 0.009,
                            right: toggle ? width * 0.009 : width * 0.05,
                            top: width*0.008,
                            child: InkWell(
                              onTap: () {
                                toggle = !toggle;
                                setState(() {});
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                                height: width * 0.055,
                                width: width * 0.055,
                                decoration: BoxDecoration(
                                    color: Colors.white, shape: BoxShape.circle),
                              ),
                            ))
                      ],
                    ),
                  ),
                  ListTile(
                    leading:Container(
                      height: height*0.06,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfff8f6f4),
                          border: Border.all(color: Pallette.primaryColor,width: width*0.008)

                      ),

                    ),
                    title: Text("Log Out",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Pallette.primaryColor,
                      size: width*0.05,

                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width*1,
              height: height*0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(width*0.02),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 4)
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading:Container(
                      height: height*0.06,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfff8f6f4),
                          border: Border.all(color: Pallette.primaryColor,width: width*0.008)

                      ),

                    ),
                    title: Text("Help & Support",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Pallette.primaryColor,
                      size: width*0.05,

                    ),
                  ),
                  ListTile(
                    leading:Container(
                      height: height*0.06,
                      width: width*0.13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xfff8f6f4),
                          border: Border.all(color: Pallette.primaryColor,width: width*0.008)

                      ),

                    ),
                    title: Text("About App",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,
                      color: Pallette.primaryColor,
                      size: width*0.05,

                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: height*0.03,)
          ],
          
        ),
      ),
    );
  }
}
