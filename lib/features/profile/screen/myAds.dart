import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/profile/screen/adsView.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';

class myAds extends StatefulWidget {
  const myAds({super.key});

  @override
  State<myAds> createState() => _myAdsState();
}

class _myAdsState extends State<myAds> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        surfaceTintColor: Pallette.white,

        elevation: 0,
        title:Text("My Ads",style: TextStyle(
            fontSize:width*0.05,

            fontWeight: FontWeight.w600
        )),

      ),

      body: Padding(
      padding:  EdgeInsets.only(right: width*0.04,left: width*0.04,bottom: width*0.04,),
    child: Column(
      children: [
        Container(
          height: height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
            border: Border.all(color: Pallette.primaryColor),
          ),
          child: TextFormField(
            controller: searchController,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.search,
            cursorColor: Pallette.primaryColor,
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              prefixIcon:Icon(Icons.search),
              fillColor: Pallette.white,
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(
                fontSize: width * 0.05,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        SizedBox(height: height*0.015,),
        Expanded(
          child: AnimationLimiter(
            child: GridView.builder(
              itemCount: 14,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.03,
                  mainAxisSpacing: width * 0.03,
                  childAspectRatio: 0.79,),
                itemBuilder: (context, index) {
                return  AnimationConfiguration.staggeredList(
                  position: index,
                  duration:  Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => adsView(),));
                        },
                        child: Container(
                          width: width*0.5,
                          decoration: BoxDecoration(
                              color: Pallette.white,
                            borderRadius: BorderRadius.circular(width*0.02),
                            border: Border.all(color: Pallette.primaryColor),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: height*0.15,
                                  width: width*0.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage(imageConstants.cat)),
                                    borderRadius: BorderRadius.circular(width*0.01)
                                  ),
                                ),
                                Text("₹ 1000",style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: width*0.04
                                ),),
                                Container(
                                  height: height*0.028,
                                  width: width*0.5,
                                  child: Text("Norwegian Forest",style: TextStyle(
                                      fontSize: width*0.04
                                  ),),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined,
                                    size: width*0.05,),
                                    Container(
                                      width: width*0.34,
                                      height: height*0.02,
                                      child: Text("Perinthalmanna,Malappuram",style: TextStyle(
                                        color: Pallette.grey1,
                                          fontSize: width*0.03
                                      ),),
                                    ),
                                ],)

                              ],
                            ),
                          ),

                        ),
                      )
                    ),
                  ),
                );

                },),
          ),
        )
      ],
    )
      )
    );
  }
}
