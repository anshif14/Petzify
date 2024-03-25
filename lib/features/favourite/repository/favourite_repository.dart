import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/features/favourite/screen/favourite.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';


final streamFavRepositoryProvider = Provider((ref) => StreamFavRepository(firestore: ref.watch(firestoreProvider)));

class StreamFavRepository{
  final FirebaseFirestore _firestore;
  StreamFavRepository({required FirebaseFirestore firestore}):
        _firestore = firestore;

  CollectionReference get _usersFavourite => _firestore.collection('users');
  CollectionReference get _productFavourite => _firestore.collection("product");

  Stream<userModel> favouriteDataStream(){
    return _usersFavourite.doc(currentUserModel?.id).snapshots().map((event) => userModel.fromMap(event.data() as Map<String, dynamic>));
  }
  Stream <ProductModel>favouriteProductStream(List<Widget> dataFavIndex){
    print(dataFavIndex);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr*****************************");
    return _productFavourite.doc(dataFavIndex.toString()).snapshots().map((event) => ProductModel.fromMap(event.data() as Map<String,dynamic>));
  }
  
  
  // streamData(){
  //   return _stream.snapshots().map((event) => event.docs.map((e) =>
  //       ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  // }



}