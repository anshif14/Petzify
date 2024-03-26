import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/explore/repository/explore_repository.dart';
import 'package:luna_demo/model/product_Model.dart';

final exploreControllerProvider=Provider((ref) => exploreController(exploreRepository: ref.watch(exploreRepositoryProvider)));

class exploreController{
  final ExploreRepository _exploreRepository;

exploreController({required exploreRepository}):
      _exploreRepository = exploreRepository;

addingProduct(ProductModel productModel){
  _exploreRepository.addProduct(productModel);
}

}