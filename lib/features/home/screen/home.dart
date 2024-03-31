import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/home/controller/stream_controller.dart';
// import 'package:luna_demo/core/features/product/screens/productSingle.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../auth/screen/loginPage.dart';
import '../../bookings/screens/productSingle.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List banner = [
    imageConstants.banner1,
    imageConstants.banner2,
    imageConstants.banner3,
  ];
  List trending = [
    imageConstants.trending,
    imageConstants.trending1,
    imageConstants.trending,
  ];

  List pets = [
    {'name': 'food', "image": imageConstants.petfood, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet4, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet1, "price": 1000},
    {'name': 'supplies', "image": imageConstants.supplies, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet2, "price": 1250},
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

  List category = [
    {'name': 'Dogs', 'image': imageConstants.dog},
    {'name': 'Cats', 'image': imageConstants.cat},
    {'name': 'Birds', 'image': imageConstants.bird},
    {'name': 'Fish', 'image': imageConstants.fish},
    {'name': 'Small Animals', 'image': imageConstants.rabbit},
  ];


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SvgPicture.asset(imageConstants.dogSvg),
                  Text(
                    "LUNA",
                    style: GoogleFonts.cormorantGaramond(
                        color: Pallette.primaryColor,
                        wordSpacing: 2,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  SvgPicture.asset(imageConstants.dogSvg),
                ],
              ),
              Row(
                children: [Icon(Icons.location_on_outlined), Text("Kerala")],
              ),
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('banner').snapshots(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return CarouselSlider(
                      items: List.generate(
                          FirebaseFirestore.instance.collection('banner').doc(images),
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.teal,
                                      image: DecorationImage(
                                          image: NetworkImage(Banner[index]),
                                          fit: BoxFit.cover)),
                                ),
                              )),
                      options:
                          CarouselOptions(height: height * 0.2, autoPlay: true));
                }
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Explore by pets",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  )
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                      category.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: width * 0.2,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              category[index]['image']),
                                          fit: BoxFit.cover)),
                                ),
                                Text(category[index]['name'])
                              ],
                            ),
                          )),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Explore nearby",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ],
              ),
              // StreamBuilder(
              // stream: FirebaseFirestore.instance.collection("product").snapshots().map((snapshot) {
              //          return snapshot.docs.map((doc){
              //               return ProductModel.fromMap(doc.data());
              //         }).toList();
              //         }),
              //  builder: (context, snapshot) {
              //   if(!snapshot.hasData){
              //     return Center(child: CircularProgressIndicator(
              //       color: Pallette.primaryColor,
              //     ),);
              //   }
              //   List<ProductModel> data=snapshot.data!;
              //   print(data);
              //   print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                   ref.watch(datastreamProvider).when(data: (data) {
                     return  GridView.builder(
                       physics: NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemCount: data.length,
                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                           childAspectRatio: 0.8, crossAxisCount: 2),
                       itemBuilder: (context, index) {
                         return petTile(
                             index: index,
                             image:data[index].image.toList(),
                             name:data[index].productname,
                             price:data[index].price,
                             category:data[index].category!,
                             id:data[index].id
                         );
                       },
                     );
                   },
                       error: (error, stackTrace) {
                     return Text(error.toString());
                       },
                       loading: () {
                         return CircularProgressIndicator();
                       },)
            ],
          ),
        ),
      ),
    );
  }
}

class petTile extends StatefulWidget {
  final int index;
  final List image;
  final String name;
  final double price;
  final String category;
  final String id;
  const petTile({
    super.key,
    required this.index,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.id
  });

  @override
  State<petTile> createState() => _petTileState();
}

class _petTileState extends State<petTile> {

  int index = 0;
  favFunc() async {
    var data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
    var data2=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);
    currentUserModel = userModel.fromMap(data.data()!);
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
    currentUserModel = userModel.fromMap(data1.data()!);
    var data3=await FirebaseFirestore.instance.collection("product").doc(widget.id).get();
    productModel=ProductModel.fromMap(data3.data()!);
    setState(() {

    });
  }

  @override
  void initState() {
    index = widget.index;
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProducctSingleScreen(
                    id:widget.id,
                    tag: widget.image[0],
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Hero(
                      tag: widget.image,
                      child: Container(
                        height: width * 0.4,
                        width: width * 0.4,
                        decoration: BoxDecoration(
                            color: Pallette.secondaryBrown,
                            image: DecorationImage(
                                image: NetworkImage(widget.image[0]),
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
                              isFavorite: currentUserModel!.favourites.contains(widget.id),
                              iconSize: 25,
                              valueChanged: (_isFavorite) async {
                                favFunc();
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
                      Text(
                        widget.category,
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
                      Text('₹ ' + widget.price.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
