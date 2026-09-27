import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/product.dart';
import '../utils/formatters.dart';
import '../widgets/artisan_avatar.dart';
import '../widgets/common_widgets.dart';
import '../widgets/product_image.dart';
import 'artisan_detail_screen.dart';
import 'craft_detail_screen.dart';
import 'enquiry_form_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.controller,
  });

  final Product product;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final artisan = artisanById(product.artisanId);
    final craft = craftById(product.craftId);
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: PageShell(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 280, child: ProductImage(product: product)),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text('${product.category} • Illustrative price ${rupees(product.price)}'),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.materials
                  .map((material) => Chip(label: Text(material)))
                  .toList(),
            ),
            const SizedBox(height: 16),
            InfoCard(
              title: 'Specifications',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(label: 'Dimensions', value: product.dimensions),
                  InfoRow(label: 'Estimated making time', value: product.makingTime),
                ],
              ),
            ),
            const SizedBox(height: 12),
            LinkedPanel(
              icon: Icons.person_outline,
              title: artisan.name,
              subtitle: '${artisan.location} • ${artisan.experience}',
              action: 'View artisan',
              leading: ArtisanAvatar(artisan: artisan),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArtisanDetailScreen(
                    artisan: artisan,
                    controller: controller,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            LinkedPanel(
              icon: Icons.menu_book_outlined,
              title: craft.title,
              subtitle: craft.introduction,
              action: 'Learn craft',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CraftDetailScreen(
                    craft: craft,
                    controller: controller,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: controller,
              builder: (context, _) => FilledButton.icon(
                icon: Icon(
                  controller.isFavorite(product.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  controller.isFavorite(product.id)
                      ? 'Remove from favourites'
                      : 'Save favourite',
                ),
                onPressed: () => controller.toggleFavorite(product.id),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.tonalIcon(
              icon: const Icon(Icons.edit_note),
              label: const Text('Create custom enquiry'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EnquiryFormScreen(
                    controller: controller,
                    product: product,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const DemoNotice(
              text:
                  'Catalogue products and prices are sample data for a local student prototype. Product photos are presentation images; no inventory, delivery, rating, or transaction is implied.',
            ),
          ],
        ),
      ),
    );
  }
}
