import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/booking_model.dart';

import '../../../main.dart';

final bookingStreamRepositoryProvider =Provider((ref) => BookingStreamRepository(firestore: ref.watch(firestoreProvider)));

class BookingStreamRepository{
  final FirebaseFirestore _firestore;
  BookingStreamRepository ({required FirebaseFirestore firestore}):
        _firestore=firestore;

  CollectionReference get _bookingStream =>_firestore.collection("bookings");

  bookingdata(){
    return _bookingStream.where("userid",isEqualTo: currentUserModel!.id).snapshots().map((event) => event.docs.map((e) =>
    BookingModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

}