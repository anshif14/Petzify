import 'dart:convert';


import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';

import 'package:luna_demo/model/booking_model.dart';

import '../../../commons/image Constants.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';
import 'package:http/http.dart' as http;

import 'conformation.dart';


class deliveryAddress extends ConsumerStatefulWidget {
  deliveryAddress({super.key,required this.bookingdata,required this.dcharge,required this.price});
  final double dcharge;
  final double price;
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
  TextEditingController towncitycontroller=TextEditingController();

  add(){
    //  =BookingModel(productName:"", price: "", qty: "", buyerName: namecontroller.text, buyerAddress: addresscontroller.text, buyerPhoneNumer: numbercontroller.text, buyerId: "", paymentMethod: "");
    BookingModel bookingModel =widget.bookingdata.copyWith(buyerName: namecontroller.text.trim(),
      state: state,buyerhouseno:housecontroller.text.trim(),buyerarea:areacontroller.text.trim(),
        buyerlandmark:landmarkcontroller.text.trim(),pincode:pincodecontroller.text.trim(),
        buyercity:towncitycontroller.text.trim(),buyerPhoneNumer: numbercontroller.text.trim());

    Navigator.push(context, CupertinoPageRoute(builder: (context) =>Confirm_page(bookingModel1: bookingModel,
      dcharge: widget.dcharge, price: widget.price,) ,));

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

    apiData = await http.get(Uri.tryParse(
        "https://api.postalpincode.in/pincode/${pincode}")!);


    api = json.decode(apiData!.body);
    if (apiData != null) {
      postOffice = api[0]['PostOffice'];

      if (postOffice.isNotEmpty) {
        towncitycontroller.text=postOffice[0]["District"];
        setState(() {});
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid ZIP or postal code")));

      }
    }

  }

  List api = [];
  List postOffice = [];

  Position ?_currentLocation;
  late bool servicePermission=false;
  late  LocationPermission permission;
  String _currentAdress ="";
  String _areastreet ="";
  Future<Position> _getCurrentLocation() async {
    servicePermission =await Geolocator.isLocationServiceEnabled();
    if(!servicePermission){

    }
    permission=await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
  _getAddressFromCoordinates() async{
    try{
      List<Placemark> placemark =await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAdress ="${place.locality},${place.country}";
        _areastreet ="${place.thoroughfare}";

      });
    }catch (e){

    }
  }

  fetch()async{
    _currentLocation =await _getCurrentLocation();
    await _getAddressFromCoordinates();
    areacontroller.text=_areastreet;

    setState(() {

    });
  }
  @override
  void initState() {
    fetch();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                          height: height*0.3,
                          width: width*1,
                          child: Image.asset(ImageConstants.delivery,fit: BoxFit.cover,)),
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
                      Container(
                        height: height*0.07,
                        width: width*1,
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
                                  child: Text(valueItem,style: TextStyle(
                                    fontSize: width*0.04
                                  ),),
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
                     // Row(
                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     //   children: [
                     //
                     //     // Container(
                     //     //   height: height*0.07,
                     //     //   width: width*0.4,
                     //     //   child: TextFormField(
                     //     //     textInputAction: TextInputAction.next,
                     //     //     autovalidateMode: AutovalidateMode.onUserInteraction,
                     //     //     keyboardType: TextInputType.text,
                     //     //     controller: districtcontroller,
                     //     //     cursorColor: Pallette.primaryColor,
                     //     //     maxLength: 30,
                     //     //     style: TextStyle(
                     //     //         color: CupertinoColors.black
                     //     //     ),
                     //     //     decoration: InputDecoration(
                     //     //         counterText: "",
                     //     //         labelText: "District",
                     //     //         labelStyle: TextStyle(
                     //     //             fontSize: width*0.035,
                     //     //           color: Colors.black54
                     //     //         ),
                     //     //         focusedBorder:OutlineInputBorder(
                     //     //             borderRadius: BorderRadius.circular(width*0.03),
                     //     //             borderSide:BorderSide(color: Pallette.primaryColor)
                     //     //         ),
                     //     //         enabledBorder: OutlineInputBorder(
                     //     //             borderRadius: BorderRadius.circular(width*0.03),
                     //     //             borderSide: BorderSide(color: Pallette.primaryColor)
                     //     //         )
                     //     //     ),
                     //     //   ),
                     //     // ),
                     //   ],
                     // ),
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
                        onChanged: (value) {
                          if(value.length ==6){
                            getPostalData(pincode: value);

                          }

                // pincodecontroller.text!=6?getPostalData(pincode: value):
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter a valid ZIP or postal code")));
                        },
                        // onEditingComplete: () {
                        //   getPostalData(pincode: pincodecontroller.text);
                        // },
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
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        controller: towncitycontroller,
                        cursorColor: Pallette.primaryColor,
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
                    if(towncitycontroller.text.isEmpty){
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
      ),
    );
  }
}


