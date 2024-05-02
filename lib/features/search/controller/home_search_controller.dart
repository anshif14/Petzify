import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/home/repository/stream_repository.dart';

import '../repository/home_search_repository.dart';

final HomeSearchControllerProvider = StateNotifierProvider((ref) => HomeSearchControllerNotifier(HomeSearchRepository: ref.watch(homeSearchRepositoryProvider)));

final searchdatastreamProvider = StreamProvider.autoDispose.family((ref,search) => ref.watch(HomeSearchControllerProvider.notifier).Searchproductstream(search));



class HomeSearchControllerNotifier extends StateNotifier{
  final HomeSearchRepository _homeSearchRepository;

  HomeSearchControllerNotifier({required HomeSearchRepository HomeSearchRepository }):
        _homeSearchRepository = HomeSearchRepository, super(null);


  Stream Searchproductstream(search){
    return _homeSearchRepository.searchData(search);
  }

}