part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  GetProductEvent({this.page});
  final int? page;
}

class GetProductByNameEvent extends ProductEvent {
  GetProductByNameEvent({this.page, this.productName});
  final int? page;
  final String? productName;
}
