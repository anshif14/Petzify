import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/booking_model.dart';
import 'package:luna_demo/model/product_Model.dart';

import '../../../main.dart';
final bookingRepositoryProvider=Provider((ref)=>BookingRepository(firestore:ref.watch(firestoreProvider)));

class BookingRepository{
  final FirebaseFirestore _firestore;
  BookingRepository({required FirebaseFirestore firestore}):_firestore=firestore;

  CollectionReference get _booking=> _firestore.collection("bookings");
  CollectionReference get _product=> _firestore.collection("product");
  CollectionReference get _book=> _firestore.collection("users");

  addBooking(BookingModel bookingdata){
    _booking.add(bookingdata.toMap()).then((value) {
      List? newBooking = currentUserModel?.booking;
      newBooking?.add(value.id);

      value.update(bookingdata.copyWith(bookingId: value.id).toMap());
      /// FirebaseFirestore.instance.collection('users')
      _book.doc(currentUserModel!.id).update(
        currentUserModel!.copyWith(booking: newBooking, bookingCount: newBooking?.length,pendingorder: ++currentUserModel?.pendingorder).toMap()
          );
    },);
    // functionBook(){
    //
    // }
  }
  Stream<ProductModel> singleProductStream(productid){
   return  _product.doc(productid).snapshots().map((event) {
      return ProductModel.fromMap(event.data() as Map<String,dynamic>);
    });
  }
  // bookingfun(List booking){
  //   _book.doc(currentUserModel!.id).update(currentUserModel!.copyWith(booking: booking).toMap());
  // }
  // singleProductStream(productid){
  //   _product.doc(productid).snapshots().map((event) {
  //     return ProductModel.fromMap(event.data() as Map<String,dynamic>);
  //   });
  // }

}