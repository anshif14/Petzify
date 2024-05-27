import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

import '../../../core/providers/firebase_provider.dart';


final exploreRepositoryProvider=Provider((ref)=>ExploreRepository(firestore:ref.watch(firestoreProvider)));


UserModel? usermodel;

class ExploreRepository {
  final FirebaseFirestore _firestore;

  ExploreRepository({ required FirebaseFirestore firestore}) :
        _firestore = firestore;

  CollectionReference get _explore => _firestore.collection('product');

  CollectionReference get _user => _firestore.collection('users');


  addProduct(ProductModel productData) {
    _explore.add(productData.toMap()).then((value) {
      List? newOrder = currentUserModel?.productadd;
      newOrder?.add(value.id);

      value.update(productData.copyWith(id: value.id).toMap());

      /// FirebaseFirestore.instance.collection('users')
      _user.doc(currentUserModel!.id).update(
          currentUserModel!.copyWith(productadd: newOrder,productCount: newOrder?.length).toMap());
    });
  }
}
  // adder(String add){
  //   // print(currentUserModel?.id);
  //   _user.doc(currentUserModel!.id).update(currentUserModel!.copyWith(productadder: add).toMap());
  // }