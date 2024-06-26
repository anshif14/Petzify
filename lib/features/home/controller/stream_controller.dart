import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/home/repository/stream_repository.dart';

final StreamControllerProvider = Provider((ref) => StreamController(streamrepository: ref.watch(streamRepositoryProvider)));

final datastreamProvider = StreamProvider((ref) => ref.watch(StreamControllerProvider).productstream());

final databannerProvider = StreamProvider((ref) => ref.watch(StreamControllerProvider).bannerstream());


class StreamController{
  final Streamrepository _streamrepository;

  StreamController({required Streamrepository streamrepository }):
        _streamrepository = streamrepository;


 Stream productstream(){
    return _streamrepository.streamData();
  }

  Stream bannerstream(){
   return _streamrepository.streamBanner();
  }

}