import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/bookings/screens/order_details.dart';

import '../../../commons/image Constants.dart';
import '../../../commons/seachParam.dart';
import '../../../main.dart';
import '../../../model/booking_model.dart';
import '../../home/screen/navbar.dart';
import '../controller/booking_controller.dart';

class ConfirmPage extends ConsumerStatefulWidget {
  BookingModel bookingModel1;
  final double dcharge;
  final double price;
  ConfirmPage(
      {super.key,
      required this.bookingModel1,
      required this.dcharge,
      required this.price});
  // final Map<String, dynamic> slotbooking;

  @override
  ConsumerState<ConfirmPage> createState() => _confirmationState();
}

class _confirmationState extends ConsumerState<ConfirmPage> {
  String cont = "Cash on delivery";

  add() {
    BookingModel bookingdata = widget.bookingModel1.copyWith(
        paymentMethod: cont,
        price: (double.parse(widget.price.toString()) +
                double.parse(widget.dcharge.toString()))
            .toStringAsFixed(2),
        search: setSearchParam(widget.bookingModel1.productName));
    ref.watch(addBookingProvider(bookingdata));
  }

  String tik = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Pallette.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.black,
              )),
          title: Text(
            "Payment",
            style:
                TextStyle(fontWeight: FontWeight.w600, fontSize: width * 0.05),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(
                top: width * 0.05, left: width * 0.05, right: width * 0.05),
            child: Container(
                width: width * 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(
                        //   child: Container(
                        //     width: width*0.7,
                        //     height: height*0.23,
                        //
                        //     child: Image.asset(ImageConstants.payment,),
                        //   ),
                        // ),
                        Text(
                          "Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        SizedBox(
                          height: height * 0.012,
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => orderDetails(
                                    bookingModel1: widget.bookingModel1,
                                    price: widget.price.toString(),
                                    paymentMethod: cont,
                                  ),
                                ));
                          },
                          child: Container(
                            height: height * 0.12,
                            width: width * 1,
                            decoration: BoxDecoration(
                                color: Pallette.secondaryBrown,
                                borderRadius:
                                    BorderRadius.circular(width * 0.015)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(width * 0.025),
                                      child: Container(
                                        height: height * 0.245,
                                        width: width * 0.22,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.015),
                                          child: CachedNetworkImage(
                                            imageUrl: widget
                                                .bookingModel1.productImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: width * 0.48,
                                          child: Text(
                                              widget.bookingModel1.productName,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                // fontSize:14.36,
                                                fontSize: width * 0.042,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ),
                                        Container(
                                          width: width * 0.45,
                                          child: Text(
                                              widget.bookingModel1.buyerName,
                                              style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.038,
                                              )),
                                        ),
                                        Text(
                                          "\₹ ${widget.price}",
                                          style: TextStyle(
                                              fontSize: width * 0.04,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                              height: width * 0.003),
                                        ),
                                        Text(
                                          widget.bookingModel1.state,
                                          style: TextStyle(
                                              fontSize: width * 0.035,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                              height: width * 0.002),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: width * 0.055),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.black,
                                    size: width * 0.05,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        gap,
                        gap,
                        gap,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment method",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Google Pay",
                                    style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 17),
                                  ),
                                  trailing: Radio(
                                    activeColor: Pallette.primaryColor,
                                    fillColor: MaterialStatePropertyAll(
                                        Pallette.primaryColor),
                                    value: "Google Pay",
                                    groupValue: cont,
                                    onChanged: (value) {},
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Credit/Debit",
                                    style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 17),
                                  ),
                                  trailing: Radio(
                                    activeColor: Pallette.primaryColor,
                                    fillColor: MaterialStatePropertyAll(
                                        Pallette.primaryColor),
                                    value: "Credit/Debit",
                                    groupValue: cont,
                                    onChanged: (value) {},
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    "Cash on delivery",
                                    style: TextStyle(
                                        color: CupertinoColors.black,
                                        fontSize: 17),
                                  ),
                                  trailing: Radio(
                                    activeColor: Pallette.primaryColor,
                                    fillColor: MaterialStatePropertyAll(
                                        Pallette.primaryColor),
                                    value: "Cash on delivery",
                                    groupValue: cont,
                                    onChanged: (value) {
                                      setState(() {
                                        cont = value!;
                                      });
                                    },
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Text(
                                //       "Online payment",
                                //       style: TextStyle(
                                //           fontSize: width * 0.052,
                                //           fontWeight: FontWeight.w400),
                                //     ),
                                //     SizedBox(
                                //       width: width * 0.03,
                                //     ),
                                //     // RadioMenuButton(value: value, groupValue: groupValue, onChanged: onChanged, child: child)
                                //     RadioMenuButton(
                                //         style: ButtonStyle(
                                //           overlayColor:
                                //           MaterialStatePropertyAll(
                                //               Colors.black),
                                //         ),
                                //         value: "Online payment",
                                //         groupValue: tik,
                                //         onChanged: (value) {
                                //           setState(() {
                                //             tik = value!;
                                //           });
                                //         },
                                //         child: Text(""))
                                //   ],
                                // ),
                                // Row(
                                //   crossAxisAlignment:
                                //   CrossAxisAlignment.start,
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceAround,
                                //   children: [
                                //     Text(
                                //       "Cash on delivery",
                                //       style: TextStyle(
                                //           fontSize: width * 0.052,
                                //           fontWeight: FontWeight.w400),
                                //     ),
                                //     SizedBox(
                                //       width: width * 0.03,
                                //     ),
                                //     // RadioMenuButton(value: value, groupValue: groupValue, onChanged: onChanged, child: child)
                                //     RadioMenuButton(
                                //         style: ButtonStyle(
                                //           overlayColor:
                                //           MaterialStatePropertyAll(
                                //              Colors.black),
                                //         ),
                                //         value: "Cash on delivery",
                                //         groupValue: tik,
                                //         onChanged: (value) {
                                //           setState(() {
                                //             tik = value!;
                                //           });
                                //         },
                                //         child: Text(""))
                                //   ],
                                // ),
                              ],
                            ),
                          ],
                        ),

                        gap,
                        Row(
                          children: [
                            Container(
                                height: height * 0.05,
                                width: width * 0.1,
                                child: SvgPicture.asset(
                                    ImageConstants.deliverycar)),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            widget.dcharge > 0
                                ? Text(
                                    "Delivery Charge : ${widget.dcharge}",
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "Free Delivery",
                                    style: TextStyle(
                                        fontSize: width * 0.038,
                                        fontWeight: FontWeight.w600),
                                  )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: height * 0.07,
                      width: width * 1,
                      color: Pallette.secondaryBrown,
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Price  :",
                              style: TextStyle(
                                fontSize: width * 0.048,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: width * 0.015),
                            Text(
                              "\₹ ${(double.parse(widget.price.toString()) + double.parse(widget.dcharge.toString())).toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.w700,
                                color: Pallette.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.08,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    InkWell(
                      onTap: () async {
                        await add();
                        setState(() {});
                        // bookingdata();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                surfaceTintColor: Pallette.secondaryBrown,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.05)),
                                content: Container(
                                  height: height * 0.5,
                                  width: width * 1,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * 0.03)),
                                  child: Column(
                                    children: [
                                      Lottie.asset(ImageConstants.lottie),
                                      Text(
                                        "Successfully Ordered!!",
                                        style:
                                            TextStyle(fontSize: width * 0.045),
                                      ),

                                      // gap,
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      //   children: [
                                      //     ElevatedButton(onPressed: () {
                                      //       Navigator.push(context, CupertinoPageRoute(builder:
                                      //           (context) => reviewPage(id: widget.id,),));
                                      //     }, child: Text("Give a Review",style: TextStyle(color: Pallette.white),),
                                      //     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Pallette.primaryColor)),
                                      //     ),
                                      //     ElevatedButton(onPressed: () {
                                      //       Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NavBar(),));
                                      //     }, child: Text("Ok",style: TextStyle(color: Pallette.white),),
                                      //       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Pallette.primaryColor)
                                      //       )
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                ),
                              );
                            });
                        Future.delayed(Duration(seconds: 2))
                            .then((value) => Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => NavBar(
                                    passindex: 0,
                                  ),
                                ),
                                (route) => false));
                      },
                      child: Center(
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.3),
                              color: Pallette.primaryColor),
                          child: Center(
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                  color: Pallette.white,
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.005,
                    ),
                  ],
                ))));
  }
}
