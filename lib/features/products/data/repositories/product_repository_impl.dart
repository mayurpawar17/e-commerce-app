import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/products/data/dataSource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/products/domain/entity/product.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<Product>>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }
}
