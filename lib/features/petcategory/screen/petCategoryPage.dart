import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/petcategory/controller/categoryController.dart';

import '../../../commons/color constansts.dart';
import '../../../main.dart';
import '../../../model/product_Model.dart';
import '../../../model/user_Model.dart';
import '../../bookings/screens/productSingle.dart';

class PetCategoryPage extends ConsumerStatefulWidget {
  final String category;
  const PetCategoryPage({super.key,required this.category});

  @override
  ConsumerState createState() => _PetCategoryPageState();
}

class _PetCategoryPageState extends ConsumerState<PetCategoryPage> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Container(
              height: height * 0.055,
              decoration: BoxDecoration(
                  color: Pallette.secondaryBrown,
                  borderRadius: BorderRadius.circular(width*0.03)),
              child: TextFormField(
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
        ref.watch(CategoryStreamProvider(widget.category)).when(
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
                          child: petTile(
                            index: index,
                            image:data[index].image.toList(),
                            name:data[index].productname,
                            price:data[index].price,
                            category:data[index].category!,
                            id:data[index].id
                          ),
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
              return CircularProgressIndicator();
            },)

          ],
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
                fav:StateProvider<bool>((ref) =>false ),
                like: false,
                category:true

              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
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
