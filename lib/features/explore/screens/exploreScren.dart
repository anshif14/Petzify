import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'c';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/explore/screens/addProduct.dart';

import '../../../../commons/color constansts.dart';
import '../../../../main.dart';
import '../../product/screens/productSingle.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

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

  List trending =[
    imageConstants.trending,
    imageConstants.trending1,
    imageConstants.trending
    ,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        elevation: width*0,
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) =>AddProduct() ,));
          },
          label: Text("Add",style: TextStyle(fontWeight: FontWeight.w600,color: CupertinoColors.black)),
        icon: Icon(Icons.add,color: CupertinoColors.black,),
        backgroundColor: Colors.white,
        shape: BeveledRectangleBorder(side: BorderSide(color: Pallette.primaryColor),
            borderRadius: BorderRadius.circular(width*0.03)),
      ),
          
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            gap,
            Padding(
              padding:  EdgeInsets.all(8.0),
              child: Expanded(
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(8.0),
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
                  )),
            ),
            gap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Trending now",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 22),),
                Text("See all",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),)
              ],
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: List.generate(trending.length, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width*0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: width*0.4,
                          width: width*0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: AssetImage(trending[index]))
                          ),
                        ),
                        Text('Free puppy socialisation in store',style: TextStyle(fontSize: 16),),
                        Text('Free',style: TextStyle(fontSize: 14,color: Colors.grey.shade600),)
                      ],
                    ),
                  ),
                )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pets.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return petTile(index: index);
                  },
                ),
              ),
            )

          ],
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
