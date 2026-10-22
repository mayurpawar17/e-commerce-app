part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FetchProductsEvent extends ProductEvent {}
