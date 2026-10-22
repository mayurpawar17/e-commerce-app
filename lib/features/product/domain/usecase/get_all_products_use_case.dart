import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/usecase/use_case.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';

import '../entity/product_entity.dart';

class GetAllProductsUseCase extends UseCase<List<ProductEntity>, NoParams> {
  final ProductRepository _postRepository;

  GetAllProductsUseCase(this._postRepository);

  @override
  Future<Either<Exception, List<ProductEntity>>> call(NoParams params) async {
    return await _postRepository.getAllProducts();
  }
}
