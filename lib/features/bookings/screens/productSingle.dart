import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/model/booking_model.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../main.dart';

import '../controller/booking_controller.dart';
import 'deliveryAddress.dart';

class ProducctSingleScreen extends ConsumerStatefulWidget {
  // final String image;
  final String tag;
  final String id;
  final bool like;
  final bool category;
  final StateProvider<bool> fav;
  const ProducctSingleScreen(
      {super.key, required this.tag,required this.id, required this.fav, required this.like, required this.category });

  @override
  ConsumerState<ProducctSingleScreen> createState() => _ProducctSingleScreenState();
}

class _ProducctSingleScreenState extends ConsumerState<ProducctSingleScreen> {
  double value = 3.5;
  int currentIndex = 0;
  bool fav = false;
  int count = 0;
  List images = [
    imageConstants.rabbit,
    imageConstants.cat,
    imageConstants.bird,
  ];
  // final favour=StateProvider<bool>((ref) =>false );
  favFunc() async {
    var data2=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);
    List fav=currentUserModel!.favourites;
    List favUser=productModel.favUser;
    print(fav);
    if(fav.contains(widget.id)){
      fav.remove(widget.id);
    }else{
      fav.add(widget.id);
    }if(favUser.contains(currentUserEmail)){
      favUser.remove(currentUserEmail);
    }else{
      favUser.add(currentUserEmail);
    }

    FirebaseFirestore.instance.collection("product").doc(widget.id).update({
      "favUser":favUser
    });
    FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
      "favourites": fav
    });
    var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
    currentUserModel = UserModel.fromMap(data1.data()!);
    var data3=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    productModel=ProductModel.fromMap(data3.data()!);

  }
  @override
  @override
  Widget build(BuildContext context) {
    // final favoriteState = ref.watch(favoriteStateProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              color: Colors.black,
            )),
        actions: [
          widget.category==true?SizedBox():
          IconButton(onPressed: (){

            ref.read(widget.fav.notifier).update((state) => !state);
            favFunc();
          }
            , icon: Icon(
              ref.watch(widget.fav) ? Icons.favorite : Icons.favorite,
              color: widget.like==true?Colors.red:ref.watch(widget.fav)?Colors.red:Colors.grey,
            ),
          ),

          SizedBox(
            width: width * 0.03,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Column(
          children: [
              // stream: FirebaseFirestore.instance.collection("product").doc(widget.id).snapshots().map((snapshot) {
              //   return ProductModel.fromMap(snapshot.data()!);
              // } ),
              // builder: (context, snapshot) {
              //   if(!snapshot.hasData){
              //     return Center(child: CircularProgressIndicator(
              //
              //     ),);
              //
              //   }
              //   ProductModel data=snapshot.data!;
              //   List image=data.image;
        ref.watch(SingleProductStreamProvider(widget.id)).when(
          data: (data) {
            List review = data!.review;
            return Container(
              height: height*0.84,
              // color: Colors.red,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          CarouselSlider.builder(
                            itemCount: data.image.length,
                            options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                autoPlayAnimationDuration: Duration(seconds: 2)),
                            itemBuilder: (context, index, realIndex) {
                              return Hero(
                                tag: widget.tag,
                                child: Container(
                                  height: height * 0.25,
                                  width: width * 1,
                                  margin: EdgeInsets.only(left: width * 0.03),
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(width * 0.03),
                                      image: DecorationImage(
                                          image: NetworkImage(data.image[index]),
                                          fit: BoxFit.cover)),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: height * 0.24,
                            left: width * 0.37,
                            child: AnimatedSmoothIndicator(
                              activeIndex: currentIndex,
                              count: data.image.length,
                              effect: ExpandingDotsEffect(
                                  dotHeight: height * 0.006,
                                  activeDotColor: Pallette.primaryColor,
                                  dotColor: Colors.grey.shade300),
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:width*0.5,
                                child: Text(
                                  "${data.productname} ",
                                  overflow: TextOverflow.values[0],
                                  style: TextStyle(
                                      color: Pallette.primaryColor,
                                      fontSize: width * 0.045,
                                      fontWeight: FontWeight.w800
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "\₹ ${data.price}",
                                  style: TextStyle(
                                      fontSize: width * 0.05,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        RatingStars(
                          value: value,
                          onValueChanged: (v) {
                            //
                            setState(() {
                              value = v;
                            });
                          },
                          starBuilder: (index, color) => Icon(
                            Icons.ac_unit_outlined,
                            color: color,
                          ),
                          starCount: 5,
                          starSize: 20,
                          valueLabelColor: const Color(0xff9b9b9b),
                          valueLabelTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 12.0),
                          valueLabelRadius: 10,
                          maxValue: 5,
                          starSpacing: 2,
                          maxValueVisibility: true,
                          valueLabelVisibility: true,
                          animationDuration: Duration(milliseconds: 1000),
                          valueLabelPadding:
                          const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                          valueLabelMargin: const EdgeInsets.only(right: 8),
                          starOffColor: const Color(0xffe7e8ea),
                          starColor: Pallette.primaryColor,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        data.category=="Product"? Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  count <= 0 ? 0 : count--;
                                  setState(() {});
                                },
                                child: Icon(CupertinoIcons.minus)),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Container(
                              height: height * 0.05,
                              width: width * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width * 0.03),
                                  border: Border.all(color: Colors.grey.shade300)),
                              child: Center(child: Text(count.toString())),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            InkWell(
                                onTap: () {
                                  count++;
                                  setState(() {});
                                },
                                child: Icon(CupertinoIcons.add)),
                          ],
                        ):SizedBox(),
                        // gap,
                        Text("Product Details",style: TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w600),),
                        SizedBox(height: height*0.015,),
                        Text(data.description,
                          style: TextStyle(fontSize: width * 0.04),),
                        gap,
                        Text("Customer Reviews",style: TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w600),),
                        SizedBox(height: height*0.015,),

                        Container(
                          height:height*0.16,
                          child:review.isNotEmpty?ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height:height*0.16 ,
                                width: width*1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(width*0.03),
                                    border: Border.all(color: Pallette.primaryColor)
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ListTile(
                                        leading:CircleAvatar(
                                          backgroundImage: NetworkImage("https://happytravel.viajes/wp-content/uploads/2020/04/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
                                          radius: width*0.06,
                                        ),
                                        title: Text("${review[index]['userid']}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.04),)

                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(width*0.03),
                                      child: SizedBox(
                                          height: height*0.06,
                                          width: width*1,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              "${review[index]["review"]}")),
                                    )
                                  ],
                                ),
                              );
                            },
                          ):SizedBox(),
                        )
                      ],
                    ),
                gap,
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          BookingModel bookingModelData=BookingModel(
                              bookingId:"",
                              paymentMethod: "",
                              price:data.price.toString(),
                              qty:count.toString() ,
                              productName: data.productname,
                              buyerPhoneNumer: "",
                              buyerAddress: "",
                              buyerName:"",
                              userId: currentUserModel!.id,
                              productImage: data.image[0].toString(),
                              selectindex: -1

                          );
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => deliveryAddress(bookingdata: bookingModelData),));
                        },
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              color: Pallette.primaryColor),
                          child: Center(
                            child: Text(
                              "BUY NOW",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.04,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) {
            return Text(error.toString());
          },
          loading: () {
            return SingleChildScrollView();
          },)



          ],
        ),
      ),
    );
  }
}
