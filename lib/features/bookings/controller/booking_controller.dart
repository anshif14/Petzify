import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/bookings/repository/bookig_repository.dart';
import 'package:luna_demo/model/booking_model.dart';

final bookingContollerProvider=StateNotifierProvider((ref) => BookingControllerNotifier(bookingRepository: ref.watch(bookingRepositoryProvider)));
final addBookingProvider= StateProvider.autoDispose.family((ref,bookingdata) =>  ref.watch(bookingContollerProvider.notifier).addBooking(bookingdata: bookingdata));
final SingleProductStreamProvider= StreamProvider.autoDispose.family((ref,productid) => ref.watch(bookingContollerProvider.notifier).SingleProductStream(productid: productid));

class BookingControllerNotifier extends StateNotifier{
  final BookingRepository _bookingRepository;
  BookingControllerNotifier({
    required bookingRepository
}):_bookingRepository=bookingRepository,super(null);

  addBooking({bookingdata}) {
    return _bookingRepository.addBooking(bookingdata);
  }
  Stream SingleProductStream({productid}){
      return _bookingRepository.singleProductStream(productid);
    }

}