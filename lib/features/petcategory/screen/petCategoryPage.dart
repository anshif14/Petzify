import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/core/constproviders/searcProvider.dart';
import 'package:luna_demo/features/petcategory/controller/categoryController.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/image Constants.dart';
import '../../../main.dart';
import '../../../model/product_Model.dart';
import '../../../model/user_Model.dart';
import '../../bookings/screens/productSingle.dart';
import '../../home/screen/home.dart';

class PetCategoryPage extends ConsumerStatefulWidget {
  final String category;
  const PetCategoryPage({super.key,required this.category});

  @override
  ConsumerState createState() => _PetCategoryPageState();
}

class _PetCategoryPageState extends ConsumerState<PetCategoryPage> {
  final search=StateProvider<String>((ref) => '');

  TextEditingController searchController = TextEditingController();
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
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.doglottie),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          surfaceTintColor: Pallette.white,
          title:Text("Explore by pets",style: TextStyle(
              fontSize:width*0.05,
              fontWeight: FontWeight.w600
          )),

      ),
      body: Padding(
        padding:  EdgeInsets.only(right: width*0.04,left: width*0.04,bottom: width*0.04,),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: height * 0.055,
                decoration: BoxDecoration(
                    color: Pallette.secondaryBrown,
                    borderRadius: BorderRadius.circular(width*0.03)),
                child: TextFormField(
                  onChanged: (value) {
                    
                    
                    ref.read(search.notifier).update((state) => value.toString().toUpperCase());
                    
                
                  },
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
          ref.watch(CategoryStreamProvider(jsonEncode({
            "category":widget.category,
            "search":ref.watch(search)
          }))).when(
              data: (data) {
                return AnimationLimiter(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.6, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration:  Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProducctSingleScreen(
                                          fav: fav.contains(data[index].id) ? true : false,
                                          id:data[index].id,
                                          tag: data[index].image[0],
                                          like: false,
                                          Petcategory: false,
                                          name:data[index].productname,
                                          price:data[index].price,
                                          category:data[index].category,
                                          image: data[index].image
          
                                      ),
                                    ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    loading?
                                    Stack(
                                      children: [
                                        Hero(
                                          tag: data[index].image,
                                          child:Container(
                                            height: width * 0.4,
                                            width: width * 0.4,
                                            decoration: BoxDecoration(
                                                color: Pallette.secondaryBrown,
                                                image: DecorationImage(
                                                    image: NetworkImage(data[index].image[0]),
                                                    fit: BoxFit.cover,opacity:0.6),
                                                borderRadius: BorderRadius.circular(15)),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              height: width*0.1,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                // color: Colors.white.withOpacity(0.4)
                                              ),
                                              child: Center(
                                                child: IconButton(onPressed: (){
                                                  // ref.read(favour.notifier).update((state) => !state);
                                                  favFunc(data[index].productname,data[index].id, data[index].price, data[index].category,data[index].image);
                                                }
                                                  , icon: Icon(
                                                    fav.contains(data[index].id) ? Icons.favorite : Icons.favorite,
                                                    color: fav.contains(data[index].id) ?Colors.red:Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ):
                                    Stack(
                                      children: [
                                        Hero(
                                          tag: data[index].image,
                                          child:Container(
                                            height: width * 0.4,
                                            width: width * 0.4,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(15),
                                                child: CachedNetworkImage(imageUrl:data[index].image[0],fit: BoxFit.cover,)),
                                            // decoration: BoxDecoration(
                                            //     color: Pallette.secondaryBrown,
                                            //     image: DecorationImage(
                                            //         image: NetworkImage(widget.image[0]),
                                            //         fit: BoxFit.cover),
                                            //     borderRadius: BorderRadius.circular(15)),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 1,
                                          child: Container(
                                            padding:  EdgeInsets.all(width*0.003),
                                            height: width*0.1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // color: Colors.white.withOpacity(0.4)
                                            ),
                                            child: Center(
                                              child: IconButton(onPressed: (){
                                                // ref.read(favour.notifier).update((state) => !state);
                                                favFunc(data[index].productname,data[index].id, data[index].price, data[index].category,data[index].image);
                                              }
                                                , icon: Icon(
                                                  fav.contains(data[index].id) ? Icons.favorite : Icons.favorite,
                                                  color: fav.contains(data[index].id) ?Colors.red:Colors.grey,
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
                                          Text(
                                            data[index].productname,
                                            style: TextStyle(fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text('₹ ' + data[index].price.toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // petTile(
                            //   index: index,
                            //   image:data[index].image.toList(),
                            //   name:data[index].productname,
                            //   price:data[index].price,
                            //   category:data[index].category!,
                            //   id:data[index].id,
                            // ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));
          
              },)
          
            ],
          ),
        ),
      ),
    ));
  }
}
