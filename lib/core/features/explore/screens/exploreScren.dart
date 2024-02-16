import 'package:flutter/material.dart';
// import 'c';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';

import '../../../../commons/color constansts.dart';
import '../../../../main.dart';


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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            gap,
            gap,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
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





          ],
        ),
      ),
    );
  }
}