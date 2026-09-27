import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../widgets/artisan_card.dart';
import '../widgets/common_widgets.dart';

class ArtisansScreen extends StatefulWidget {
  const ArtisansScreen({super.key, required this.controller});

  final AppController controller;

  @override
  State<ArtisansScreen> createState() => _ArtisansScreenState();
}

class _ArtisansScreenState extends State<ArtisansScreen> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _search.text.trim().toLowerCase();
    final visible = artisans.where((artisan) {
      final craft = craftById(artisan.craftId);
      return '${artisan.name} ${artisan.location} ${craft.title}'
          .toLowerCase()
          .contains(query);
    }).toList();
    return PageShell(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Artisan Directory', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          const Text('All profiles are fictional demo profiles for this student app.'),
          const SizedBox(height: 16),
          TextField(
            controller: _search,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search by name, location, or craft',
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 16),
          ...visible.map(
            (artisan) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ArtisanCard(
                artisan: artisan,
                controller: widget.controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
