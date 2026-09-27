import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/artisan.dart';
import '../screens/artisan_detail_screen.dart';
import 'artisan_avatar.dart';

class ArtisanCard extends StatelessWidget {
  const ArtisanCard({super.key, required this.artisan, required this.controller});

  final Artisan artisan;
  final AppController controller;

  @override
  Widget build(BuildContext context) {
    final craft = craftById(artisan.craftId);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArtisanDetailScreen(
              artisan: artisan,
              controller: controller,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ArtisanAvatar(artisan: artisan),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          artisan.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Chip(
                          label: Text('Profile'),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                    Text('${artisan.location} • ${craft.title}'),
                    Text(artisan.experience),
                    const SizedBox(height: 8),
                    Text(artisan.introduction),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
