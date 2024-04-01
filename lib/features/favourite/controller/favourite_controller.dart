import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/favourite/repository/favourite_repository.dart';
import 'package:luna_demo/features/home/repository/stream_repository.dart';
import 'package:luna_demo/model/product_Model.dart';
import 'package:luna_demo/model/user_Model.dart';



final datafavstreamProvider = StreamProvider((ref) => ref.watch(StreamFavControllerProvider.notifier).userfavstream());

final productfavstreamProvider =StreamProvider.autoDispose.family((ref,dataFavIndex) => ref.watch(StreamFavControllerProvider.notifier).productfavstream(dataFavIndex: dataFavIndex));


final StreamFavControllerProvider = StateNotifierProvider((ref) => StreamFavControllerNotifier(streamfavrepository: ref.watch(streamFavRepositoryProvider)));


class StreamFavControllerNotifier extends StateNotifier{
  final StreamFavRepository _streamfavrepository;
  StreamFavControllerNotifier({required StreamFavRepository streamfavrepository }) :_streamfavrepository = streamfavrepository, super(null);


  Stream userfavstream(){
    return _streamfavrepository.favouriteDataStream();
  }

  Stream productfavstream({dataFavIndex}){
    return _streamfavrepository.favouriteProductStream(dataFavIndex);
  }

}