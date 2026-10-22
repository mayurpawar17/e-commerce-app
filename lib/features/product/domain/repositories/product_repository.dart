import 'package:dartz/dartz.dart';

import '../entity/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Exception, List<ProductEntity>>> getAllProducts();
}
