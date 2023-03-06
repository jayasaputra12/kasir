import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasir/repositories/product/product_repository.dart';

import '../../model/product/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository _repository;
  ProductBloc(this._repository) : super(ProductInitial()) {
    on<GetProductByNameEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final product =
            await _repository.getProductbyName(productName: event.productName, page: event.page);
        emit(ProductLoaded(product: product));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
