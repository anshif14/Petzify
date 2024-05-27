import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/bookings/repository/bookig_repository.dart';


final bookingContollerProvider=StateNotifierProvider((ref) => BookingControllerNotifier(bookingRepository: ref.watch(bookingRepositoryProvider)));
final addBookingProvider= StateProvider.autoDispose.family((ref,bookingdata) =>  ref.watch(bookingContollerProvider.notifier).addBooking(bookingdata: bookingdata));
final SingleProductStreamProvider= StreamProvider.autoDispose.family((ref,productid) => ref.watch(bookingContollerProvider.notifier).SingleProductStream(productid: productid));
final bookingcontprovid=Provider((ref) => BookingControllerNotifier(bookingRepository: ref.watch(bookingRepositoryProvider)));
class BookingControllerNotifier extends StateNotifier{
  final BookingRepository _bookingRepository;
  BookingControllerNotifier({
    required bookingRepository
}):_bookingRepository=bookingRepository,super(null);

  addBooking({bookingdata}) {
    return _bookingRepository.addBooking(bookingdata);
  }
  // bookingfun(List booking){
  //   _bookingRepository.bookingfun(booking);
  // }
  Stream SingleProductStream({productid}){
      return _bookingRepository.singleProductStream(productid);
    }

}