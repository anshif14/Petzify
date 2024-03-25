import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/bookings/repository/bookig_repository.dart';

final bookingContollerProvider=Provider((ref) => BookingController(bookingRepository: ref.watch(bookingRepositoryProvider)));

class BookingController{
  final BookingRepository _bookingRepository;
  BookingController({
    required bookingRepository
}):_bookingRepository=bookingRepository;

  AddBookings(productName, price, qty, buyerName, buyerAddress, buyerPhoneNumer){
    _bookingRepository.AddBookings(productName, price, qty, buyerName, buyerAddress, buyerPhoneNumer);
  }
}