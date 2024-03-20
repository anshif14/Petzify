import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';

import '../../../main.dart';

class orderView extends StatefulWidget {
  const orderView({super.key});

  @override
  State<orderView> createState() => _orderViewState();
}

class _orderViewState extends State<orderView> {

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Order Confirmed",
          textStyle:  TextStyle(
          ),
        ),
        subtitle: StepperText("Your order has been placed"),
        iconWidget: Container(
          width: width*0.03,
          height: height*0.03,
          decoration:  BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
          ),
          child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        )
    ),
    StepperData(
        title: StepperText("On the way",textStyle: TextStyle(
          fontWeight: FontWeight.w500
        )),
        subtitle: StepperText(
            "Our delivery executive is on the way to deliver your item"),
        iconWidget: Container(
          width: width*0.03,
          height: height*0.03,
          decoration:  BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle
          ),
          child:  Icon(Icons.check, color: Colors.white,size: width*0.04),
        )
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
                        child: Text('Clown fish',
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
                          image: DecorationImage(image: AssetImage(imageConstants.fish),fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(width*0.02)
                      ),
                      // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                    ),
                  ],
                ),
                Text("seller :ashik",style: TextStyle(
                  color: Pallette.grey1
                ),),
                Text("₹ 1000",style: TextStyle(
                  fontSize: width*0.05
                ),)

              ],
            ),
          ),

          AnotherStepper(
            stepperList: stepperData,
            stepperDirection: Axis.vertical,
            inverted: false,
            activeIndex: 1,
            activeBarColor: Colors.green,verticalGap: width*0.07,
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
          Container(
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

          )
        ],
      ),

    )
    );
  }
}