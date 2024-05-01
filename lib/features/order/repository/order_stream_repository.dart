import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/core/providers/firebase_provider.dart';
import 'package:luna_demo/model/booking_model.dart';

import '../../../main.dart';

final orderStreamRepositoryProvider =Provider((ref) => OrderStreamRepository(firestore: ref.watch(firestoreProvider)));

class OrderStreamRepository{
  final FirebaseFirestore _firestore;
  OrderStreamRepository ({required FirebaseFirestore firestore}):
        _firestore=firestore;

  CollectionReference get _orderStream =>_firestore.collection("bookings");

  Stream<List<BookingModel>> orderData( String usrId, String search){
    print(currentUserModel!.id);
    return search==""?_orderStream.where("userId",isEqualTo: usrId).snapshots().map((event) => event.docs.map((e) =>
    BookingModel.fromMap(e.data() as Map<String,dynamic>)).toList()):
    _orderStream.where("userId",isEqualTo: usrId).where('search',arrayContains: search).snapshots().map((event) => event.docs.map((e) =>
        BookingModel.fromMap(e.data() as Map<String,dynamic>)).toList());
  }

}