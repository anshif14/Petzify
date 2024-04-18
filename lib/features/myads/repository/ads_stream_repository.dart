import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/main.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

 final adsstreamRepositoryProvider=Provider((ref) => AdsStreamRepository(firestore: ref.watch(firestoreProvider)));
class AdsStreamRepository{
  final FirebaseFirestore _firestore;
  AdsStreamRepository({
    required FirebaseFirestore firestore
}):_firestore=firestore;
   CollectionReference get adStream=> _firestore.collection("product");
  CollectionReference get _delete => _firestore.collection('users');


   adsData(){
     var data =  adStream.where("userid",isEqualTo: currentUserModel!.id).snapshots().map((event) => event.docs.map((e) =>
         ProductModel.fromMap(e.data() as Map<String,dynamic>)).toList());

     return data;
   }
  // updatefun(String remove){
  //   _delete.doc(currentUserModel!.id).update(currentUserModel!.copyWith(productadder: remove).toMap());
  // }

  // update(String add){
  //   UserModel? usermodel;
  //   _delete.doc(currentUserModel!.id).update(usermodel!.copyWith(productadder: add).toMap());
  // }


}