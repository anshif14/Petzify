//
// import 'package:flml_internet_checker/flml_internet_checker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:lottie/lottie.dart';
// import 'package:luna_demo/commons/color%20constansts.dart';
// import 'package:luna_demo/commons/image%20Constants.dart';
//
// import 'package:luna_demo/features/home/screen/navbar.dart';
// import 'package:luna_demo/model/booking_model.dart';
//
// import '../../../commons/seachParam.dart';
// import '../../../commons/widgets.dart';
// import '../../../main.dart';
// import '../controller/booking_controller.dart';
//
//
// class paymentMethod extends ConsumerStatefulWidget {
//    paymentMethod({super.key,required this.bookingModel1,});
//   BookingModel bookingModel1;
//
//   @override
//   ConsumerState<paymentMethod> createState() => _paymentMethodState();
// }
//
// class _paymentMethodState extends ConsumerState<paymentMethod> {
//   String cont="COD";
//   add(){
//     BookingModel bookingdata=widget.bookingModel1.copyWith(
//       paymentMethod: cont,
//       search: setSearchParam(widget.bookingModel1.productName)
//
//     );
//     ref.watch(addBookingProvider(bookingdata));
//
//   }
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return InternetChecker(
//       placeHolder: Container(
//         child: Lottie.asset(ImageConstants.netdog),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           surfaceTintColor: Pallette.white,
//           toolbarHeight: height*0.04,
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(
//                 CupertinoIcons.back,
//                 color: Colors.black,
//               )),
//           title: Text("Payment",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05),),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: width*1,
//                 height: height*0.35,
//                 child: Image.asset(ImageConstants.payment,fit: BoxFit.cover,),
//               ),
//               Column(
//                 children: [
//                   Container(
//
//                     width: width*1,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(width*0.03),
//                       border: Border.all(color: Pallette.primaryColor)
//                     ),
//                     child: Center(
//                       child: ListTile(
//                         title: Text("Google Pay",style: TextStyle(color: CupertinoColors.black,),),
//                         trailing:Radio(
//                           activeColor: Pallette.primaryColor,
//                           fillColor: WidgetStatePropertyAll(Pallette.primaryColor),
//                           value: "G",
//                           groupValue: cont,
//                           onChanged: (value) {
//
//                           },
//                         ) ,
//                       ),
//                     ),
//                   ),
//                   gap,
//                   Container(
//                     width: width*1,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(width*0.03),
//                       border: Border.all(color: Pallette.primaryColor)
//                     ),
//                     child: ListTile(
//                       title: Text("Credit/Debit",style: TextStyle(color: CupertinoColors.black,),),
//                       trailing:Radio(
//                         activeColor: Pallette.primaryColor,
//                         fillColor: MaterialStatePropertyAll(Pallette.primaryColor),
//                         value: "C",
//                         groupValue: cont,
//                         onChanged: (value) {
//
//                         },
//                       ) ,
//                     ),
//                   ),
//                   gap,
//                   Container(
//                     width: width*1,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(width*0.03),
//                       border: Border.all(color: Pallette.primaryColor)
//                     ),
//                     child: ListTile(
//                       title: Text("COD",style: TextStyle(color: CupertinoColors.black,),),
//                       trailing:Radio(
//                         activeColor: Pallette.primaryColor,
//                         fillColor: WidgetStatePropertyAll(Pallette.primaryColor),
//                         value: "COD",
//                         groupValue: cont,
//                         onChanged: (value) {
//                           setState(() {
//                             cont=value!;
//                           });
//                         },
//                       ) ,
//                     ),
//                   ),
//                 ],
//               ),
//               gap,
//               InkWell(
//                 onTap: () async {
//
//                 await  add();
//                 setState(() {
//
//                 });
//
//                   showDialog(
//                       context: context,
//                       builder: (context){
//                         return AlertDialog(
//                           surfaceTintColor: Pallette.secondaryBrown,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(width*0.05)
//                           ),
//                           content: Container(
//                             height: height*0.5,
//                             width: width*1,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(width*0.03)
//                             ),
//                             child: Column(
//                               children: [
//                                 Lottie.asset(ImageConstants.lottie),
//                                 Text("Successfully Ordered!!",style: TextStyle(fontSize: width*0.045),),
//
//                                 // gap,
//                                 // Row(
//                                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 //   children: [
//                                 //     ElevatedButton(onPressed: () {
//                                 //       Navigator.push(context, CupertinoPageRoute(builder:
//                                 //           (context) => reviewPage(id: widget.id,),));
//                                 //     }, child: Text("Give a Review",style: TextStyle(),),
//                                 //     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll()),
//                                 //     ),
//                                 //     ElevatedButton(onPressed: () {
//                                 //       Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NavBar(),));
//                                 //     }, child: Text("Ok",style: TextStyle(),),
//                                 //       style: ButtonStyle(backgroundColor: MaterialStatePropertyAll()
//                                 //       )
//                                 //     )
//                                 //   ],
//                                 // )
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                   );
//                 Future.delayed(Duration(seconds: 2))
//                     .then((value) => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder:
//                     (context) => NavBar(passindex: 0,),), (route) => false));
//
//
//                 },
//                 child: Container(
//                   height: height*0.06,
//                   width: width*0.7,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(width*0.3),
//                       color:Pallette.primaryColor
//                   ),
//                   child: Center(
//                     child: Text("Continue",style: TextStyle(
//                         color: Pallette.white,
//                         fontSize: width*0.04,
//                         fontWeight: FontWeight.w600
//                     ),),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
