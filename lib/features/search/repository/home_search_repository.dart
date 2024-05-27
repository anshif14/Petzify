
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';

import 'package:luna_demo/model/product_Model.dart';


final homeSearchRepositoryProvider = Provider((ref) => HomeSearchRepository(firestore: ref.watch(firestoreProvider)));

class HomeSearchRepository{
  final FirebaseFirestore _firestore;
  HomeSearchRepository({required FirebaseFirestore firestore}):
        _firestore = firestore;

  CollectionReference get _stream => _firestore.collection('product');



  searchData(String search){
    return _stream.where("search",arrayContains: search).snapshots().map((event) => event.docs.map((e) =>
        ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }


}