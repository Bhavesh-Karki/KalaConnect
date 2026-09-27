import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../widgets/common_widgets.dart';
import '../widgets/craft_artwork.dart';
import 'craft_detail_screen.dart';

class CraftsScreen extends StatelessWidget {
  const CraftsScreen({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Craft Library',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Introductory notes for the demo catalogue.'),
          const SizedBox(height: 16),
          ...crafts.map(
            (craft) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CraftDetailScreen(
                        craft: craft,
                        controller: controller,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 96,
                          height: 88,
                          child: CraftArtwork(kind: craft.artworkKind),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                craft.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(craft.region),
                              const SizedBox(height: 6),
                              Text(craft.introduction),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
