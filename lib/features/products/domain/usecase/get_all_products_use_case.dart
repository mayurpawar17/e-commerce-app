import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/usecase/use_case.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

import '../entity/product.dart';

class GetAllProductsUseCase extends UseCase<List<Product>, NoParams> {
  final ProductRepository _postRepository;
  GetAllProductsUseCase(this._postRepository);

  @override
  Future<Either<Exception, List<Product>>> call(NoParams params) async {
    return await _postRepository.getAllProducts();
  }
}
