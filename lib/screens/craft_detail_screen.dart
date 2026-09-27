import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/craft.dart';
import '../widgets/artisan_avatar.dart';
import '../widgets/common_widgets.dart';
import '../widgets/craft_artwork.dart';
import '../widgets/product_grid.dart';
import 'artisan_detail_screen.dart';

class CraftDetailScreen extends StatelessWidget {
  const CraftDetailScreen({
    super.key,
    required this.craft,
    required this.controller,
  });

  final Craft craft;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final relatedProducts = products
        .where((product) => product.craftId == craft.id)
        .toList();
    final relatedArtisans = artisans
        .where((artisan) => artisan.craftId == craft.id)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(craft.title)),
      body: PageShell(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SizedBox(height: 220, child: CraftArtwork(kind: craft.artworkKind)),
            const SizedBox(height: 16),
            Text(
              craft.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(craft.region),
            const SizedBox(height: 16),
            Text(craft.article),
            const SizedBox(height: 16),
            InfoCard(title: 'Regional context', child: Text(craft.context)),
            const SizedBox(height: 12),
            InfoCard(
              title: 'Materials',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: craft.materials
                    .map((material) => Chip(label: Text(material)))
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            InfoCard(
              title: 'Making process',
              child: Column(
                children: [
                  for (var i = 0; i < craft.process.length; i++)
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 14,
                        backgroundColor: teal,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(craft.process[i]),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            InfoCard(
              title: 'Cultural significance',
              child: Text(craft.significance),
            ),
            const SizedBox(height: 12),
            InfoCard(title: 'Care guidance', child: Text(craft.care)),
            const SizedBox(height: 12),
            InfoCard(
              title: 'Associated artisans',
              child: Column(
                children: relatedArtisans
                    .map(
                      (artisan) => ListTile(
                        leading: ArtisanAvatar(artisan: artisan),
                        title: Text(artisan.name),
                        subtitle: Text(artisan.location),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ArtisanDetailScreen(
                              artisan: artisan,
                              controller: controller,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Related products',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ProductGrid(products: relatedProducts, controller: controller),
            const SizedBox(height: 12),
            const DemoNotice(
              text:
                  'Educational note: craft practices vary by artisan and region. This article is introductory demo content, not authoritative cultural documentation.',
            ),
          ],
        ),
      ),
    );
  }
}
