import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/home/repository/stream_repository.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';

final StreamFavControllerProvider = Provider((ref) => StreamController(streamrepository: ref.watch(streamRepositoryProvider)));

final datafavstreamProvider = StreamProvider((ref) => ref.watch(StreamFavControllerProvider).productfavstream());


class StreamController{
  final Streamrepository _streamrepository;


  StreamController({required Streamrepository streamrepository }):
        _streamrepository = streamrepository;


  Stream<List<userModel>> productfavstream(){
    return _streamrepository.streamData();
  }
}