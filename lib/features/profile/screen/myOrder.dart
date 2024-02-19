import 'package:flutter/material.dart';

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
      appBar: AppBar(
        elevation: 0,
        title:Text("My Order",style: TextStyle(
            fontSize:width*0.05,
            fontWeight: FontWeight.w600
        )),

        toolbarHeight: height*0.06,
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
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  prefixIcon:Icon(Icons.search),
                  fillColor: Pallette.secondaryBrown,
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
          ],

        ),
      ),
    );
  }
}
