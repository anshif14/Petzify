import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/order/controller/order_stream_controller.dart';
import 'package:luna_demo/features/order/screen/orderView.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../../model/booking_model.dart';

class myOrder extends ConsumerStatefulWidget {
  const myOrder({super.key});

  @override
  ConsumerState<myOrder> createState() => _myOrderState();
}

class _myOrderState extends ConsumerState<myOrder> {
  TextEditingController searchController = TextEditingController();
  final search=StateProvider<String>((ref) => '');

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
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
                height: height * 0.055,
                decoration: BoxDecoration(
                    color: Pallette.secondaryBrown,
                    borderRadius: BorderRadius.circular(width*0.03)),
                child: TextFormField(
                  onChanged: (value) {
                    ref.read(search.notifier).update((state) => value.toString().toUpperCase());
                  },
                  controller: searchController,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.search,

                  cursorColor: Pallette.primaryColor,
                  cursorHeight: width*0.055,
                  cursorWidth: width*0.003,
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: width*0.03),
                    prefixIcon:Icon(Icons.search),
                    fillColor: Pallette.grey,
                    filled: true,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.03),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
                  gap,

                  Expanded(
                  child: ref.watch(orderDataStreamProvider(jsonEncode({
                    "usrId":currentUserModel!.id,
                    "search":ref.watch(search)
                  }))).when(
                    data: (data) {
                      return data.isNotEmpty?
                      ListView.separated(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) =>
                              orderView(data: data[index],
                                // productName: data[index].productName,
                                // productImage: data[index].productImage,
                                // price: data[index].price,
                                // buyerName: data[index].buyerName,
                                // selectindex: data[index].selectindex,
                              ),
                          ));
                          setState(() {

                          });
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(width*0.02),
                                      child: CachedNetworkImage(imageUrl:data[index].productImage,fit: BoxFit.cover,)),
                                  // decoration:  BoxDecoration(
                                  //     color: Colors.white,
                                  //     image: DecorationImage(image: NetworkImage(data[index].productImage),fit: BoxFit.cover),
                                  //     borderRadius: BorderRadius.circular(width*0.02)
                                  // ),
                                  // image: DecorationImage(image: AssetImage(coupons[index]["poster"]),fit: BoxFit.cover),
                                ),
                                SizedBox(width: width*0.04,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width*0.5,
                                      // height: height*0.05,
                                      // color: Colors.red,
                                      child: Text(data[index].productName,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                            color: Colors.black,
                                            fontSize: width*0.041
                                        ),
                                      ),
                                    ),
                                    SizedBox(height:width*0.02),
                                    Text(data[index].price,
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
                    },):Center(child:Image.asset(ImageConstants.no_order));
              }, error: (error, stackTrace) => Text(error.toString()), loading: () {
                    return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));

                  },)
                  )
            ],

          ),
        ),
      ),
    );
  }
}
