import 'dart:core';


import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';

import '../../../main.dart';

class orderView extends StatefulWidget {
  const orderView({super.key, required this.productName, required this.productImage, required this.price, required this.buyerName, required this.selectindex});
  final String productName;
  final String productImage ;
  final String price ;
  final String buyerName ;
  final int selectindex;

  @override
  State<orderView> createState() => _orderViewState();
}

class _orderViewState extends State<orderView> {

 // int selectindex=0;
  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Confirmed",
          textStyle:  TextStyle(
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        // iconWidget: Container(
        //   width: width*0.03,
        //   height: height*0.03,
        //   decoration:  BoxDecoration(
        //       color: Colors.green,
        //       shape: BoxShape.circle
        //   ),
        //   child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        // )
    ),
    StepperData(
        title: StepperText("On the way",textStyle: TextStyle(
          fontWeight: FontWeight.w500
        )),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        // iconWidget: Container(
        //   width: width*0.03,
        //   height: height*0.03,
        //   decoration:  BoxDecoration(
        //       color: Colors.green,
        //       shape: BoxShape.circle
        //   ),
        //   child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        // )
    ),
    StepperData(
      title: StepperText("Delivered",
          textStyle: TextStyle(
            color: Colors.grey,
          )),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0,
        title:Text("Order Details",style: TextStyle(
        fontSize:width*0.05,
        fontWeight: FontWeight.w600
    )),

    ),

    body: Padding(
    padding:  EdgeInsets.only(right: width*0.04,left: width*0.04,bottom: width*0.04,),
    child:  Column(
        children: [
          Container(
            width: width*1,
            height: height*0.2,
            // color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: width*0.6,
                      height: height*0.1,
                      child: Center(
                        child: Text(widget.productName,
                            style: TextStyle(

                          fontSize: width*0.05,
                        )),
                      ),
                      // color: Colors.green,
                    ),
                    Container(
                      height: width*0.23,
                      width: width*0.23,
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(image: NetworkImage(widget.productImage),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(width*0.02)
                      ),
                      // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                    ),
                  ],
                ),
                Text(widget.buyerName,style: TextStyle(
                  color: Pallette.grey1
                ),),
                Text(widget.price,style: TextStyle(
                  fontSize: width*0.05
                ),)

              ],
            ),
          ),

          AnotherStepper(
            stepperList: stepperData,
            stepperDirection: Axis.vertical,
            inverted: false,
            activeIndex: widget.selectindex,
            barThickness: width*0.006,
            activeBarColor: Colors.green,
            verticalGap: width*0.07,

          ),


          Container(
           height: height*0.07,
           width: width*1,
           decoration: BoxDecoration(
               color: Pallette.secondaryBrown,
             borderRadius: BorderRadius.circular(width*0.015),
           ),
            child: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                      height: height*0.03,
                      child: Image.asset(imageConstants.checkout)),
                ),
                Text("You can cancel this order till tomorrow 12 PM",
                style: TextStyle(
                  fontSize: width*0.03
                )),
              ],
            ),),
          ),
          gap,
          InkWell(
            onTap: () {
              // FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update({
              //   "booking":"noOrder"
              // });
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>steper() ,));
            },
            child: Container(
              height: height*0.06,
              width: width*0.8,
              decoration: BoxDecoration(
                color: Pallette.primaryColor,
             borderRadius: BorderRadius.circular(width*0.02)
              ),
              child: Center(
                child: Text("Cancel",
                    style: TextStyle(
                      color: Pallette.white,
            
                      fontSize: width*0.04,
                    )),
              ),
            
            ),
          )
        ],
      ),

    )
    );
  }
}