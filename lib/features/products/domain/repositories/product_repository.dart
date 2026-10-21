import 'package:dartz/dartz.dart';

import '../entity/product.dart';

abstract class ProductRepository {
  Future<Either<Exception, List<Product>>> getAllProducts();
}
