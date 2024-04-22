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

class favourite extends ConsumerStatefulWidget {
  const favourite({super.key});

  @override
  ConsumerState<favourite> createState() => _favouriteState();
}

class _favouriteState extends ConsumerState<favourite> {

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
                        return petTile(data: data.favourites[index],);
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

class petTile extends ConsumerStatefulWidget {
  final dynamic data;
  const petTile({super.key, required this.data});

  @override
  ConsumerState<petTile> createState() => _petTileState();
}

class _petTileState extends ConsumerState<petTile> {
  final favour=StateProvider<bool>((ref) =>false );
  favFunc(data) async {

    var data2=await FirebaseFirestore.instance.collection("product").doc(data.id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);
    List fav=currentUserModel!.favourites;
    List favUser=productModel.favUser;
    print(fav);
    if(fav.contains(data.id)){
      fav.remove(data.id);
      favUser.removeWhere((element) => element==currentUserEmail);

    }else{
      fav.add(data.id);
      favUser.add(currentUserEmail);

    }
    // if(favUser.contains(currentUserEmail)){
    // }else{
    // }
    FirebaseFirestore.instance.collection("product").doc(data.id).update({
      "favUser":favUser
    });
    FirebaseFirestore.instance.collection("users").doc(currentUserEmail).update({
      "favourites": fav
    });
    var data1=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
    currentUserModel = UserModel.fromMap(data1.data()!);
    var data3=await FirebaseFirestore.instance.collection("product").doc(data.id).get();
    productModel=ProductModel.fromMap(data3.data()!);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    // final favoriteState = ref.watch(favoriteStateProvider);

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
                      fav: favour,
                      like:true,
                      id: data!.id,
                      tag: data.productname,
                      category: false,
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
                              child:
                              IconButton(onPressed: (){
                                ref.read(favour.notifier).update((state) => !state);
                                favFunc(data);
                              }
                                , icon: Icon(
                                  ref.watch(favour) ? Icons.favorite : Icons.favorite,
                                  color: ref.watch(favour) ?Colors.red:Colors.red,
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
  }
}
