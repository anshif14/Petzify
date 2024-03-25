import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/features/favourite/controller/favourite_controller.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/widgets.dart';
import '../../../main.dart';
import '../../product/screens/productSingle.dart';

class favourite extends ConsumerStatefulWidget {
  const favourite({super.key});

  @override
  ConsumerState<favourite> createState() => _favouriteState();
}

class _favouriteState extends ConsumerState<favourite> {
  List pets = [
    {'name': 'pet', "image": imageConstants.pet1, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet2, "price": 1250},
    {'name': 'pet', "image": imageConstants.pet3, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet4, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet5, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet6, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet7, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet8, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet9, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet10, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet11, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet12, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet13, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet14, "price": 1000},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: height * 0.08,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      Text(
                        "Search",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                  height: height * 0.06,
                  decoration: BoxDecoration(
                      color: Pallette.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            gap,


            ref.watch(datafavstreamProvider).when(
                data: (data) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.favourites.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.8, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return petTile(index: index,data: data.favourites[index],);

                      // return StreamBuilder<DocumentSnapshot>(
                      //     stream: FirebaseFirestore.instance.collection('product').doc(data.favourites[index]).snapshots(),
                      //     builder: (context, snapshot1) {
                      //       if(!snapshot1.hasData){
                      //         return Center(child: CircularProgressIndicator(color: Pallette.primaryColor),);
                      //       }
                      //       ProductModel? product;
                      //       if(snapshot1.data?.data() != null){
                      //         print("---------------------------************************---------------------");
                      //         print(data.favourites.length);
                      //         product    = ProductModel.fromMap(snapshot1.data?.data()  as Map<String,dynamic>);
                      //
                      //       }
                      //       return  product==null?
                      //       Column(
                      //         children: [
                      //           Padding(
                      //             padding: const EdgeInsets.all(7.0),
                      //             child: Container(
                      //               height: width * 0.4,
                      //               width: width * 0.4,
                      //               decoration: BoxDecoration(
                      //                   color: Pallette.secondaryBrown,
                      //                   borderRadius: BorderRadius.circular(15)),
                      //               child: Center(
                      //                 child: CircularProgressIndicator(
                      //                   color: Pallette.primaryColor,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //
                      //           : InkWell(
                      //         onTap: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => ProducctSingleScreen(
                      //                   id: product!.id,
                      //                   tag: product.productname,
                      //                 ),
                      //               ));
                      //         },
                      //         child:Padding(
                      //           padding: const EdgeInsets.all(4.0),
                      //           child: Column(
                      //             children: [
                      //               Stack(
                      //                 children: [
                      //                   Hero(
                      //                     tag: product!.productname,
                      //                     child: Container(
                      //                       height: width * 0.4,
                      //                       width: width * 0.4,
                      //                       decoration: BoxDecoration(
                      //                           color: Pallette.secondaryBrown,
                      //                           image: DecorationImage(
                      //                               image: NetworkImage(product.image[0]),
                      //                               fit: BoxFit.cover),
                      //                           borderRadius: BorderRadius.circular(15)),
                      //                     ),
                      //                   ),
                      //                   Positioned(
                      //                     right: 0,
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(8.0),
                      //                       child: Container(
                      //                         decoration: BoxDecoration(
                      //                             shape: BoxShape.circle,
                      //                             color: Colors.white.withOpacity(0.5)),
                      //                         child: Padding(
                      //                           padding: const EdgeInsets.all(5.0),
                      //                           child: FavoriteButton(
                      //                             isFavorite: true,
                      //                             iconSize: 25,
                      //                             valueChanged: (_isFavorite) async {
                      //                               var data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                      //                               currentUserModel = userModel.fromMap(data.data()!);
                      //                               var data2=await FirebaseFirestore.instance.collection("product").doc(product!.id).get();
                      //                               ProductModel productModel = ProductModel.fromMap(data2.data()!);
                      //                               List fav=currentUserModel!.favourites;
                      //                               List favUser=productModel.favUser;
                      //                               print(fav);
                      //                               if(fav.contains(product!.id)){
                      //                                 fav.remove(product.id);
                      //                               }else{
                      //                                 fav.add(product.id);
                      //                               }if(favUser.contains(currentUserEmail)){
                      //                                 favUser.remove(currentUserEmail);
                      //                               }else{
                      //                                 favUser.add(currentUserEmail);
                      //                               }
                      //                               FirebaseFirestore.instance.collection("product").doc(product.id).update({
                      //                                 "favUser":favUser
                      //                               });
                      //                               FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
                      //                                 "favourites": fav
                      //                               });
                      //                               var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                      //                               currentUserModel = userModel.fromMap(data1.data()!);
                      //                               var data3=await FirebaseFirestore.instance.collection("product").doc(product.id).get();
                      //                               productModel=ProductModel.fromMap(data3.data()!);
                      //                               setState(() {
                      //
                      //                               });
                      //                               print('Is Favorite $_isFavorite)');
                      //                               print('Is Favorite $_isFavorite)');
                      //                             },
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   children: [
                      //                     Expanded(
                      //                       child: Text(
                      //                         product.productname,overflow: TextOverflow.ellipsis,
                      //                         textAlign: TextAlign.start,
                      //                         style: TextStyle(fontWeight: FontWeight.w800),
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               Padding(
                      //                 padding: const EdgeInsets.all(2.0),
                      //                 child: Row(
                      //                   mainAxisAlignment: MainAxisAlignment.end,
                      //                   children: [
                      //                     Text('₹ ' + product.price.toString(),overflow: TextOverflow.ellipsis,),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     }
                      // );




                    },
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return CircularProgressIndicator();
                },
            )



            // StreamBuilder<DocumentSnapshot>(
            //     stream: FirebaseFirestore.instance.collection('users').doc(currentUserModel!.id).snapshots(),
            //     builder: (context, snapshot) {
            //       if(!snapshot.hasData){
            //         return Center(child: CircularProgressIndicator(color: Pallette.primaryColor),);
            //       }
            //       currentUserModel = userModel.fromMap(snapshot.data!.data() as Map<String , dynamic>);
            //     return GridView.builder(
            //       physics: NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: currentUserModel!.favourites.length,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           childAspectRatio: 0.8, crossAxisCount: 2),
            //       itemBuilder: (context, index) {
            //             return StreamBuilder<DocumentSnapshot>(
            //               stream: FirebaseFirestore.instance.collection('product').doc(currentUserModel!.favourites[index]).snapshots(),
            //               builder: (context, snapshot1) {
            //                 if(!snapshot.hasData){
            //                   return Center(child: CircularProgressIndicator(color: Pallette.primaryColor),);
            //                 }
            //                 ProductModel? product;
            //                 if(snapshot1.data?.data() != null){
            //                product    = ProductModel.fromMap(snapshot1.data?.data()  as Map<String,dynamic>);
            //
            //                 }
            //
            //                 return  product==null?
            //
            //                 Column(
            //                   children: [
            //                     Padding(
            //                       padding: const EdgeInsets.all(7.0),
            //                       child: Container(
            //                         height: width * 0.4,
            //                         width: width * 0.4,
            //                         decoration: BoxDecoration(
            //                             color: Pallette.secondaryBrown,
            //                             borderRadius: BorderRadius.circular(15)),
            //                         child: Center(
            //                           child: CircularProgressIndicator(
            //                             color: Pallette.primaryColor,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ],
            //                 )
            //
            //                     : InkWell(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) => ProducctSingleScreen(
            //                             id: product!.id,
            //                             tag: product.productname,
            //                           ),
            //                         ));
            //                   },
            //                   child:Padding(
            //                     padding: const EdgeInsets.all(4.0),
            //                     child: Column(
            //                       children: [
            //                         Stack(
            //                           children: [
            //                             Hero(
            //                               tag: product!.productname,
            //                               child: Container(
            //                                 height: width * 0.4,
            //                                 width: width * 0.4,
            //                                 decoration: BoxDecoration(
            //                                     color: Pallette.secondaryBrown,
            //                                     image: DecorationImage(
            //                                         image: NetworkImage(product.image[0]),
            //                                         fit: BoxFit.cover),
            //                                     borderRadius: BorderRadius.circular(15)),
            //                               ),
            //                             ),
            //                             Positioned(
            //                               right: 0,
            //                               child: Padding(
            //                                 padding: const EdgeInsets.all(8.0),
            //                                 child: Container(
            //                                   decoration: BoxDecoration(
            //                                       shape: BoxShape.circle,
            //                                       color: Colors.white.withOpacity(0.5)),
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.all(5.0),
            //                                     child: FavoriteButton(
            //                                       isFavorite: true,
            //                                       iconSize: 25,
            //                                       valueChanged: (_isFavorite) async {
            //                                         var data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
            //                                         currentUserModel = userModel.fromMap(data.data()!);
            //                                         var data2=await FirebaseFirestore.instance.collection("product").doc(product!.id).get();
            //                                         ProductModel productModel = ProductModel.fromMap(data2.data()!);
            //                                         List fav=currentUserModel!.favourites;
            //                                         List favUser=productModel.favUser;
            //                                         print(fav);
            //                                         if(fav.contains(product!.id)){
            //                                           fav.remove(product.id);
            //                                         }else{
            //                                           fav.add(product.id);
            //                                         }if(favUser.contains(currentUserEmail)){
            //                                           favUser.remove(currentUserEmail);
            //                                         }else{
            //                                           favUser.add(currentUserEmail);
            //                                         }
            //                                         FirebaseFirestore.instance.collection("product").doc(product.id).update({
            //                                           "favUser":favUser
            //                                         });
            //                                         FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
            //                                           "favourites": fav
            //                                         });
            //                                         var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
            //                                         currentUserModel = userModel.fromMap(data1.data()!);
            //                                         var data3=await FirebaseFirestore.instance.collection("product").doc(product.id).get();
            //                                         productModel=ProductModel.fromMap(data3.data()!);
            //                                         setState(() {
            //
            //                                         });
            //                                         print('Is Favorite $_isFavorite)');
            //                                         print('Is Favorite $_isFavorite)');
            //                                       },
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                             )
            //                           ],
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(8.0),
            //                           child: Row(
            //                             children: [
            //                               Expanded(
            //                                 child: Text(
            //                                   product.productname,overflow: TextOverflow.ellipsis,
            //                                   textAlign: TextAlign.start,
            //                                   style: TextStyle(fontWeight: FontWeight.w800),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         Padding(
            //                           padding: const EdgeInsets.all(2.0),
            //                           child: Row(
            //                             mainAxisAlignment: MainAxisAlignment.end,
            //                             children: [
            //                               Text('₹ ' + product.price.toString(),overflow: TextOverflow.ellipsis,),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 );
            //               }
            //             );
            //
            //
            //       },
            //     );
            //   }
            // )
          ],
        ),
      ),
    ));
  }
}

class petTile extends ConsumerStatefulWidget {
  final int index;
  final dynamic data;
  const petTile({super.key, required this.index, required this.data});

  @override
  ConsumerState<petTile> createState() => _petTileState();
}

class _petTileState extends ConsumerState<petTile> {

  int index = 0;

  @override
  void initState() {
    index = widget.index;
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return
      ref.watch(productfavstreamProvider(widget.data)).when(
        data: (data) {
          return  data==null?
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Container(
                  height: width * 0.4,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                      color: Pallette.secondaryBrown,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Pallette.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          )

              : InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProducctSingleScreen(
                      id: data!.id,
                      tag: data.productname,
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
                          decoration: BoxDecoration(
                              color: Pallette.secondaryBrown,
                              image: DecorationImage(
                                  image: NetworkImage(data.image[0]),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FavoriteButton(
                                isFavorite: true,
                                iconSize: 25,
                                valueChanged: (_isFavorite) async {
                                  var data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                                  currentUserModel = userModel.fromMap(data.data()!);
                                  var data2=await FirebaseFirestore.instance.collection("product").doc(data!.id).get();
                                  ProductModel productModel = ProductModel.fromMap(data2.data()!);
                                  List fav=currentUserModel!.favourites;
                                  List favUser=productModel.favUser;
                                  print(fav);
                                  if(fav.contains(data!.id)){
                                    fav.remove(data.id);
                                  }else{
                                    fav.add(data.id);
                                  }if(favUser.contains(currentUserEmail)){
                                    favUser.remove(currentUserEmail);
                                  }else{
                                    favUser.add(currentUserEmail);
                                  }
                                  FirebaseFirestore.instance.collection("product").doc(data.id).update({
                                    "favUser":favUser
                                  });
                                  FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
                                    "favourites": fav
                                  });
                                  var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
                                  currentUserModel = userModel.fromMap(data1.data()!);
                                  var data3=await FirebaseFirestore.instance.collection("product").doc(data.id).get();
                                  productModel=ProductModel.fromMap(data3.data()!);
                                  setState(() {

                                  });
                                  print('Is Favorite $_isFavorite)');
                                  print('Is Favorite $_isFavorite)');
                                },
                              ),
                            ),
                          ),
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
          return CircularProgressIndicator();
        },);
  }
}
