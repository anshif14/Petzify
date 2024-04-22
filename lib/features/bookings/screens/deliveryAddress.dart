import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/features/bookings/controller/booking_controller.dart';
import 'package:luna_demo/features/bookings/screens/paymentMethods.dart';
import 'package:luna_demo/model/booking_model.dart';

import '../../../commons/image Constants.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';


class deliveryAddress extends ConsumerStatefulWidget {
  deliveryAddress({super.key,required this.bookingdata});
  final BookingModel bookingdata;


  @override
  ConsumerState<deliveryAddress> createState() => _deliveryAddressState();
}

class _deliveryAddressState extends ConsumerState<deliveryAddress> {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController numbercontroller=TextEditingController();

  add(){
    //  =BookingModel(productName:"", price: "", qty: "", buyerName: namecontroller.text, buyerAddress: addresscontroller.text, buyerPhoneNumer: numbercontroller.text, buyerId: "", paymentMethod: "");
    BookingModel bookingModel =widget.bookingdata.copyWith(buyerName: namecontroller.text.trim(),
      buyerAddress: addresscontroller.text.trim(),buyerPhoneNumer: numbercontroller.text.trim());
    // ref.watch(bookingContollerProvider).AddBooking(bookingModel);

    Navigator.push(context, CupertinoPageRoute(builder: (context) =>paymentMethod(bookingModel1: bookingModel,) ,));

  }

  final formKey=GlobalKey<FormState>();
  String phoneNumber='';
  String? state;
  var states=[
    "Andhra Pradesh",
    "ArunachalPradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal"
  ];

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(ImageConstants.delivery),
                    gap,
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.text,
                      controller: namecontroller,
                      cursorColor: Pallette.primaryColor,
                      maxLength: 50,
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                        counterText: "",
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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         height: height*0.07,
                         width: width*0.5,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(width*0.03),
                           border: Border.all(color: Pallette.primaryColor)
                         ),
                         child:  Padding(
                           padding: EdgeInsets.all(width * 0.04),
                           child: DropdownButton(
                             hint: Text(
                               "States",
                               style: TextStyle(
                                 fontSize: width * 0.045,
                               ),
                             ),
                             dropdownColor: Pallette.white,
                             icon: Icon(Icons.arrow_drop_down),
                             isExpanded: true,
                             underline: gap,
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: width * 0.043,
                             ),
                             value: state,
                             items: states.map(
                                   (valueItem) {
                                 return DropdownMenuItem(
                                   value: valueItem,
                                   child: Text(valueItem),
                                 );
                               },
                             ).toList(),
                             onChanged: (newValue) {
                               setState(() {
                                 state = newValue.toString();
                               });
                             },
                           ),
                         ),
                       ),
                       Container(
                         height: height*0.07,
                         width: width*0.4,
                         child: TextFormField(
                           textInputAction: TextInputAction.next,
                           autovalidateMode: AutovalidateMode.onUserInteraction,
                           keyboardType: TextInputType.text,
                           controller: namecontroller,
                           cursorColor: Pallette.primaryColor,
                           maxLength: 50,
                           style: TextStyle(
                               color: CupertinoColors.black
                           ),
                           decoration: InputDecoration(
                               counterText: "",
                               labelText: "District",
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
                       ),
                     ],
                   ),

                    gap,
                    // TextFormField(
                    //   textInputAction: TextInputAction.done,
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   keyboardType: TextInputType.number,
                    //   controller: numbercontroller,
                    //   maxLength: 10,
                    //   inputFormatters: [
                    //     FilteringTextInputFormatter.digitsOnly,
                    //   ],
                    //   style: TextStyle(
                    //       color: CupertinoColors.black
                    //   ),
                    //   decoration: InputDecoration(
                    //       labelText: "Phone Number",
                    //       labelStyle: TextStyle(
                    //           color:CupertinoColors.black,
                    //           fontSize: width*0.04
                    //       ),
                    //       focusedBorder:OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(width*0.03),
                    //           borderSide:BorderSide(color: Pallette.primaryColor)
                    //       ),
                    //       enabledBorder: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(width*0.03),
                    //           borderSide: BorderSide(color: Pallette.primaryColor)
                    //       )
                    //   ),
                    // ),
                    IntlPhoneField(
                      controller: numbercontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      cursorColor: Pallette.primaryColor,
                      style: TextStyle(
                        fontSize: width * 0.05,
                      ),
                      decoration: InputDecoration(

                        contentPadding: EdgeInsets.all(width*0.04),
                        counterText: "",
                        labelText: "Phone Number",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Pallette.primaryColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(width*0.03),
                                    borderSide: BorderSide(color: Pallette.primaryColor)
                                ),
                        focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(width*0.03),
                                    borderSide:BorderSide(color: Pallette.primaryColor)
                                ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                        phoneNumber = phone.completeNumber;

                      },
                    ),
                  ],
                ),
              ),
              gap,
              InkWell(
                onTap: () {
                  if(namecontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Name")));
                    return;
                  }
                  // if(addresscontroller.text.isEmpty){
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Address")));
                  //   return;
                  // }
                  if(numbercontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Phone Number")));
                    return;
                  }
                  if(formKey.currentState!.validate()){
                    add();
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your valid Number")));

                  }
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
      ),
    );
  }
}


