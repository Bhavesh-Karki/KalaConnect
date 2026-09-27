import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/artisan.dart';
import '../widgets/artisan_avatar.dart';
import '../widgets/common_widgets.dart';
import '../widgets/product_grid.dart';
import 'craft_detail_screen.dart';

class ArtisanDetailScreen extends StatelessWidget {
  const ArtisanDetailScreen({
    super.key,
    required this.artisan,
    required this.controller,
  });

  final Artisan artisan;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final craft = craftById(artisan.craftId);
    final artisanProducts =
        products.where((product) => product.artisanId == artisan.id).toList();
    return Scaffold(
      appBar: AppBar(title: Text(artisan.name)),
      body: PageShell(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                ArtisanAvatar(artisan: artisan, radius: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        artisan.name,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text('${artisan.location} • ${artisan.experience}'),
                      const SizedBox(height: 6),
                      const Chip(label: Text('Profile')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(artisan.story),
            const SizedBox(height: 16),
            LinkedPanel(
              icon: Icons.menu_book_outlined,
              title: craft.title,
              subtitle: craft.introduction,
              action: 'Open craft page',
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
            const SizedBox(height: 20),
            Text('Products by ${artisan.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ProductGrid(products: artisanProducts, controller: controller),
          ],
        ),
      ),
    );
  }
}
