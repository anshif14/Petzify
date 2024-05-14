
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:luna_demo/commons/color%20constansts.dart';

import '../../../main.dart';
import '../../../model/booking_model.dart';


class orderDetails extends StatefulWidget {
  final BookingModel bookingModel1;

  const orderDetails({super.key,
    required this.bookingModel1
  });

  @override
  State<orderDetails> createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Order details",
            style: TextStyle(
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: width * 0.52,
                width: width * 1,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(width*0.02),
                    child: CachedNetworkImage(imageUrl: widget.bookingModel1.productImage,fit: BoxFit.cover,)),
                // decoration: BoxDecoration(
                //     color: Pallette.primaryColor,
                //     image: DecorationImage(image: NetworkImage(""),fit: BoxFit.cover),
                //     borderRadius: BorderRadius.circular(width*0.02)
                // ),

              ),
                      ListTile(
          leading:Text("ProductName",
            style: TextStyle(
              fontSize: width*0.045,
              color: Colors.black,
            ),),
                        title: Text(":"),
                        trailing: Text(widget.bookingModel1.productName,style: TextStyle(
            fontSize: width*0.045,
            color: Colors.black,
          ),),
                      ),
              ListTile(
                leading:Text("price",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),

                trailing: Text(widget.bookingModel1.price,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Name",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),

                trailing: Text(widget.bookingModel1.buyerName,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("State",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),

                trailing: Text(widget.bookingModel1.state,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Flat,House no",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),

                trailing: Text(widget.bookingModel1.buyerhouseno,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Area,Street",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),

                trailing: Text(widget.bookingModel1.buyerarea,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Landmark",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),
                trailing: Text(widget.bookingModel1.buyerlandmark,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Pincode",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),
                trailing: Text(widget.bookingModel1.pincode,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Town/City",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),
                trailing: Text(widget.bookingModel1.buyercity,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Phone Number",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),
                trailing: Text(widget.bookingModel1.buyerPhoneNumer,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),
              ListTile(
                leading:Text("Payment method",
                  style: TextStyle(
                    fontSize: width*0.045,
                    color: Colors.black,
                  ),),
                title: Text(":"),
                trailing: Text(widget.bookingModel1.paymentMethod,style: TextStyle(
                  fontSize: width*0.045,
                  color: Colors.black,
                ),),
              ),


            ],
          ),
        ));
  }
}
