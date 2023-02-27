import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/category/category_model.dart';
import '../../repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _repository;
  CategoryBloc(this._repository) : super(CategoryInitial()) {
    on<GetCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final category = await _repository.getCategory();
        emit(CategoryLoaded(category: category));
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
  }
}
