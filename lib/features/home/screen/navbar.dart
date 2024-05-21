import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/profile/screen/profileScreen.dart';
// import 'package:luna_demo/core/features/explore/screens/exploreScren.dart';
// import 'package:luna_demo/core/features/home/home.dart';

import '../../explore/screens/exploreScren.dart';
import '../../favourite/screen/favourite.dart';
import 'home.dart';

class NavBar extends StatefulWidget {
  final int passindex;
  const NavBar({super.key, required this.passindex});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  List pages =[
    HomePage(),
    ExploreScreen(),
    favouritePage(),
    profileScreen()
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    selectedIndex =widget.passindex;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        body: Container(
          child: pages[selectedIndex]
        ),
        bottomNavigationBar: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: GNav(
              color: Pallette.primaryColor,
              haptic: true,
              backgroundColor: Colors.white,
              // style: GnavStyle.google,
              tabBorder: Border.all(color: Pallette.primaryColor),
              gap: 8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              tabMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              onTabChange: (value) {
                selectedIndex = value;
                setState(() {});

              },
              selectedIndex: selectedIndex,
              // haptic: true,

              tabs: [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                  iconActiveColor: Pallette.primaryColor,
                  textColor: Pallette.primaryColor,
                ),
                GButton(
                  icon: Icons.explore,
                  text: "Explore",
                ),
                GButton(
                  icon: Icons.favorite_border,
                  text: 'Favourite',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: "Profile",
                ),
              ]),
        ),
      ),
    );
  }
}
