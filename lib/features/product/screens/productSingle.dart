import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:luna_demo/Payment/screens/deliveryAddress.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../main.dart';

class ProducctSingleScreen extends StatefulWidget {
  final String image;
  final String tag;
  const ProducctSingleScreen(
      {super.key, required this.image, required this.tag});

  @override
  State<ProducctSingleScreen> createState() => _ProducctSingleScreenState();
}

class _ProducctSingleScreenState extends State<ProducctSingleScreen> {
  double value = 3.5;
  int currentIndex = 0;
  bool fav = false;
  int count = 0;
  List images = [
    imageConstants.rabbit,
    imageConstants.cat,
    imageConstants.bird,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          InkWell(
            onTap: () {
              fav = !fav;
              setState(() {});
            },
            child: Icon(
              Icons.favorite,
              color: fav ? Colors.red : Colors.black,
            ),
          ),
          SizedBox(
            width: width * 0.03,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        autoPlayAnimationDuration: Duration(seconds: 2)),
                    itemBuilder: (context, index, realIndex) {
                      return Hero(
                        tag: widget.tag,
                        child: Container(
                          height: height * 0.25,
                          width: width * 1,
                          margin: EdgeInsets.only(left: width * 0.03),
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(width * 0.03),
                              image: DecorationImage(
                                  image: AssetImage(widget.image),
                                  fit: BoxFit.cover)),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: height * 0.24,
                    left: width * 0.37,
                    child: AnimatedSmoothIndicator(
                      activeIndex: currentIndex,
                      count: images.length,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Beagle age(6-60 days), sex-male\nKCI certified: No",
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                      Text(
                        "\₹ 1000",
                        style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.w800),
                      ),
                    ]),
                SizedBox(
                  height: height * 0.02,
                ),
                RatingStars(
                  value: value,
                  onValueChanged: (v) {
                    //
                    setState(() {
                      value = v;
                    });
                  },
                  starBuilder: (index, color) => Icon(
                    Icons.ac_unit_outlined,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  valueLabelColor: const Color(0xff9b9b9b),
                  valueLabelTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: 12.0),
                  valueLabelRadius: 10,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: true,
                  valueLabelVisibility: true,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Pallette.primaryColor,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          count <= 0 ? 0 : count--;
                          setState(() {});
                        },
                        child: Icon(CupertinoIcons.minus)),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Container(
                      height: height * 0.05,
                      width: width * 0.1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.03),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Center(child: Text(count.toString())),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    InkWell(
                        onTap: () {
                          count++;
                          setState(() {});
                        },
                        child: Icon(CupertinoIcons.add)),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Detail",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.045,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Composition",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: width * 0.045,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined)
                  ],
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            color: Pallette.primaryColor),
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => deliveryAddress(),));
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.03),
                            color: Pallette.primaryColor),
                        child: Center(
                          child: Text(
                            "BUY NOW",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: width * 0.04,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
