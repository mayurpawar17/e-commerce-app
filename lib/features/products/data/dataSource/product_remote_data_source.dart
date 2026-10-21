import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/network/api_client.dart';
import 'package:e_commerce_app/features/products/data/models/product_model.dart';

import '../../../../core/network/api_constants.dart';
import '../../domain/entity/product.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Exception, List<Product>>> getAllProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiClient _apiClient;
  ProductRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<Exception, List<Product>>> getAllProducts() async {
    try {
      final response = await _apiClient.dio.get(ApiConstants.getAllProducts);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<ProductModel> products = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        return Right(products);
      } else {
        return Left(Exception('Failed to load posts'));
      }

      //     await apiClient.dio.get('/posts').then((response) {
      //   if (response.statusCode == 200) {
      //     final List<dynamic> data = response.data;
      //     final List<PostModel> posts = data
      //         .map((json) => PostModel.fromJson(json))
      //         .toList();
      //     return Right(posts);
      //   } else {
      //     return Left(Exception('Failed to load posts'));
      //   }
      // });
    } catch (e) {
      return Left(Exception('Failed to load products: $e'));
    }
  }
}
