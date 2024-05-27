
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';

import 'package:luna_demo/model/product_Model.dart';


final streamRepositoryProvider = Provider((ref) => Streamrepository(firestore: ref.watch(firestoreProvider)));

class Streamrepository{
  final FirebaseFirestore _firestore;
  Streamrepository({required FirebaseFirestore firestore}):
      _firestore = firestore;

  CollectionReference get _stream => _firestore.collection('product');


  CollectionReference get _banner => _firestore.collection('banner');


  streamData(){
    return _stream.snapshots().map((event) => event.docs.map((e) =>
    ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

  streamBanner(){
    return _banner.doc("images").snapshots();
  }



}