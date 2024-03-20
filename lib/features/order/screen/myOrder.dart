import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/order/screen/orderView.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';

class myOrder extends StatefulWidget {
  const myOrder({super.key});

  @override
  State<myOrder> createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Pallette.white,
        title:Text("My Order",style: TextStyle(
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
            // Container(
            //   height: height * 0.08,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Icon(Icons.search),
            //           ),
            //           Text(
            //             "Search",
            //             style: TextStyle(color: Colors.grey),
            //           )
            //         ],
            //       ),
            //       height: height * 0.06,
            //       decoration: BoxDecoration(
            //           color: Pallette.grey,
            //           borderRadius: BorderRadius.circular(10)),
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => orderView(),));
                      },
                      child: Container(
                        height: height*0.12,
                        width: width*1,
                        child: Padding(
                          padding: EdgeInsets.all(width*0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(width:width*0.02),
                              Container(
                                height: width*0.2,
                                width: width*0.2,
                                decoration:  BoxDecoration(
                                    color: Colors.white,
                                  image: DecorationImage(image: AssetImage(imageConstants.fish),fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(width*0.02)
                                ),
                                // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Fish",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width*0.041
                                    ),
                                  ),
                                  SizedBox(height:width*0.02),
                                  Text("Clown Fish",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: width*0.041
                                    ),
                                  ),
                                ],
                              ),
                              gap,
                              gap,
                              gap,
                              Icon(Icons.arrow_forward_ios_outlined,
                                color: Pallette.primaryColor,
                                size: width*0.04,

                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Pallette.primaryColor,);
                  },),
            )
          ],

        ),
      ),
    );
  }
}
