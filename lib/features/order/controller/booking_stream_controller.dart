import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/order/repository/booking_stream_repository.dart';


final bookingStreamControllerProvider =Provider((ref) =>
    BookingStreamController(bookingStreamRepository: ref.watch(bookingStreamRepositoryProvider)));

final bookingDataProvider =StreamProvider((ref) => ref.watch(bookingStreamControllerProvider).bookingstream());
class BookingStreamController{
  final BookingStreamRepository _bookingStreamRepository;

  BookingStreamController({required BookingStreamRepository bookingStreamRepository}):
        _bookingStreamRepository = bookingStreamRepository;

  Stream bookingstream(){
    return _bookingStreamRepository.bookingdata();
  }
}