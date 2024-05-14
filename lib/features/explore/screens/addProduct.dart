import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flml_internet_checker/flml_internet_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:luna_demo/commons/color%20constansts.dart';
import 'package:luna_demo/commons/image%20Constants.dart';
import 'package:luna_demo/commons/widgets.dart';
import 'package:luna_demo/features/explore/controller/explore_controller.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../../commons/seachParam.dart';
import '../../../main.dart';

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  ConsumerState<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends ConsumerState<AddProduct> {
  var file;
  String imageurl = "";
  bool loading = false;

  pickFile(ImageSource) async {
    final imageFile = await ImagePicker.platform.pickImage(source: ImageSource);
    file = File(imageFile!.path);
    if (mounted) {
      setState(() {
        file = File(imageFile.path);
      });
      uploadFile();
      Navigator.pop(context);

    }
  }

  uploadFile() async {
    setState(() {
      loading=true;
    });
    if (file != null) {
      var uploadTask = await FirebaseStorage.instance
          .ref('images')
          .child("${DateTime.now()}")
          .putFile(file!,SettableMetadata(
          contentType: 'image/jpeg'
      ));

      imageurl = await uploadTask.ref.getDownloadURL();
      print(imageurl);
      if(imageurl!=""){
        pets.add(imageurl);
        setState(() {

        });
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("image uploaded")));
      setState(() {
        loading=false;
      });



    }

  }


  add(){
    ref.watch(exploreControllerProvider).addingProduct(
        ProductModel(
            productname: prdnamecontroller.text.trim(),
            image: pets,
            description: descriptioncontroller.text.trim(),
            price: double.parse(pricecontroller.text.trim()),
            sellername: namecontroller.text.trim(),
            address: addresscontroller.text.trim(),
            phonenumber: contactcontroller.text.trim(),
            id: '',
            userid: currentUserModel!.id.trim(),
            favUser: [],
            category: dropdownvalue.toString(),
            petcategory: petdropdownvalue.toString(),
            review: [],
          search: setSearchParam(prdnamecontroller.text+' '+petdropdownvalue.toString()+' '+dropdownvalue.toString()),
            deliverycharge: 0.0
        ));
    // FirebaseFirestore.instance.collection("users").doc(currentUserModel!.id).update({
    //   "productadder":"add"
    // });

  }
  // adrup(){
  //   ref.read(exploreControllerProvider).adder("add");
  // }


  TextEditingController prdnamecontroller=TextEditingController();
  TextEditingController descriptioncontroller=TextEditingController();
  TextEditingController pricecontroller=TextEditingController();
  TextEditingController namecontroller=TextEditingController();
  TextEditingController addresscontroller=TextEditingController();
  TextEditingController contactcontroller=TextEditingController();

  String? dropdownvalue;
  String? petdropdownvalue;
  List pets=[];

  var petCategory=[
    "Dogs",
    "Cats",
    "Birds",
    "Fish",
    "Small Animals",
    "Others",
  ];
  var drop=[
    "Pet",
    "Product"
  ];
  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      placeHolder: Container(
        child: Lottie.asset(ImageConstants.doglottie),
      ),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Add Product",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.05),),
          surfaceTintColor: Colors.white,
          toolbarHeight: height*0.04,
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height*0.28,
                  width: width*1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.025),

                    color: Pallette.primaryColor,
                  ),
                  child:ClipRRect(
                    borderRadius: BorderRadius.circular(width*0.025),
                    child:    loading?Center(child: CircularProgressIndicator(color: Colors.white,)): pets.isNotEmpty?
                    Image(image: CachedNetworkImageProvider(pets[0]),fit: BoxFit.cover,)
                        :Image(image: AssetImage(ImageConstants.pet15),fit: BoxFit.cover),
                  )
                ),
                gap,
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          // if(index==0){
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoActionSheet(
                                  actions: [
                                    CupertinoActionSheetAction(
                                        // isDefaultAction: true,
                                        onPressed: () {
                                          pickFile(ImageSource.gallery);

                                          setState(() {

                                          });
                                          // setState(() {
                                          //
                                          // });
                                        },
                                        child: Text("Photo Gallery",style: TextStyle(color: Pallette.primaryColor),)
                                    ),
                                    CupertinoActionSheetAction(
                                        // isDefaultAction: true,
                                        onPressed: () {
                                          pickFile(ImageSource.camera);
                                        },
                                        child: Text("Camera",style: TextStyle(color: Pallette.primaryColor),)
                                    ),
                                  ],
                                  cancelButton: CupertinoActionSheetAction(
                                      isDestructiveAction: true,
                                      isDefaultAction: true,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")
                                  ),
                                );
                              },
                            );
                          // }
                        },
                        child: Container(
                          height: height*0.2,
                          width: width*0.4,
                          child: Center(
                            child: Icon(CupertinoIcons.plus_app,size: 40,),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallette.primaryColor),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            pets.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                    },
                                    child: Container(
                                      height: height*0.2,
                                      width: width*0.4,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(width*0.025),
                                          child: CachedNetworkImage(imageUrl:pets[index],fit: BoxFit.cover,)),
                                      // decoration: BoxDecoration(
                                      //   image: DecorationImage(image: NetworkImage(pets[index]),fit: BoxFit.cover),
                                      //   color: Pallette.secondaryBrown,
                                      //   borderRadius: BorderRadius.circular(10),
                                      // ),
                                    ),
                                  ),
                                )
                        )
                      ),
                    ],
                  ),
                ),
                gap,
                TextFormField(
                  textInputAction:TextInputAction.next ,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: prdnamecontroller,
                  maxLength: 50,
                  style: TextStyle(
                    color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Product Name",
                    counterText: "",
                    labelStyle: TextStyle(
                      color:CupertinoColors.black,
                      fontSize: width*0.04
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide:BorderSide(color: Pallette.primaryColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(color: Pallette.primaryColor)
                    )
                  ),
                ),
                gap,
                TextFormField(
                  textInputAction:TextInputAction.newline ,
                  keyboardType: TextInputType.multiline,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: descriptioncontroller,
                  maxLength: 200,
                  maxLines: 2,
                  style: TextStyle(
                    color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Description",
                    counterText: "",
                    labelStyle: TextStyle(
                      color:CupertinoColors.black,
                      fontSize: width*0.04
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide:BorderSide(color: Pallette.primaryColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(color: Pallette.primaryColor)
                    )
                  ),
                ),
                gap,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.03),
                    border: Border.all(color: Pallette.primaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      underline: SizedBox(),
                      isExpanded: true,
                        hint: Text("Select category",style: TextStyle(color: CupertinoColors.black),),
                        icon: Icon(Icons.arrow_drop_down),
                        value: dropdownvalue,
                        items: drop.map((String? value){
                          return DropdownMenuItem(
                            value: value,
                              child:Text(value!));
                        }).toList(),
                        onChanged: (newvalue){
                        setState(() {
                          dropdownvalue=newvalue;
                        });
                        }),
                  ),
                ),
                gap,
                dropdownvalue=="Pet"?Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.03),
                    border: Border.all(color: Pallette.primaryColor)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      underline: SizedBox(),
                      isExpanded: true,
                        hint: Text("Select Pet Category",style: TextStyle(color: CupertinoColors.black),),
                        icon: Icon(Icons.arrow_drop_down),
                        value: petdropdownvalue,
                        items: petCategory.map((String? value){
                          return DropdownMenuItem(
                            value: value,
                              child:Text(value!));
                        }).toList(),
                        onChanged: (newvalue){
                        setState(() {
                          petdropdownvalue=newvalue;
                        });
                        }),
                  ),
                ):SizedBox(),
                gap,
                TextFormField(
                  textInputAction:TextInputAction.done ,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: pricecontroller,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                  maxLength: 10,
                  style: TextStyle(
                    color: CupertinoColors.black
                  ),
                  decoration: InputDecoration(
                    labelText: "Price",
                    counterText: "",
                    labelStyle: TextStyle(
                      color:CupertinoColors.black,
                      fontSize: width*0.04
                    ),
                    focusedBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide:BorderSide(color: Pallette.primaryColor)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width*0.03),
                      borderSide: BorderSide(color: Pallette.primaryColor)
                    )
                  ),
                ),
                gap,
                Text("Personal Information",style: TextStyle(fontSize: width*0.04,fontWeight: FontWeight.w600),),
                gap,
                Container(

                  width: width*1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width*0.04),
                    // border: Border.all(color: Pallette.primaryColor)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        textInputAction:TextInputAction.next ,
                        keyboardType: TextInputType.text,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: namecontroller,
                        maxLength: 50,
                        style: TextStyle(
                            color: CupertinoColors.black
                        ),
                        decoration: InputDecoration(
                            labelText: "Name",
                            counterText: "",
                            labelStyle: TextStyle(
                                color:CupertinoColors.black,
                                fontSize: width*0.04
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide:BorderSide(color: Pallette.primaryColor)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide: BorderSide(color: Pallette.primaryColor)
                            )
                        ),
                      ),
                      gap,
                      TextFormField(
                        textInputAction:TextInputAction.newline ,
                        keyboardType: TextInputType.multiline,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: addresscontroller,
                        maxLines: 2,
                        maxLength: 200,
                        style: TextStyle(
                            color: CupertinoColors.black
                        ),
                        decoration: InputDecoration(
                            labelText: "Address",
                            counterText: "",
                            labelStyle: TextStyle(
                                color:CupertinoColors.black,
                                fontSize: width*0.04
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide:BorderSide(color: Pallette.primaryColor)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide: BorderSide(color: Pallette.primaryColor)
                            )
                        ),
                      ),
                      gap,

                      TextFormField(
                        textInputAction:TextInputAction.done ,
                        keyboardType: TextInputType.phone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: contactcontroller,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLength: 10,
                        style: TextStyle(
                            color: CupertinoColors.black
                        ),
                        decoration: InputDecoration(
                            labelText: "Contact Number",
                            counterText: "",
                            labelStyle: TextStyle(
                                color:CupertinoColors.black,
                                fontSize: width*0.04
                            ),
                            focusedBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide:BorderSide(color: Pallette.primaryColor)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(width*0.03),
                                borderSide: BorderSide(color: Pallette.primaryColor)
                            )
                        ),
                      ),
                    ],
                  ),
                ),
                gap,
                InkWell(
                  onTap: () {
                    // FirebaseFirestore.instance.collection("product").add({
                    //   "name": namecontroller.text,
                    //   "description": descriptioncontroller.text,
                    //   "category": dropdownvalue,
                    //   "price": double.parse( pricecontroller.text,)
                    // });
                    // ProductModel ProductDetails=ProductModel(
                    //   image: pets,
                    //   productname: prdnamecontroller.text,
                    //   description: descriptioncontroller.text,
                    //   category: dropdownvalue,
                    //   price: double.parse(pricecontroller.text),
                    //   sellername: namecontroller.text,
                    //   address: addresscontroller.text,
                    //   phonenumber: contactcontroller.text,
                    //   id: "",
                    //   favUser: [],
                    //   userid: currentUserModel!.id,
                    // );
                    // FirebaseFirestore.instance.collection("product").add(
                    //   ProductDetails.toMap()
                    // ).then((value) {
                    //   value.update(
                    //     ProductDetails.copyWith(
                    //       id: value.id
                    //     ).toMap()
                    //   );
                    // });
                    if(imageurl.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Insert Your Product/Pet Image")));
                      return;
                    }
                    if(prdnamecontroller.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Product Name")));
                      return;
                    }
                    if(dropdownvalue==null){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select the Category")));
                      return;
                    }
                    if(pricecontroller.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter the Price")));
                      return;
                    }
                    if(namecontroller.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Name")));
                      return;
                    }
                    if(addresscontroller.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Address")));
                      return;
                    }
                    if(contactcontroller.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Your Contact Number")));
                      return;
                    }

                    // update();

                  add();
                    // adrup();
                    Navigator.pop(context);



                  },
                  child: Container(
                    height: width*0.15,
                    width: width*0.8,
                    decoration:BoxDecoration(borderRadius: BorderRadius.circular(width*0.03),
                    gradient: LinearGradient(
                        colors: [Pallette.primaryColor,
                          Pallette.secondaryBrown,],
                      begin: Alignment.topLeft,
                      end: Alignment(4, 2),
                    )
                    ) ,
                    child: Center(
                      child: Text("SUBMIT",
                      style: TextStyle(
                        fontSize: width*0.04,
                        fontWeight: FontWeight.w600,
                        color: Pallette.white
                      ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
