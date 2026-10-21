part of 'product_bloc.dart';

@immutable
sealed class ProductState {
  final List<Product> products;
  ProductState({required this.products});
}

final class ProductInitial extends ProductState {
  ProductInitial() : super(products: []);
}

final class ProductLoading extends ProductState {
  ProductLoading({required super.products});
}

final class ProductSuccess extends ProductState {
  ProductSuccess({required super.products});
}

final class ProductFailure extends ProductState {
  final String message;

  ProductFailure({required super.products, required this.message});
}
