import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/favourite/controller/favourite_controller.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/widgets.dart';

import '../../../main.dart';
import '../../bookings/screens/productSingle.dart';
import '../../home/screen/home.dart';

class favouritePage extends ConsumerStatefulWidget {
  const favouritePage({super.key});

  @override
  ConsumerState<favouritePage> createState() => _favouriteState();
}

class _favouriteState extends ConsumerState<favouritePage> {
  bool loading = false;
  TextEditingController searchController = TextEditingController();

  // getFav() async {
  //   DocumentSnapshot<Map<String, dynamic>> data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
  //   Map<String,dynamic> favFB=data.data()!;
  //   favourite=favFB["favourites"];
  //   for(int i =0;i<favourite.length;i++){
  //     fav.add(favourite[i]["id"]);
  //   }
  // }

  favFunc(name,id,price,category,image) async {
    loading = true;
    setState(() {

    });

    var data2=await FirebaseFirestore.instance.collection("product").doc(id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);

    favUser=productModel.favUser;
    if(fav.contains(id)){

      fav.removeWhere((element) => element==id,);;


      favourite.removeWhere((element) {

        return element["id"]==id;
      });


      favUser.removeWhere((element) => element==currentUserEmail);
      FirebaseFirestore.instance.collection("product").doc(id).update({
        "favUser":favUser
      });
      FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
        "favourites": favourite
      });
    }else{

      fav.add(id);

      Map<String,dynamic> data = {
        "name":name,
        "price":price,
        "category":category,
        "image":image,
        "id":id,
      };
      favourite.add(data);
      favUser.add(currentUserEmail);
      FirebaseFirestore.instance.collection("product").doc(id).update({
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
    var data3=await FirebaseFirestore.instance.collection("product").doc(id).get();
    productModel=ProductModel.fromMap(data3.data()!);
    loading = false;
    setState(() {

    });
  }

  @override
  void initState() {
    // getFav();
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
            elevation: 0,
            toolbarHeight: height*0.01,
          ),
          body: Padding(
            padding:  EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                  gap,
                  ref.watch(datafavstreamProvider(currentUserModel!.id)).when(
                    data: (data) {
                      return data.favourites.isEmpty ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(ImageConstants.nofavourite,height: height*0.3),
                          gap,
                          Text("No Favourites Found",style: TextStyle(
                            fontSize: width*0.05,
                            fontWeight: FontWeight.w700,
                          ),
                          )
                        ],
                      ) :

                      AnimationLimiter(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          childAspectRatio: 0.8,
                          crossAxisCount: 2,
                          children: List.generate(
                            data.favourites.length,
                                (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration:  Duration(seconds: 1),
                                columnCount: data.favourites.length,
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    curve:Curves.fastLinearToSlowEaseIn,
                                    child: ref.watch(productfavstreamProvider(data.favourites[index]["id"])).when(
                                      data: (data) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => ProducctSingleScreen(
                                                      fav: data!.favUser.contains(currentUserEmail) ? true : false,
                                                      like:true,
                                                      id: data!.id,
                                                      tag: data.productname,
                                                      Petcategory: false,
                                                      name:data.productname,
                                                      price:data.price,
                                                      category:data.category,
                                                      image:data.image
                                                  ),
                                                ));
                                          },
                                          child:Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Hero(
                                                      tag: data!.productname,
                                                      child: Container(
                                                        height: width * 0.4,
                                                        width: width * 0.4,
                                                        child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(15),
                                                            child: CachedNetworkImage(imageUrl:data.image[0],fit: BoxFit.cover,)),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      child: Container(
                                                        margin: EdgeInsets.all(5.0),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          // color: Colors.white.withOpacity(0.1)
                                                        ),
                                                        child:
                                                        IconButton(onPressed: (){
                                                          // ref.read(favour.notifier).update((state) => !state);
                                                          favFunc(data.productname,data.id, data.price, data.category,data.image);
                                                        }
                                                          , icon: Icon(
                                                            fav.contains(data.id) ? Icons.favorite : Icons.favorite,
                                                            color: fav.contains(data.id) ?Colors.red:Colors.grey,
                                                          ),
                                                        ),

                                                        // Padding(
                                                        //   padding: const EdgeInsets.all(5.0),
                                                        //   child: FavoriteButton(
                                                        //     isFavorite: true,
                                                        //     iconSize: 25,
                                                        //     valueChanged: (_isFavorite) async {
                                                        //       favFunc(data);
                                                        //     },
                                                        //   ),
                                                        // ),



                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          data.productname,overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(fontWeight: FontWeight.w800),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text('₹ ' + data.price.toString(),overflow: TextOverflow.ellipsis,),
                                                    ],
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
                                        return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));
                                      },),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );



                      // GridView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: data.favourites.length,
                      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //       childAspectRatio: 0.8, crossAxisCount: 2
                      // ),
                      //   itemBuilder: (context, index) {
                      //     return ref.watch(productfavstreamProvider(data.favourites[index]["id"])).when(
                      //       data: (data) {
                      //         return InkWell(
                      //           onTap: () {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                   builder: (context) => ProducctSingleScreen(
                      //                     fav: data!.favUser.contains(currentUserEmail) ? true : false,
                      //                     like:true,
                      //                     id: data!.id,
                      //                     tag: data.productname,
                      //                     Petcategory: false,
                      //                       name:data.productname,
                      //                       price:data.price,
                      //                       category:data.category,
                      //                     image:data.image
                      //                   ),
                      //                 ));
                      //           },
                      //           child:Padding(
                      //             padding: const EdgeInsets.all(4.0),
                      //             child: Column(
                      //               children: [
                      //                 Stack(
                      //                   children: [
                      //                     Hero(
                      //                       tag: data!.productname,
                      //                       child: Container(
                      //                         height: width * 0.4,
                      //                         width: width * 0.4,
                      //                         child: ClipRRect(
                      //                             borderRadius: BorderRadius.circular(15),
                      //                             child: CachedNetworkImage(imageUrl:data.image[0],fit: BoxFit.cover,)),
                      //                       ),
                      //                     ),
                      //                     Positioned(
                      //                       right: 0,
                      //                       child: Container(
                      //                         margin: EdgeInsets.all(5.0),
                      //                         decoration: BoxDecoration(
                      //                           shape: BoxShape.circle,
                      //                           // color: Colors.white.withOpacity(0.1)
                      //                         ),
                      //                         child:
                      //                         IconButton(onPressed: (){
                      //                           // ref.read(favour.notifier).update((state) => !state);
                      //                           favFunc(data.productname,data.id, data.price, data.category,data.image);
                      //                         }
                      //                           , icon: Icon(
                      //                             fav.contains(data.id) ? Icons.favorite : Icons.favorite,
                      //                             color: fav.contains(data.id) ?Colors.red:Colors.grey,
                      //                           ),
                      //                         ),
                      //
                      //                         // Padding(
                      //                         //   padding: const EdgeInsets.all(5.0),
                      //                         //   child: FavoriteButton(
                      //                         //     isFavorite: true,
                      //                         //     iconSize: 25,
                      //                         //     valueChanged: (_isFavorite) async {
                      //                         //       favFunc(data);
                      //                         //     },
                      //                         //   ),
                      //                         // ),
                      //
                      //
                      //
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Row(
                      //                     children: [
                      //                       Expanded(
                      //                         child: Text(
                      //                           data.productname,overflow: TextOverflow.ellipsis,
                      //                           textAlign: TextAlign.start,
                      //                           style: TextStyle(fontWeight: FontWeight.w800),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //                 Padding(
                      //                   padding: const EdgeInsets.all(2.0),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.end,
                      //                     children: [
                      //                       Text('₹ ' + data.price.toString(),overflow: TextOverflow.ellipsis,),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //       error: (error, stackTrace) {
                      //         return Text(error.toString());
                      //       },
                      //       loading: () {
                      //         return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));
                      //       },);
                      //   },
                      // );
                    },
                    error: (error, stackTrace) {
                      return Text(error.toString());
                    },
                    loading: () {
                      return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

// class petTile extends ConsumerStatefulWidget {
//   final String data;
//   final int index;
//   const petTile({super.key, required this.data, required this.index});
//
//   @override
//   ConsumerState<petTile> createState() => _petTileState();
// }

// class _petTileState extends ConsumerState<petTile> {
//   final favour=StateProvider<bool>((ref) =>true );
//   List fav=[];
//   List favourite=[];
//   List favUser=[];
//   bool loading = false;
//   // favFunc(data) async {
//   //   loading = true;
//   //   setState(() {
//   //
//   //   });
//   //
//   //   var data2=await FirebaseFirestore.instance.collection("product").doc(widget.data).get();
//   //   ProductModel productModel = ProductModel.fromMap(data2.data()!);
//   //
//   //   favUser=productModel.favUser;
//   //   print(fav);
//   //   if(fav.contains(widget.data)){
//   //     fav.remove(widget.data);
//   //     favourite.removeWhere((element) => element["id"]==widget.data);
//   //     favUser.removeWhere((element) => element==currentUserEmail);
//   //     FirebaseFirestore.instance.collection("product").doc(widget.data).update({
//   //       "favUser":favUser
//   //     });
//   //     FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
//   //       "favourites": favourite
//   //     });
//   //   }else{
//   //     fav.add(widget.data);
//   //     Map<String,dynamic> Productdata = {
//   //       "name":data.productname,
//   //       "price":data.price,
//   //       "category":data.category,
//   //       "image":data.image,
//   //       "id":data.id,
//   //     };
//   //     favourite.add(Productdata);
//   //     favUser.add(currentUserEmail);
//   //     FirebaseFirestore.instance.collection("product").doc(widget.data).update({
//   //       "favUser":favUser
//   //     });
//   //     FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
//   //       "favourites": favourite
//   //     });
//   //   }
//   //   // if(favUser.contains(currentUserEmail)){
//   //   // }else{
//   //   //
//   //   // }
//   //
//   //   var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
//   //   currentUserModel = UserModel.fromMap(data1.data()!);
//   //   var data3=await FirebaseFirestore.instance.collection("product").doc(widget.data).get();
//   //   productModel=ProductModel.fromMap(data3.data()!);
//   //   loading = false;
//   //   setState(() {
//   //
//   //   });
//   // }
//   @override
//   void initState() {
//     int index=widget.index;
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     // final favoriteState = ref.watch(favoriteStateProvider);
//
//     return
//
//   }
// }
