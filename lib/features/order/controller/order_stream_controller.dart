  import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/order/repository/order_stream_repository.dart';
import 'package:luna_demo/model/booking_model.dart';


final orderStreamControllerProvider =ChangeNotifierProvider((ref) => OrderStreamController(bookingStreamRepository: ref.watch(orderStreamRepositoryProvider)));

final orderDataStreamProvider =StreamProvider.autoDispose.family((ref,String jsonData) => ref.watch(orderStreamControllerProvider).bookingstream( jsonData));

class OrderStreamController extends ChangeNotifier{
  final OrderStreamRepository _orderStreamRepository;

  OrderStreamController({required OrderStreamRepository bookingStreamRepository}):
        _orderStreamRepository = bookingStreamRepository;

  Stream<List<BookingModel>> bookingstream(jsonData){
    Map<String,dynamic> data = jsonDecode(jsonData);
    return _orderStreamRepository.orderData(data["usrId"],data["search"],);
  }
}