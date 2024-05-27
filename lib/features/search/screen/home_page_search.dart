
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/features/search/controller/home_search_controller.dart';

import '../../../commons/color constansts.dart';

import '../../../main.dart';
import '../../bookings/screens/productSingle.dart';
import '../../home/screen/home.dart';

class HomeSearchPage extends ConsumerStatefulWidget {
  const HomeSearchPage({super.key});

  @override
  ConsumerState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends ConsumerState<HomeSearchPage> {
  TextEditingController searchController = TextEditingController();
  final search=StateProvider<String>((ref) => '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      surfaceTintColor: Pallette.white,
      elevation: 0,
      toolbarHeight: height*0.01,
    ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                autofocus: true,
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
                  prefixIcon:InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(CupertinoIcons.arrow_left)),
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
            Expanded(child:
            ref.watch(searchdatastreamProvider(
              ref.watch(search)
            )).when(
              data: (data) {
                return data.isNotEmpty?ListView.separated(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
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
                      child: Container(
                        height: height*0.066,
                        width: width*1,
                        child: Padding(
                          padding: EdgeInsets.all(width*0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.search_rounded,size: width*0.05,),
                              SizedBox(width: width*0.04,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width*0.5,
                                    // height: height*0.05,
                                    // color: Colors.red,
                                    child: Text(data[index].productname,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.black,
                                          fontSize: width*0.035
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width*0.5,
                                    // height: height*0.05,
                                    // color: Colors.red,
                                    child: Text(data[index].category,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey,
                                          fontSize: width*0.02
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox();
                  },):Lottie.asset("assets/animation/3pexx7tb5g.json");
              },
              error: (error, stackTrace) {
                return Text(error.toString());
              },
              loading: () {
                return Center(
                  child: CircularProgressIndicator(
                    color: Pallette.primaryColor,
                  ),
                );
              },
            )
            )

          ],
        ),
      ),
    );
  }
}
