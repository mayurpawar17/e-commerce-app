import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/use_case.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/usecase/get_all_products_use_case.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  ProductBloc({required this.getAllProductsUseCase}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      emit(ProductLoading(products: state.products));

      final result = await getAllProductsUseCase(NoParams());
      result.fold(
        (failure) => emit(
          ProductFailure(products: state.products, message: failure.toString()),
        ),
        (products) => emit(ProductSuccess(products: products)),
      );
    });
  }
}
