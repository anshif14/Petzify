import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/features/favourite/screen/favourite.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';


final streamFavRepositoryProvider = Provider((ref) => StreamRepository(firestore: ref.watch(firestoreProvider)));

class StreamRepository{
  final FirebaseFirestore _firestore;
  StreamRepository({required FirebaseFirestore firestore}):
        _firestore = firestore;

  CollectionReference get _favourite => _firestore.collection('users');

  favouriteDataStream(index){
    return _favourite.doc(currentUserModel?.favourites[index]).snapshots().toList();
  }
  // streamData(){
  //   return _stream.snapshots().map((event) => event.docs.map((e) =>
  //       ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  // }



}