import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/favourite/repository/favourite_repository.dart';




final datafavstreamProvider = StreamProvider.family((ref,String id) => ref.watch(StreamFavControllerProvider.notifier).userfavstream(id));

final productfavstreamProvider =StreamProvider.autoDispose.family((ref,dataFavIndex) => ref.watch(StreamFavControllerProvider.notifier).productfavstream(dataFavIndex: dataFavIndex));


final StreamFavControllerProvider = StateNotifierProvider((ref) => StreamFavControllerNotifier(streamfavrepository: ref.watch(streamFavRepositoryProvider)));


class StreamFavControllerNotifier extends StateNotifier{
  final StreamFavRepository _streamfavrepository;
  StreamFavControllerNotifier({required StreamFavRepository streamfavrepository }) :_streamfavrepository = streamfavrepository, super(null);


  Stream userfavstream(String id){
    return _streamfavrepository.favouriteDataStream(id);
  }

  Stream productfavstream({dataFavIndex}){
    return _streamfavrepository.favouriteProductStream(dataFavIndex);
  }

}