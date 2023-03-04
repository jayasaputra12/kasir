part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final GetCartModel getCartModel;

  CartLoaded({required this.getCartModel});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
