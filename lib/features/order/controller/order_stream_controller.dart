import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/order/repository/order_stream_repository.dart';


final orderStreamControllerProvider =Provider((ref) =>
    OrderStreamController(bookingStreamRepository: ref.watch(orderStreamRepositoryProvider)));

final orderDataProvider =StreamProvider((ref) => ref.watch(orderStreamControllerProvider).bookingstream());
class OrderStreamController{
  final OrderStreamRepository _orderStreamRepository;

  OrderStreamController({required OrderStreamRepository bookingStreamRepository}):
        _orderStreamRepository = bookingStreamRepository;

  Stream bookingstream(){
    return _orderStreamRepository.orderdata();
  }
}