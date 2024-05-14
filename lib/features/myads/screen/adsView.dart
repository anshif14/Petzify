import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../commons/image Constants.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';
import '../../../model/product_Model.dart';

class adsView extends StatefulWidget {
  final String id;
 // final fun;

  const adsView({super.key,required this.id,});

  @override
  State<adsView> createState() => _adsViewState();
}

class _adsViewState extends State<adsView> {



  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("product").doc(widget.id).snapshots().map((snapshot) {
                    return ProductModel.fromMap(snapshot.data()!);
                  } ),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));


                    }
                    ProductModel data=snapshot.data!;
                    List image=data.image;

                    return Container(
                      height: height*0.84,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                CarouselSlider.builder(
                                  itemCount: image.length,
                                  options: CarouselOptions(
                                      viewportFraction: 1,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      autoPlayAnimationDuration: Duration(seconds: 2)),
                                  itemBuilder: (context, index, realIndex) {
                                    return Container(
                                      height: height * 0.25,
                                      width: width * 1,
                                      margin: EdgeInsets.only(left: width * 0.03),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(width * 0.03),
                                          child: CachedNetworkImage(imageUrl:image[index],fit: BoxFit.cover,)),
                                      // decoration: BoxDecoration(
                                      //     color: Colors.yellow,
                                      //     borderRadius: BorderRadius.circular(width * 0.03),
                                      //     image: DecorationImage(
                                      //         image: NetworkImage(image[index]),
                                      //         fit: BoxFit.cover)),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: height * 0.24,
                                  left: width * 0.37,
                                  child: AnimatedSmoothIndicator(
                                    activeIndex: currentIndex,
                                    count: image.length,
                                    effect: ExpandingDotsEffect(
                                        dotHeight: height * 0.006,
                                        activeDotColor: Pallette.primaryColor,
                                        dotColor: Colors.grey.shade300),
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: height * 0.015,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:width*0.5,
                                      child: Text(
                                        "${data.productname} ",
                                        // overflow: TextOverflow.values[0],
                                        style: TextStyle(
                                            color: Pallette.primaryColor,
                                            fontSize: width * 0.045,
                                            fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "\₹ ${data.price}",
                                        style: TextStyle(
                                            fontSize: width * 0.05,
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ]),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              gap,
                              Text(data.description,
                                style: TextStyle(fontSize: width * 0.04),),
                           // gap,
                           // Center(
                           //   child: GestureDetector(
                           //     onTap: () {
                           //       showCupertinoModalPopup(
                           //         barrierColor: Colors.black.withOpacity(0.5),
                           //         barrierDismissible: false,
                           //         context: context,
                           //         builder: (context) {
                           //           return CupertinoAlertDialog(
                           //             content: Text("Are you Sure\nYou Want to Remove !",
                           //                 style: TextStyle(
                           //                     fontWeight: FontWeight.w400,
                           //                     fontSize: width * 0.045)),
                           //             actions: [
                           //               CupertinoDialogAction(
                           //                 isDefaultAction: true,
                           //                 isDestructiveAction: true,
                           //                 onPressed: () {
                           //                   Navigator.pop(context);
                           //                 },
                           //                 child: Text("Cancel"),
                           //               ),
                           //               CupertinoDialogAction(
                           //                 isDefaultAction: true,
                           //                 onPressed: (){
                           //                   // widget.fun;
                           //                   // await remove();
                           //                   // await  updatedata();
                           //                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
                           //                     crossAxisAlignment: CrossAxisAlignment.end,
                           //                     mainAxisAlignment: MainAxisAlignment.start,
                           //                     children: [
                           //                       SizedBox(
                           //                         width: width*0.05,
                           //                       ),
                           //
                           //                       Center(
                           //                         child: Container(
                           //                             height: height*0.04,
                           //                             width: width*0.1,
                           //                             // color: Colors.red,
                           //                             child: Lottie.asset(ImageConstants.remove,fit: BoxFit.fitHeight)),
                           //                       ),
                           //                       SizedBox(
                           //                         width: width*0.015,
                           //                       ),
                           //
                           //                       Text("Deleted Success",style: TextStyle(
                           //                           fontSize: width*0.04,
                           //                           color: Pallette.white
                           //                       ),)
                           //                     ],
                           //
                           //                   ),backgroundColor: Colors.black.withOpacity(0.85),
                           //                     behavior: SnackBarBehavior.floating,
                           //                     showCloseIcon: true,
                           //                     padding:  EdgeInsets.only(bottom: width*0.012,top: width*0.001),
                           //                     // duration: Duration(seconds: 2),
                           //                   ));
                           //
                           //                   // Navigator.pop(context);
                           //                   // Navigator.pop(context);
                           //
                           //                 },
                           //                 child: Text("Confirm",
                           //                     style: TextStyle(
                           //                         color: Colors.black
                           //                     )),
                           //               ),
                           //             ],
                           //           );
                           //         },
                           //       );
                           //     },
                           //     child: Container(
                           //          height: height * 0.06,
                           //          width: width * 0.4,
                           //          decoration: BoxDecoration(
                           //            color: Pallette.primaryColor,
                           //            borderRadius: BorderRadius.circular(width * 0.025),
                           //          ),
                           //          child: Row(
                           //            mainAxisAlignment: MainAxisAlignment.center,
                           //            children: [
                           //              Icon(CupertinoIcons.delete,color: Pallette.white,
                           //                  size: width*0.06),
                           //              SizedBox(width: width*0.01,),
                           //              Center(
                           //                child: Text("Remove",style: TextStyle(
                           //                    color: Pallette.white,
                           //                    fontSize: width*0.04
                           //                ),),
                           //              ),
                           //            ],
                           //          ),
                           //        ),
                           //   ),
                           // ),

                            ],
                          ),

                        ],
                      ),
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
