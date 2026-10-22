import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/product/data/dataSource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/product/domain/entity/product_entity.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, List<ProductEntity>>> getAllProducts() {
    return remoteDataSource.getAllProducts();
  }
}
