import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
// import 'package:luna_demo/core/features/product/screens/productSingle.dart';
import 'package:luna_demo/main.dart';

import '../auth/screen/loginPage.dart';
import '../product/screens/productSingle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

data() async {
  var userlist =await FirebaseFirestore.instance
      .collection('users').doc(Userid).get();
  currentUserName=userlist[0]["name"];
  currentUserEmail=userlist[0]["email"];
  currentUserImage=userlist[0]["images"];
}
@override
  void initState() {
  data();
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
              CarouselSlider(
                  items: List.generate(
                      banner.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.teal,
                                  image: DecorationImage(
                                      image: AssetImage(banner[index]),
                                      fit: BoxFit.cover)),
                            ),
                          )),
                  options:
                      CarouselOptions(height: height * 0.2, autoPlay: true)),
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
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return petTile(index: index);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class petTile extends StatefulWidget {
  final int index;
  const petTile({super.key, required this.index});

  @override
  State<petTile> createState() => _petTileState();
}

class _petTileState extends State<petTile> {
  List pets = [
    {'name': 'food', "image": imageConstants.petfood, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet3, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet1, "price": 1000},
    {'name': 'supplies', "image": imageConstants.supplies, "price": 1000},
    {'name': 'pet', "image": imageConstants.pet2, "price": 1250},
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

  int index = 0;

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
                image: pets[index]['image'],
                tag: pets[index]['image'],
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
                  tag: pets[index]['image'],
                  child: Container(
                    height: width * 0.4,
                    width: width * 0.4,
                    decoration: BoxDecoration(
                        color: Pallette.secondaryBrown,
                        image: DecorationImage(
                            image: AssetImage(pets[index]['image']),
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
                          iconSize: 25,
                          valueChanged: (_isFavorite) {
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
                  Text(
                    pets[index]['name'],
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
                  Text('₹ ' + pets[index]['price'].toDouble().toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
