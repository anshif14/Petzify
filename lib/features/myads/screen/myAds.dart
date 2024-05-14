import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/myads/controller/ads_stream_controller.dart';
import 'package:luna_demo/features/myads/screen/adsView.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../explore/controller/explore_controller.dart';

class myAds extends ConsumerStatefulWidget {
  const myAds({super.key});

  @override
  ConsumerState<myAds> createState() => _myAdsState();
}

class _myAdsState extends ConsumerState<myAds> {
  TextEditingController searchController = TextEditingController();
  late ProductModel productData;
  String? selectedProduct;

  // remove(){
  //   ref.read(adstreamControllerProvider).updatedatasss("");
  // }

  deletFunc(data,index) async {

    var data1=await FirebaseFirestore.instance.collection("users").get();
    await FirebaseFirestore.instance.collection("product").doc(data[index].id).get().then((value){
      productData = ProductModel.fromMap(value.data()!);
      print(productData);
    });
    var product1=productData.favUser;
    if(product1.isNotEmpty){
      for(int i=0;i<=product1.length;i++){
        for(int j=0;j<=data1.docs.length;j++){
          if(product1[i]==data1.docs[j].id){
            var fav=data1.docs[j].id;
            var fav1=await FirebaseFirestore.instance.collection("users").doc(fav).get();
            UserModel userdata=UserModel.fromMap(fav1.data()!);
            var fav2=userdata.favourites;
            var fav3=fav2[index]["id"];
            if(fav3==data[index].id){
              print(fav2);
              fav2.removeWhere((element) {
                return element["id"]==fav3;
              });
            }
            print(fav2);
            FirebaseFirestore.instance.collection("users").doc(fav).update(
                {
                  "favourites":fav2
                });
            await FirebaseFirestore.instance.collection("users").doc(fav).get().then((value) {
              userdata=UserModel.fromMap(value.data()!);
              print(userdata);
            });
            FirebaseFirestore.instance.collection("product").doc(data[index].id).delete();


            FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
              // currentUserModel!.copyWith(booking: FieldValue.arrayRemove([widget.data.bookingId], bookingCount: newBooking?.length).toMap()
                {
                  "productadd":FieldValue.arrayRemove([data[index].id]),

                }).then((value) {
              List? newproduct = currentUserModel?.productadd;
              newproduct!.remove(data[index].id);
              FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
                  {
                    "productCount":newproduct.length,
                  });
            });
          }
        }
      }
    }else{
      FirebaseFirestore.instance.collection("product").doc(data[index].id).delete();
      FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
        // currentUserModel!.copyWith(booking: FieldValue.arrayRemove([widget.data.bookingId], bookingCount: newBooking?.length).toMap()
          {
            "productadd":FieldValue.arrayRemove([data[index].id]),

          }).then((value) {
        List? newproduct = currentUserModel?.productadd;
        newproduct!.remove(data[index].id);
        FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update(
            {
              "productCount":newproduct.length,
            });
      });
    }
    setState(() {

    });
  }

  // updatedata(){
  //   ref.read(exploreControllerProvider).updatedata("noOrder");
  // }





  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.netdog),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
          floatingActionButton: CircleAvatar(
            radius: width*0.08,backgroundColor:Pallette.primaryColor ,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,border: Border.all(width: width*0.008,color: Colors.white)
              ),
              child: CircleAvatar(
                radius: width*0.06,
                child: Icon(Icons.play_circle,size: width*0.08,),
                backgroundColor: Pallette.primaryColor,),
            ),
          ),
        appBar: AppBar(
          surfaceTintColor: Pallette.white,

          elevation: 0,
          title:Text("My Ads",style: TextStyle(
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
          SizedBox(height: height*0.015,),
          Expanded(
            child: AnimationLimiter(
              child: ref.watch(adsStreamProvider).when(
                  data: (data) {
                    return data.isNotEmpty?GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: width * 0.03,
                        childAspectRatio: 0.77,),
                      itemBuilder: (context, index) {
                        return  AnimationConfiguration.staggeredList(
                          position: index,
                          duration:  Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => adsView(
                                      id:data[index].id,
                                      // fun: deletFunc(data,index),
                                    ),));
                                  },
                                  child: Container(
                                    width: width*0.5,
                                    decoration: BoxDecoration(
                                      color: Pallette.white,
                                      borderRadius: BorderRadius.circular(width*0.02),
                                      border: Border.all(color: Pallette.primaryColor),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: height*0.15,
                                            width: width*0.5,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(width*0.01),
                                                child: CachedNetworkImage(imageUrl:data[index].image[0],fit: BoxFit.cover,)),
                                            // decoration: BoxDecoration(
                                            //     image: DecorationImage(image: NetworkImage(data[index].image[0]),fit: BoxFit.cover),
                                            //     borderRadius: BorderRadius.circular(width*0.01)
                                            // ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("₹ ${data[index].price}",style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: width*0.04
                                              ),),
                                              Container(
                                                height: height*0.028,
                                                width: width*0.5,
                                                child: Text(data[index].productname,style: TextStyle(
                                                    fontSize: width*0.04
                                                ),),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showCupertinoModalPopup(
                                                barrierColor: Colors.black.withOpacity(0.5),
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return CupertinoAlertDialog(
                                                    content: Text("Are you Sure\nYou Want to Remove !",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: width * 0.045)),
                                                    actions: [
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        isDestructiveAction: true,
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text("Cancel"),
                                                      ),
                                                      CupertinoDialogAction(
                                                        isDefaultAction: true,
                                                        onPressed: ()  async {
                                                          deletFunc(data,index);

                                                         // await remove();
                                                        // await  updatedata();
                                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              SizedBox(
                                                                width: width*0.05,
                                                              ),

                                                              Center(
                                                                child: Container(
                                                                    height: height*0.04,
                                                                    width: width*0.1,
                                                                    // color: Colors.red,
                                                                    child: Lottie.asset(ImageConstants.remove,fit: BoxFit.fitHeight)),
                                                              ),
                                                              SizedBox(
                                                                width: width*0.015,
                                                              ),

                                                              Text("Deleted Success",style: TextStyle(
                                                                  fontSize: width*0.04,
                                                                  color: Pallette.white
                                                              ),)
                                                            ],

                                                          ),backgroundColor: Colors.black.withOpacity(0.85),
                                                            behavior: SnackBarBehavior.floating,
                                                            showCloseIcon: true,
                                                            duration: Duration(seconds: 1),
                                                            padding:  EdgeInsets.only(bottom: width*0.012,top: width*0.001),
                                                            // duration: Duration(seconds: 2),
                                                          ));

                                                          Navigator.pop(context);

                                                        },
                                                        child: Text("Confirm",
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            )),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: height*0.035,
                                              width: width*0.22,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(width*0.05)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(CupertinoIcons.delete,color: Pallette.white,
                                                      size: width*0.045),
                                                  SizedBox(width: width*0.01,),
                                                  Center(
                                                    child: Text("Remove",style: TextStyle(
                                                        color: Pallette.white,
                                                        fontSize: width*0.03
                                                    ),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),

                                  ),
                                )
                            ),
                          ),
                        );

                      },):Center(child:Lottie.asset(ImageConstants.noadslottie));
                  },
                  error: (error, stackTrace) {
                    return Text(
                      error.toString()
                    );
                  },
                  loading: () {
                    return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));

                  },)


            ),
          )
        ],
      )
        )
      ),
    );
  }
}
