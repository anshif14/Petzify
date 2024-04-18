import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../commons/widgets.dart';
import '../../../main.dart';
import '../../../model/product_Model.dart';

class adsView extends StatefulWidget {
  final String id;
  const adsView({super.key,required this.id});

  @override
  State<adsView> createState() => _adsViewState();
}

class _adsViewState extends State<adsView> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(width * 0.03),
                                        image: DecorationImage(
                                            image: NetworkImage(image[index]),
                                            fit: BoxFit.cover)),
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
                                      overflow: TextOverflow.values[0],
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
                            SizedBox(
                              height: height * 0.02,
                            ),
                            gap,
                            Text(data.description,
                              style: TextStyle(fontSize: width * 0.04),),
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
    );
  }
}
