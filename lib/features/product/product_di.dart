


import 'package:e_commerce_app/core/network/api_client.dart';
import 'package:e_commerce_app/features/product/data/dataSource/product_remote_data_source.dart';
import 'package:e_commerce_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/product/domain/usecase/get_all_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> productRepositoryProvider = [
  //data source
  RepositoryProvider<ProductRemoteDataSource>(
    create: (context) =>
        ProductRemoteDataSourceImpl(apiClient: context.read<ApiClient>()),
  ),

  //repository
  RepositoryProvider<ProductRepository>(
    create: (context) =>
        ProductRepositoryImpl(context.read<ProductRemoteDataSource>()),
  ),

  //useCase
  RepositoryProvider<GetAllProductsUseCase>(
    create: (context) => GetAllProductsUseCase(context.read<ProductRepository>()),
  ),
];