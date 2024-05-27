import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/petcategory/repository/categoryRepository.dart';

final CategoryStreamControllerProvider= StateNotifierProvider((ref) => CategoryStreamControllerNotifier(categoryStreamRepository: ref.watch(CategoryStreamRepositoryProvider)));

final CategoryStreamProvider = StreamProvider.autoDispose.family((ref,String jsonData ) => ref.watch(CategoryStreamControllerProvider.notifier).CategoryStream( jsonData));

class CategoryStreamControllerNotifier extends StateNotifier{
  final CategoryStreamRepository _categoryStreamRepository;

  CategoryStreamControllerNotifier({required CategoryStreamRepository categoryStreamRepository}):_categoryStreamRepository=categoryStreamRepository, super(null);

  Stream CategoryStream(jsonData){
    Map<String,dynamic> data = jsonDecode(jsonData);

    return _categoryStreamRepository.CategoryStream(data["category"] , data["search"]);
  }
}