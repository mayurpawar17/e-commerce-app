import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/network/api_client.dart';
import 'package:e_commerce_app/features/product/data/models/product_model.dart';

import '../../../../core/app/api_constants.dart';
import '../../domain/entity/product_entity.dart';
import 'package:e_commerce_app/core/utils/app_logger.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Exception, List<ProductEntity>>> getAllProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiClient _apiClient;

  ProductRemoteDataSourceImpl({required this._apiClient});

  @override
  Future<Either<Exception, List<ProductEntity>>> getAllProducts() async {
    const String tag = 'getAllProducts';
    try {
      final response = await _apiClient.dio.get(ApiConstants.getAllProducts);
      AppLogger.apiUrl(tag: tag, url: ApiConstants.getAllProducts);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<ProductModel> products = data
            .map((json) => ProductModel.fromJson(json))
            .toList();
        AppLogger.response(tag: tag, response: response.data.toString());

        return Right(products);
      } else {
        AppLogger.error('Failed to load posts', tag: tag);
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
      AppLogger.error('Failed to load posts ${e.toString()}', tag: tag);

      return Left(Exception('Failed to load product: $e'));
    }
  }
}
