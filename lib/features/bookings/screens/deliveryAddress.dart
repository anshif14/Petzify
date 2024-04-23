import 'dart:convert';

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
import 'package:http/http.dart' as http;


class deliveryAddress extends ConsumerStatefulWidget {
  deliveryAddress({super.key,required this.bookingdata});
  final BookingModel bookingdata;


  @override
  ConsumerState<deliveryAddress> createState() => _deliveryAddressState();
}

class _deliveryAddressState extends ConsumerState<deliveryAddress> {

  TextEditingController namecontroller=TextEditingController();
  TextEditingController numbercontroller=TextEditingController();
  TextEditingController housecontroller=TextEditingController();
  TextEditingController areacontroller=TextEditingController();
  TextEditingController landmarkcontroller=TextEditingController();
  TextEditingController pincodecontroller=TextEditingController();
  TextEditingController pincodepostalcontroller=TextEditingController();

  add(){
    //  =BookingModel(productName:"", price: "", qty: "", buyerName: namecontroller.text, buyerAddress: addresscontroller.text, buyerPhoneNumer: numbercontroller.text, buyerId: "", paymentMethod: "");
    BookingModel bookingModel =widget.bookingdata.copyWith(buyerName: namecontroller.text.trim(),
      state: state,buyerhouseno:housecontroller.text.trim(),buyerarea:areacontroller.text.trim(),
        buyerlandmark:landmarkcontroller.text.trim(),pincode:pincodecontroller.text.trim(),
        buyercity:pincodepostalcontroller.text.trim(),buyerPhoneNumer: numbercontroller.text.trim());
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


  http.Response? apiData;

  getPostalData({required String pincode}) async {
    print("object");
    apiData = await http.get(Uri.tryParse(
        "https://api.postalpincode.in/pincode/${pincode}")!);
    print(apiData!.statusCode);

    api = json.decode(apiData!.body);
    if (apiData != null) {
      postOffice = api[0]['PostOffice'];

      if (postOffice.isNotEmpty) {
        pincodepostalcontroller.text=postOffice[0]["District"];
        setState(() {});
      }
    }

    setState(() {});
  }

  List api = [];
  List postOffice = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                              color:Colors.black54,
                              fontSize: width*0.035
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
                         width: width*0.95,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(width*0.03),
                           border: Border.all(color: Pallette.primaryColor)
                         ),
                         child:  Padding(
                           padding: EdgeInsets.all(width * 0.04),
                           child: DropdownButton(
                             hint: Text(
                               "State",
                               style: TextStyle(
                                 color: Colors.black54,
                                   fontSize: width*0.035
                               ),
                             ),
                             dropdownColor: Pallette.white,
                             icon: Icon(Icons.arrow_drop_down),
                             isExpanded: true,
                             underline: gap,
                             style: TextStyle(
                               color: Colors.black,
                               fontSize: width*0.035,
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
                       // Container(
                       //   height: height*0.07,
                       //   width: width*0.4,
                       //   child: TextFormField(
                       //     textInputAction: TextInputAction.next,
                       //     autovalidateMode: AutovalidateMode.onUserInteraction,
                       //     keyboardType: TextInputType.text,
                       //     controller: districtcontroller,
                       //     cursorColor: Pallette.primaryColor,
                       //     maxLength: 30,
                       //     style: TextStyle(
                       //         color: CupertinoColors.black
                       //     ),
                       //     decoration: InputDecoration(
                       //         counterText: "",
                       //         labelText: "District",
                       //         labelStyle: TextStyle(
                       //             fontSize: width*0.035,
                       //           color: Colors.black54
                       //         ),
                       //         focusedBorder:OutlineInputBorder(
                       //             borderRadius: BorderRadius.circular(width*0.03),
                       //             borderSide:BorderSide(color: Pallette.primaryColor)
                       //         ),
                       //         enabledBorder: OutlineInputBorder(
                       //             borderRadius: BorderRadius.circular(width*0.03),
                       //             borderSide: BorderSide(color: Pallette.primaryColor)
                       //         )
                       //     ),
                       //   ),
                       // ),
                     ],
                   ),
                    gap,
                    TextFormField(
                      textInputAction: TextInputAction.newline,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.multiline,
                      controller: housecontroller,
                      cursorColor: Pallette.primaryColor,
                      maxLength: 50,
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                          counterText: "",
                          labelText: "Flat,House no,Building,Company,Apartment",
                          labelStyle: TextStyle(
                              fontSize: width*0.035,
                            color: Colors.black54
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
                      controller: areacontroller,
                      cursorColor: Pallette.primaryColor,
                      maxLength: 50,
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                          counterText: "",
                          labelText: "Area,Street,Sector,Village",
                          labelStyle: TextStyle(
                              fontSize: width*0.035,
                            color: Colors.black54
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
                      controller: landmarkcontroller,
                      cursorColor: Pallette.primaryColor,
                      maxLength: 60,
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                          counterText: "",
                          labelText: "Landmark",
                          labelStyle: TextStyle(
                              fontSize: width*0.035,
                            color: Colors.black54
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
                      controller: pincodecontroller,
                      cursorColor: Pallette.primaryColor,
                      onEditingComplete: () {
                        getPostalData(pincode: pincodecontroller.text);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 6,
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                          labelText: "Pincode",
                          labelStyle: TextStyle(
                              fontSize: width*0.035,
                            color: Colors.black54
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
                      controller: pincodepostalcontroller,
                      cursorColor: Pallette.primaryColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                          color: CupertinoColors.black
                      ),
                      decoration: InputDecoration(
                          labelText: "Town/City",
                          labelStyle: TextStyle(
                              fontSize: width*0.035,
                            color: Colors.black54
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
                        labelStyle: TextStyle(color: Colors.black54,
                        fontSize: width*0.035
                        ),
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
                  if(state==null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Your State")));
                    return;
                  }
                  if(housecontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your House no/flat")));
                    return;
                  }
                  if(areacontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Street/village")));
                    return;
                  }
                  if(landmarkcontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Landmark")));
                    return;
                  }
                  if(pincodecontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Pincode")));
                    return;
                  }
                  if(pincodepostalcontroller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Town/City")));
                    return;
                  }
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


