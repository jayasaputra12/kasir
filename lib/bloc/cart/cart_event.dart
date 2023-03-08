part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartEvent extends CartEvent {
  final int transaksiId;
  final int totalBayar;

  GetCartEvent({required this.transaksiId, this.totalBayar = 0});
}

class GetTotalBayarEvent extends CartEvent {
  final int totalBayar;

  GetTotalBayarEvent({ this.totalBayar = 0});
}
