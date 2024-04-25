import 'package:cached_network_image/cached_network_image.dart';
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
import '../../bookings/screens/productSingle.dart';
import '../../home/screen/home.dart';

class favouritePage extends ConsumerStatefulWidget {
  const favouritePage({super.key});

  @override
  ConsumerState<favouritePage> createState() => _favouriteState();
}

class _favouriteState extends ConsumerState<favouritePage> {
  bool loading = false;
  favFunc(name,id,price,category,image) async {
    loading = true;
    setState(() {

    });

    var data2=await FirebaseFirestore.instance.collection("product").doc(id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);

    favUser=productModel.favUser;
    if(fav.contains(id)){
      print(fav);
      fav.remove(id);
      print(fav);
      print(favourite);
      favourite.removeWhere((element) {
        print(element["id"]);
        return element["id"]==id;
      });
      print(id);
      print(favourite);
      favUser.removeWhere((element) => element==currentUserEmail);
      FirebaseFirestore.instance.collection("product").doc(id).update({
        "favUser":favUser
      });
      FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
        "favourites": favourite
      });
    }else{
      print("starytttttttttttttttttttttttttttt");
      fav.add(id);
      print(fav);
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
                  child: Container(
                    margin: EdgeInsets.all(8.0),
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
                        return ref.watch(productfavstreamProvider(data.favourites[index]["id"])).when(
                          data: (data) {
                            return  data==null?
                            Column(
                              children: [
                                Container(
                                  height: width * 0.4,
                                  width: width * 0.4,
                                  margin: EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                      color: Pallette.secondaryBrown,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Pallette.primaryColor,
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
                                        fav: data!.favUser.contains(currentUserEmail) ? true : false,
                                        like:true,
                                        id: data!.id,
                                        tag: data.productname,
                                        Petcategory: false,
                                          name:data[index].productname,
                                          price:data[index].price,
                                          category:data[index].category,
                                        image:data[index].image
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
                          },);
                      },
                    );
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
        ));
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
