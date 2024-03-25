import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/bookings/repository/bookig_repository.dart';
import 'package:luna_demo/model/booking_model.dart';

final bookingContollerProvider=Provider((ref) => BookingController(bookingRepository: ref.watch(bookingRepositoryProvider)));

class BookingController{
  final BookingRepository _bookingRepository;
  BookingController({
    required bookingRepository
}):_bookingRepository=bookingRepository;

  AddBooking(BookingModel bookingModel){
    _bookingRepository.addBooking(bookingModel);
  }
}