import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_loading_indicator.dart';
import '../bloc/product_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Products", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return CustomLoadingIndicator();
            }
            if (state is ProductSuccess) {
              return ListView.builder(
                itemCount: state.products.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  final theme = Theme.of(context);
                  final colors = theme.colorScheme;
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color: colors.outlineVariant.withValues(alpha: 0.5),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        context.push('/productDetails', extra: product);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product image
                            Container(
                              width: 110,
                              height: 120,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: colors.surfaceContainerHighest
                                    .withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Image.network(
                                product.image ?? '',
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_not_supported_outlined,
                                    color: colors.onSurfaceVariant,
                                    size: 32,
                                  );
                                },
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;

                                  return const CustomLoadingIndicator();
                                },
                              ),
                            ),


                            const SizedBox(width: 16),

                            // Product information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title ?? 'Untitled Product',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      height: 1.3,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Rating
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        product.rating?.rate.toString() ??
                                            'N/A',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (product.rating?.count != null) ...[
                                        const SizedBox(width: 6),
                                        Flexible(
                                          child: Text(
                                            '(${product.rating!.count} reviews)',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color:
                                              colors.onSurfaceVariant,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),

                                  const SizedBox(height: 14),

                                  // Price and navigation indicator
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.price == null
                                              ? 'Price unavailable'
                                              : '\$${product.price}',
                                          style: theme.textTheme.titleLarge
                                              ?.copyWith(
                                            color: colors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: colors.onSurfaceVariant,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (state is ProductFailure) {
              return const Center(child: Text('Failed to fetch products'));
            }

            return SizedBox.shrink();
          },
          listener: (context, state) {
            if (state is ProductFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to fetch products')),
              );
            }
          },
        ),
      ),
    );
  }
}
