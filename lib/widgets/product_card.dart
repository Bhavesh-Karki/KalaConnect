import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/product.dart';
import '../screens/product_detail_screen.dart';
import '../utils/formatters.dart';
import 'product_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.controller});

  final Product product;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final artisan = artisanById(product.artisanId);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              product: product,
              controller: controller,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(child: ProductImage(product: product)),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: ListenableBuilder(
                        listenable: controller,
                        builder: (context, _) => IconButton.filledTonal(
                          tooltip: controller.isFavorite(product.id)
                              ? 'Remove favourite'
                              : 'Save favourite',
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              controller.isFavorite(product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              key: ValueKey(controller.isFavorite(product.id)),
                              color: terracotta,
                            ),
                          ),
                          onPressed: () => controller.toggleFavorite(product.id),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '${product.category} • ${artisan.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 6),
              Text(
                rupees(product.price),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: teal,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
