import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'c';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/explore/screens/addProduct.dart';
import 'package:luna_demo/features/explore/screens/coming_soon.dart';

import '../../../../commons/color constansts.dart';
import '../../../../main.dart';
import '../../product/screens/productSingle.dart';


class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  List trending =[
    imageConstants.trending,
    imageConstants.trending1,
    imageConstants.trending
    ,
  ];

  List items=[
    {'name':'Pet Veterinary','image': imageConstants.veterinary,},
    {'name':'Pet Breeding Center','image': imageConstants.breeding,},
    {'name':'Pet Boardind','image': imageConstants.boarding,},
    {'name':'Pet Training Center','image':imageConstants.training,},
    {'name':'Pet Grooming Center','image':imageConstants.grooming},
  ];
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
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
          
      body: SingleChildScrollView(
        child: Padding(
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
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                  crossAxisSpacing: 19,
                  mainAxisSpacing: 19


                ),
                itemBuilder: (context, index) {
                  return    Column(

                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context, CupertinoPageRoute(builder: (context) => comingSoon(),));
                        },
                        child: Container(
                          height: width*0.4,
                          width: width*0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width*0.04),
                              image: DecorationImage(image: AssetImage(items[index]['image']),fit: BoxFit.cover)
                          ),
                        ),
                      ),
                      Text(items[index]['name'],style: TextStyle(fontSize:width*0.035),)
                    ],
                  );

                },
              )


            ],
          ),
        ),
      ),
    );
  }
}


