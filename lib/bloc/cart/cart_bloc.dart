import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kasir/model/cart/get_cart_model.dart';
import 'package:kasir/repositories/cart/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository _repository;
  CartBloc(this._repository) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        GetCartModel getCartModel =
            await _repository.getCart(transaksiId: event.transaksiId);
        emit(CartLoaded(getCartModel: getCartModel));
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
