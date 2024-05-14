import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/bookings/screens/view_review.dart';
import 'package:luna_demo/model/booking_model.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../main.dart';

import '../../home/screen/home.dart';
import '../controller/booking_controller.dart';
import 'deliveryAddress.dart';

class ProducctSingleScreen extends ConsumerStatefulWidget {
  // final String image;
  final String tag;
  final String id;
  final String name;
  final double price;
  final String category;
  final List image;
  final bool like;
  final bool Petcategory;
  final bool fav;

  const ProducctSingleScreen(
      {super.key,
        required this.tag,
        required this.id,
        required this.fav,
        required this.like,
        required this.Petcategory,
        required this.name,
        required this.price,
        required this.category,
        required this.image
      });

  @override
  ConsumerState<ProducctSingleScreen> createState() => _ProducctSingleScreenState();
}

class _ProducctSingleScreenState extends ConsumerState<ProducctSingleScreen> {
  double value = 3.5;
  int currentIndex = 0;
  // bool fav = false;
  int count = 1;
  List images = [
    ImageConstants.rabbit,
    ImageConstants.cat,
    ImageConstants.bird,
  ];
  // final favour=StateProvider<bool>((ref) =>false );
  favFunc() async {


    var data2=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);

    favUser=productModel.favUser;
    if(fav.contains(widget.id)){
      print(fav);
      fav.removeWhere((element) => element==widget.id,);;
      print(fav);
      print(favourite);
      favourite.removeWhere((element) {
        print(element["id"]);
        return element["id"]==widget.id;
      });
      print(widget.id);
      print(favourite);
      favUser.removeWhere((element) => element==currentUserEmail);
      FirebaseFirestore.instance.collection("product").doc(widget.id).update({
        "favUser":favUser
      });
      FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
        "favourites": favourite
      });
    }else{
      print("starytttttttttttttttttttttttttttt");
      fav.add(widget.id);
      print(fav);
      Map<String,dynamic> data = {
        "name":widget.name,
        "price":widget.price,
        "category":widget.category,
        "image":widget.image,
        "id":widget.id,
      };
      favourite.add(data);
      favUser.add(currentUserEmail);
      FirebaseFirestore.instance.collection("product").doc(widget.id).update({
        "favUser":favUser
      });
      FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
        "favourites": FieldValue.arrayUnion(favourite)
      });
    }
    // if(favUser.contains(currentUserEmail)){
    // }else{
    //
    // }

    var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
    currentUserModel = UserModel.fromMap(data1.data()!);
    var data3=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    productModel=ProductModel.fromMap(data3.data()!);
    setState(() {

    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    // final favoriteState = ref.watch(favoriteStateProvider);
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.doglottie),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Pallette.white,
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
            IconButton(onPressed: (){
              // ref.read(widget.fav.notifier).update((state) => !state);
              favFunc();
            }
              , icon: Icon(
                fav.contains(widget.id) ? Icons.favorite : Icons.favorite,
                color: fav.contains(widget.id) ?Colors.red:Colors.grey,
              ),
            ),
            SizedBox(
              width: width * 0.03,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: SingleChildScrollView(
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
                return Column(
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
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(width * 0.03),
                                    child: CachedNetworkImage(imageUrl: data.image[index],fit: BoxFit.cover,),
                                    // decoration: BoxDecoration(
                                    //     color: Colors.yellow,
                                    //     borderRadius: BorderRadius.circular(width * 0.03),
                                    //     image: DecorationImage(
                                    //         image: CachedNetworkImage(imageUrl: data.image[index],),
                                    //         fit: BoxFit.cover)),
                                                                    ),
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
                            // Icons.star,
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
                        review.isNotEmpty?Text("Customer Reviews",style: TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w600),):SizedBox(),
                        SizedBox(height: height*0.015,),

                        review.isNotEmpty? Container(
                          height:height*0.25,
                         

                          child:ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // height:height*0.21 ,
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
                                              backgroundColor: Pallette.primaryColor,
                                              backgroundImage: review[index]["image"]==""?NetworkImage("https://happytravel.viajes/wp-content/uploads/2020/04/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"):
                                              NetworkImage(review[index]['image'].toString()),
                                              radius: width*0.055,
                                            ),
                                            title: Container(
                                                height: height*0.05,
                                                child: Center(child: Text("${review[index]['userid']}",style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,fontSize: width*0.04),)))

                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(width*0.03),
                                          child: Container(
                                            height: height*0.085,
                                                  width: width*0.85,
                                            child: SingleChildScrollView(
                                              child: ReadMoreText(
                                         "${review[index]['review']}",
                                              trimMode: TrimMode.Line,
                                              trimLines: 2,
                                              // colorClickableText: Colors.pink,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                              lessStyle:TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold) ,
                                              moreStyle: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height*0.015),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, CupertinoPageRoute(builder: (context) => View_review(
                                          review: review
                                        // name: review[index]['userid'],
                                        // image: review[index]['image'],
                                        // review: review[index]['review'],
                                        // productImage: review[index]['productImage'],
                                          ),));
                                    },
                                    child: Center(child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,

                                      children: [
                                        Text("View Reviews",style:
                                        TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.032),),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )),
                                  )
                                ],
                              );
                            },
                          ),
                        ):SizedBox(height: height*0.15,)
                      ],
                    ),
                    SizedBox(height: height*0.001,),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          BookingModel bookingModelData=BookingModel(
                              bookingId:"",
                              paymentMethod: "",
                              price:"",
                              qty:count.toString() ,
                              productName: data.productname,
                              buyerPhoneNumer: "",
                              buyerName:"",
                              state: "",
                              buyerhouseno: '',
                              buyerarea: '',
                              buyerlandmark: '',
                              pincode: '',
                              buyercity: '',
                              userId: currentUserModel!.id,
                              productId: data.id,
                              productImage: data.image[0].toString(),
                              selectindex: 0,
                              search: []

                          );
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => deliveryAddress(bookingdata: bookingModelData,
                            dcharge: data.deliverycharge, price: data.price,),));
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
        ),
      ),
    );
  }
}
