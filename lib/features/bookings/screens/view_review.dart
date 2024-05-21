import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/main.dart';
import 'package:readmore/readmore.dart';

import '../../../commons/color constansts.dart';
import '../../../commons/image Constants.dart';

class View_review extends StatefulWidget {
  final List<dynamic> review;
  // final String name;
  // final String image;
  // // final String review;
  // final String productImage;
  const View_review({super.key, required this.review});

  @override
  State<View_review> createState() => _View_reviewState();
}

class _View_reviewState extends State<View_review> {

  bool tap=false;

  List images=[];

  getData(){
    for(int i=0;i<widget.review.length;i++){
      for(int j=0;j<widget.review[i]["productImage"].length;j++){
        images.add(widget.review[i]["productImage"][j]);
      }

    }

  }

  @override
  void initState() {
    getData();
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
          title: Text("View Review",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05)),
        ),
        body: Padding(
          padding: EdgeInsets.all(width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            images.isNotEmpty?tap==false?Container(
                height: height * 0.15,
                width: width*1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tap == false && images.length>3 ? images.sublist(0,3).length + 1 : images.length+1,
                  itemBuilder: (BuildContext context, int index) {

                    return  index==(tap == false && images.length>3 ? images.sublist(0,3).length : images.length) ?
             GestureDetector(
                      onTap: () {
                        tap=!tap;
                        setState(() {

                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(width*0.02),
                        height: height * 0.13,
                        width: width * 0.3,
                        child: Center(child: Text("See More",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: width*0.04),)),

                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(width*0.02)
                        ),
                      ),
                    ) : Container(
                      margin: EdgeInsets.all(width*0.02),
                      height: height * 0.13,
                      width: width * 0.3,
                      // child: ClipRRect(
                      //   borderRadius:
                      //   BorderRadius.circular(width * 0.02),
                      //   // child: Image(
                      //   //   image:
                      //   //   CachedNetworkImageProvider(pets[index]),
                      //   //   fit: BoxFit.cover,
                      //   // )
                      // ),
                      decoration: BoxDecoration(
                        image:DecorationImage(image: NetworkImage(images[index]),fit: BoxFit.cover),
                          color: Pallette.primaryColor,
                          borderRadius: BorderRadius.circular(width*0.02)
                      ),
                    );
                  },
                ),
              ):   Container(
             height: height * 0.43,
             width: width * 1,
             child: GridView.builder(
               itemCount: images.length+1,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   childAspectRatio: 1.8,
                   mainAxisSpacing: width * 0.025,
                   crossAxisSpacing: width * 0.025,
                   mainAxisExtent: width * 0.3,
                   crossAxisCount: 3),
               itemBuilder: (context, index) {
                 return  index==images.length ?
                 GestureDetector(
                   onTap: () {
                     tap=!tap;
                     setState(() {

                     });
                   },
                   child: Container(
                     padding: EdgeInsets.all(width*0.02),
                     height: height * 0.13,
                     width: width * 0.8,
                     child: Center(child: Text("See Less",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: width*0.04),)),

                     decoration: BoxDecoration(
                         color: Colors.black.withOpacity(0.5),
                         borderRadius: BorderRadius.circular(width*0.02)
                     ),
                   ),
                 )
                 :Container(
                   height: height * 0.13,
                   width: width * 0.3,
                   decoration: BoxDecoration(
                       image:DecorationImage(image: NetworkImage(images[index]),fit: BoxFit.cover),
                       color: Pallette.primaryColor,
                       borderRadius: BorderRadius.circular(width*0.02)
                   ),
                 );
               },
             ),
             // color: Colors.red,
           ):SizedBox(),
                SizedBox(height: height*0.01,),
                Text("Customer Reviews",style: TextStyle(fontSize: width*0.045,fontWeight: FontWeight.w600),),
                SizedBox(height: height*0.01,),

                Container(

                  height:height*0.67,
                  child:widget.review.isNotEmpty?ListView.builder(
                    itemCount: widget.review.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.all(width*0.015),
                            // height:height*0.21 ,
                            width: width*1,
                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(width*0.03),
                                border: Border.all(color: Pallette.primaryColor)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ListTile(
                                    leading:CircleAvatar(
                                      backgroundColor: Pallette.primaryColor,
                                      backgroundImage: widget.review[index]["image"]==""?NetworkImage("https://happytravel.viajes/wp-content/uploads/2020/04/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"):
                                      NetworkImage(widget.review[index]['image'].toString()),
                                      radius: width*0.055,
                                    ),
                                    title: Container(
                                        height: height*0.05,
                                        child: Center(child: Text("${widget.review[index]['userid']}",style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w600,fontSize: width*0.04),)))

                                ),
                                Padding(
                                  padding: EdgeInsets.all(width*0.03),
                                  child: Container(
                                    height: height*0.085,
                                    width: width*0.85,
                                    child: SingleChildScrollView(
                                      child: ReadMoreText(
                                        "${widget.review[index]['review']}",
                                        trimMode: TrimMode.Line,
                                        trimLines: 2,
                                        // colorClickableText: Colors.pink,
                                        trimCollapsedText: 'Show more',
                                        trimExpandedText: 'Show less',
                                        lessStyle:TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold) ,
                                        moreStyle: TextStyle(fontSize: width*0.035, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ):SizedBox(),
                )

              ],
            ),
          ),
        ),

      ),
    );
  }
}
