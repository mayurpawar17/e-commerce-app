import 'package:e_commerce_app/core/network/api_client.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/domain/usecase/get_all_products_use_case.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/app_router.dart';
import 'features/products/data/dataSource/product_remote_data_source.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer = AppObserver();

  runApp(
    MultiRepositoryProvider(
      providers: [
        //api client
        RepositoryProvider(create: (context) => ApiClient()),

        //data sources
        RepositoryProvider(
          create: (context) =>
              ProductRemoteDataSourceImpl(context.read<ApiClient>()),
        ),

        //repositories
        RepositoryProvider(
          create: (context) => ProductRepositoryImpl(
            context.read<ProductRemoteDataSourceImpl>(),
          ),
        ),

        //usecaes
        RepositoryProvider(
          create: (context) =>
              GetAllProductsUseCase(context.read<ProductRepositoryImpl>()),
        ),
        // RepositoryProvider(
        //   create: (context) =>
        //       CreatePostUseCase(context.read<PostRepositoryImpl>()),
        // ),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              getAllProductsUseCase: context.read<GetAllProductsUseCase>(),
              // createPostUseCase: context.read<CreatePostUseCase>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.router,
    );
  }
}
