import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/model/product_Model.dart';

import '../../../core/providers/firebase_provider.dart';
import '../../bookings/repository/bookig_repository.dart';

final exploreRepositoryProvider=Provider((ref)=>ExploreRepository(firestore:ref.watch(firestoreProvider)));


class ExploreRepository{
  final FirebaseFirestore _firestore;
  ExploreRepository({ required FirebaseFirestore firestore }):
      _firestore = firestore;

  CollectionReference get _explore => _firestore.collection('product');

  addProduct(ProductModel productData){
    _explore.add(productData.toMap()).then((value) {
      value.update(productData.copyWith(id: value.id).toMap());
    },);
  }

}