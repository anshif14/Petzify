import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/features/bookings/controller/booking_controller.dart';
import 'package:luna_demo/features/bookings/screens/paymentMethods.dart';
import 'package:luna_demo/model/booking_model.dart';

import '../../../commons/widgets.dart';
import '../../../main.dart';


class deliveryAddress extends ConsumerStatefulWidget {
   deliveryAddress({super.key,required this.bookingdata});
  BookingModel bookingdata;


  @override
  ConsumerState<deliveryAddress> createState() => _deliveryAddressState();
}

class _deliveryAddressState extends ConsumerState<deliveryAddress> {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController numbercontroller=TextEditingController();

  add(){
    //  =BookingModel(productName:"", price: "", qty: "", buyerName: namecontroller.text, buyerAddress: addresscontroller.text, buyerPhoneNumer: numbercontroller.text, buyerId: "", paymentMethod: "");
    BookingModel bookingModel =widget.bookingdata.copyWith(buyerName: namecontroller.text,
      buyerAddress: addresscontroller.text,buyerPhoneNumer: numbercontroller.text);
    // ref.watch(bookingContollerProvider).AddBooking(bookingModel);

    Navigator.push(context, CupertinoPageRoute(builder: (context) =>paymentMethod(bookingModel1: bookingModel,) ,));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Add delivery address",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                gap,
                TextFormField(
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  controller: namecontroller,
                  style: TextStyle(
                      color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                          color:CupertinoColors.black,
                          fontSize: width*0.04
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide:BorderSide(color: Pallette.primaryColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide: BorderSide(color: Pallette.primaryColor)
                      )
                  ),
                ),
                gap,
                TextFormField(
                  textInputAction: TextInputAction.newline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.multiline,
                  controller: addresscontroller,
                  maxLines: 3,
                  style: TextStyle(
                      color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(
                          color:CupertinoColors.black,
                          fontSize: width*0.04
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide:BorderSide(color: Pallette.primaryColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide: BorderSide(color: Pallette.primaryColor)
                      )
                  ),
                ),
                gap,
                TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  controller: numbercontroller,
                  style: TextStyle(
                      color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(
                          color:CupertinoColors.black,
                          fontSize: width*0.04
                      ),
                      focusedBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide:BorderSide(color: Pallette.primaryColor)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                          borderSide: BorderSide(color: Pallette.primaryColor)
                      )
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                add();
              },
              child: Container(
                height: height*0.06,
                width: width*0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.3),
                    color:Pallette.primaryColor
                ),
                child: Center(
                  child: Text("Next",style: TextStyle(
                    color: Pallette.white,
                      fontSize: width*0.04,
                  fontWeight: FontWeight.w600
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


