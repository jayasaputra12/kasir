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
  final int totalBayar;  

  CartLoaded({required this.getCartModel, this.totalBayar = 0});
}

class CartTotalBayar extends CartState {
  final int totalBayar;

  CartTotalBayar({required this.totalBayar});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
