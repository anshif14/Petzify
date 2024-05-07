import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/seachParam.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/home/controller/stream_controller.dart';
import 'package:luna_demo/features/petcategory/screen/petCategoryPage.dart';
import 'package:luna_demo/features/search/screen/home_page_search.dart';

import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';



import '../../bookings/screens/productSingle.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

List fav=[];
List favourite=[];
List favUser=[];
class _HomePageState extends ConsumerState<HomePage> {
  Position ?_currentLocation;
  late bool servicePermission=false;
  late  LocationPermission permission;
  String _currentAdress ="";
  TextEditingController searchController = TextEditingController();


  Future<Position> _getCurrentLocation() async {
    servicePermission =await Geolocator.isLocationServiceEnabled();
    if(!servicePermission){

    }
    permission=await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission =await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async{
    try{
      List<Placemark> placemark =await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemark[0];
      setState(() {
        _currentAdress ="${place.locality},${place.country}";
      });
    }catch (e){

    }
  }

  fetch()async{
    _currentLocation =await _getCurrentLocation();
    await _getAddressFromCoordinates();
    setState(() {

    });
  }

  List trending = [
    ImageConstants.trending,
    ImageConstants.trending1,
    ImageConstants.trending,
  ];

  List category = [
    {'name': 'Dogs', 'image': ImageConstants.dog},
    {'name': 'Cats', 'image': ImageConstants.cat},
    {'name': 'Birds', 'image': ImageConstants.bird},
    {'name': 'Fish', 'image': ImageConstants.fish},
    {'name': 'Small Animals', 'image': ImageConstants.rabbit},
  ];

  bool loading = false;

  getFav() async {
    DocumentSnapshot<Map<String, dynamic>> data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
    Map<String,dynamic> favFB=data.data()!;
    favourite=favFB["favourites"];
    for(int i =0;i<favourite.length;i++){
      fav.add(favourite[i]["id"]);
    }
  }

  favFunc(name,id,price,category,image) async {
    loading = true;
    setState(() {

    });
    var data2=await FirebaseFirestore.instance.collection("product").doc(id).get();
    ProductModel productModel = ProductModel.fromMap(data2.data()!);

    favUser=productModel.favUser;
    if(fav.contains(id)){
      print(fav);
      fav.removeWhere((element) => element==id,);
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
  void initState() {
    fetch();

      getFav();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.doglottie),
      ),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          toolbarHeight: height*0.09,
          elevation: 2,
          title:ListTile(
            title:  Text(
              "LUNA",
              style: GoogleFonts.cormorantGaramond(
                  color: Pallette.primaryColor,
                  wordSpacing: 2,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
            subtitle: Row(
              children: [Icon(Icons.location_on_outlined),_currentAdress.isNotEmpty?Text(_currentAdress.toString()):Text("Kerala")
              ],
            ),
            trailing:  SvgPicture.asset(ImageConstants.dogSvg),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: height * 0.055,
                  decoration: BoxDecoration(
                      color: Pallette.secondaryBrown,
                      borderRadius: BorderRadius.circular(width*0.03)),
                  child: TextFormField(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => HomeSearchPage(controller:searchController),));
                    },
                    onChanged: (value) {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => HomeSearchPage(controller:searchController),));
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
                // gap,
                // InkWell(
                //   onTap: () {
                //     // print(setSearchParam('shadil'));
                //
                //     FirebaseFirestore.instance.collection('product').get().then((value) {
                //
                //       for(var docs in value.docs){
                //        FirebaseFirestore.instance.collection('product').doc(docs.id).update({
                //          'search':setSearchParam(docs['productname']+' '+docs["category"]+' '+docs["petcategory"])
                //        });
                //       }
                //
                //     });
                //
                //   },
                //   child: Container(
                //     width: width*0.2,
                //     height: width*0.08,
                //     color: Pallette.primaryColor,
                //     child: Center(child: Text("get",style: TextStyle(
                //       color: Colors.white
                //     ),)),
                //   ),
                // ),
                gap,
                ref.watch(databannerProvider).when(
                  data: (data) {
                    List banners = data!['images'];
                    return CarouselSlider(

                        items: List.generate(
                            banners.length,
                                (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius:  BorderRadius.circular(12),
                                  child: CachedNetworkImage(imageUrl: banners[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  // color: Colors.teal,
                                ),
                              ),
                            )),
                        options:
                        CarouselOptions(
                            viewportFraction: 0.7,
                            height: height * 0.2,
                            autoPlay: true,
                          enlargeCenterPage: true
                        ));
                  },
                  error: (error, stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () {
                    return Center(child: CircularProgressIndicator(color: Pallette.primaryColor,));

                  },),
                gap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore by pets",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                    ),
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
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, CupertinoPageRoute(builder:(context) => PetCategoryPage(
                                      category:category[index]["name"]
                                  ), ));
                                },
                                child: Container(
                                  height: width * 0.2,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              category[index]['image']),
                                          fit: BoxFit.cover)),
                                ),
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
                      "Explore popular",
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ],
                ),
                ref.watch(datastreamProvider).when(data: (data) {
                  if(firstTime==false){
                    data.shuffle();
                  }
                  // firstTime==false ? data.shuffle() : null;
                  firstTime=true;
                  return AnimationLimiter(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.8, crossAxisCount: 2),
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

                                      // Container(
                                      //   width: width*0.4,
                                      //   height: width*0.4,
                                      //   child: Padding(
                                      //     padding:  EdgeInsets.all(width*0.15),
                                      //     child: CircularProgressIndicator(
                                      //       color: Pallette.primaryColor,
                                      //     ),
                                      //   ),
                                      // ):
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
                                            Container(
                                              width: width*0.4,
                                              child: Text(
                                                data[index].productname,
                                                style: TextStyle(fontWeight: FontWeight.w800,overflow: TextOverflow.ellipsis),
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
                                            Text('₹ ' + data[index].price.toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // child: petTile(
                              //     index: index,
                              //     image:data[index].image.toList(),
                              //     name:data[index].productname,
                              //     price:data[index].price,
                              //     category:data[index].category!,
                              //     id:data[index].id,
                              //   fav:fav
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
      ),
    );
  }
}

// class petTile extends ConsumerStatefulWidget {
//   final int index;
//   final List image;
//   final String name;
//   final double price;
//   final String category;
//   final String id;
//   final List fav;
//   const petTile({
//     super.key,
//     required this.index,
//     required this.image,
//     required this.name,
//     required this.price,
//     required this.category,
//     required this.id,
//     required this.fav
//   });
//
//   @override
//   ConsumerState<petTile> createState() => _petTileState();
// }
//
// class _petTileState extends ConsumerState<petTile> {
//   // final favour=StateProvider<bool>((ref) =>fav.contains(widget.id) );
//   int index = 0;
//
//
//
//
//   // getfun() async {
//   //   DocumentSnapshot<Map<String, dynamic>> data=await FirebaseFirestore.instance.collection("users").doc(currentUserEmail).get();
//   //   currentUserModel=UserModel.fromMap(data.data()!);
//   //   List fav=currentUserModel!.favourites;
//   //   if(fav.isNotEmpty){
//   //     print("ghjkl,,,,");
//   //     print("cvbnm,");
//   //     if(fav.contains(widget.id)){
//   //       ref.read(favour.notifier).update((state) => true);
//   //     }
//   //     else{
//   //       ref.read(favour.notifier).update((state) => false);
//   //     }
//   //   }
//   //
//   // }
//   //
//
//
//
//
//   Widget build(BuildContext context) {
//     return
//   }
// }
