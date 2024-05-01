import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/product_Model.dart';

final CategoryStreamRepositoryProvider=Provider((ref) => CategoryStreamRepository(firestore: ref.watch(firestoreProvider)));

class CategoryStreamRepository{
  final FirebaseFirestore _firestore;
  CategoryStreamRepository({required FirebaseFirestore firestore}):_firestore=firestore;
  
  CollectionReference get categoryStream=> _firestore.collection("product");
  
  Stream CategoryStream(String category ,String search){



    return search==''? categoryStream.where("petcategory",isEqualTo: category).snapshots().map((event) => event.docs.map((e) =>
        ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList()):
    categoryStream.where("petcategory",isEqualTo: category).where('search',arrayContains: search).snapshots().map((event) => event.docs.map((e) =>
        ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }
  
}