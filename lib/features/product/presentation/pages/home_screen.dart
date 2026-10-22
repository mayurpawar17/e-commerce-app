import 'package:e_commerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FB),
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.forum_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 21,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Products',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            );
          } else if (state is ProductFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 42,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Error: ${state.message}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductSuccess) {
            final products = state.products;
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.image ?? ""),
                  ),
                  title: Text(product.title ?? ""),
                  subtitle: Text(product.description ?? ""),
                );

                // return Card(
                //   margin: const EdgeInsets.only(bottom: 12),
                //   color: Colors.white,
                //   elevation: 0,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(18),
                //     side: const BorderSide(color: Color(0xFFE9EDF4)),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(18),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Container(
                //           width: 42,
                //           height: 42,
                //           decoration: BoxDecoration(
                //             color: Theme.of(
                //               context,
                //             ).colorScheme.primary.withValues(alpha: 0.1),
                //             borderRadius: BorderRadius.circular(14),
                //           ),
                //           child: Image.network(
                //             post.image ?? '',
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //         const SizedBox(width: 14),
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 post.title ?? '',
                //                 style: Theme.of(context).textTheme.titleMedium
                //                     ?.copyWith(fontWeight: FontWeight.w700),
                //               ),
                //               const SizedBox(height: 7),
                //               Text(
                //                 post.description ?? '',
                //                 style: Theme.of(context).textTheme.bodyMedium
                //                     ?.copyWith(
                //                       color: const Color(0xFF687386),
                //                       height: 1.45,
                //                     ),
                //               ),
                //
                //               const SizedBox(height: 7),
                //               Text(
                //                 "Price: ${post.price}",
                //                 style: Theme.of(context).textTheme.bodyMedium
                //                     ?.copyWith(
                //                       color: const Color(0xFF687386),
                //                       height: 1.45,
                //                     ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            );
          }
          return Center(
            child: FilledButton.icon(
              onPressed: () {
                context.read<ProductBloc>().add(FetchProducts());
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Load Posts'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/createPost'),
        tooltip: 'Create post',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
