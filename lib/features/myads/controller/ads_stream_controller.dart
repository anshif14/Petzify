import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/myads/repository/ads_stream_repository.dart';

final adstreamControllerProvider=Provider((ref) => AdstreamController(adsStreamRepository: ref.watch(adsstreamRepositoryProvider)));
final adsStreamProvider=StreamProvider((ref) => ref.watch(adstreamControllerProvider).adsData());

class AdstreamController{
  final AdsStreamRepository _adsStreamRepository;

  AdstreamController({
    required AdsStreamRepository adsStreamRepository,
}):_adsStreamRepository=adsStreamRepository;

  Stream adsData(){
    return _adsStreamRepository.adsData();
  }

  updatedatasss(String remove){
    _adsStreamRepository.updatefun(remove);
  }
  // updatedata(String add){
  //   _adsStreamRepository.update(add);
  // }

}