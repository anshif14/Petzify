import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:luna_demo/features/petcategory/repository/categoryRepository.dart';

final CategoryStreamControllerProvider= StateNotifierProvider((ref) => CategoryStreamControllerNotifier(categoryStreamRepository: ref.watch(CategoryStreamRepositoryProvider)));

final CategoryStreamProvider = StreamProvider.autoDispose.family((ref,category) => ref.watch(CategoryStreamControllerProvider.notifier).CategoryStream(category));

class CategoryStreamControllerNotifier extends StateNotifier{
  final CategoryStreamRepository _categoryStreamRepository;

  CategoryStreamControllerNotifier({required CategoryStreamRepository categoryStreamRepository}):_categoryStreamRepository=categoryStreamRepository, super(null);

  Stream CategoryStream(category){
    return _categoryStreamRepository.CategoryStream(category);
  }
}