import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../widgets/common_widgets.dart';
import '../widgets/enquiry_tile.dart';
import '../widgets/product_grid.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    super.key,
    required this.controller,
    required this.onBrowseProducts,
  });

  final AppController controller;
  final VoidCallback onBrowseProducts;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.favorite_border), text: 'Favourites'),
              Tab(icon: Icon(Icons.edit_note), text: 'Enquiries'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    final saved = products
                        .where(
                          (product) =>
                              controller.favoriteIds.contains(product.id),
                        )
                        .toList();
                    return PageShell(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          if (saved.isEmpty)
                            EmptyState(
                              icon: Icons.favorite_border,
                              title: 'No favourites yet',
                              body:
                                  'Save products from Explore or product details to see them here.',
                              actionLabel: 'Browse products',
                              onPressed: onBrowseProducts,
                            )
                          else
                            ProductGrid(
                              products: saved,
                              controller: controller,
                            ),
                        ],
                      ),
                    );
                  },
                ),
                ListenableBuilder(
                  listenable: controller,
                  builder: (context, _) {
                    return PageShell(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          if (controller.enquiries.isEmpty)
                            const EmptyState(
                              icon: Icons.edit_note,
                              title: 'No local enquiries',
                              body:
                                  'Open a product detail page and create a custom enquiry. It will only be saved on this device.',
                            )
                          else
                            ...controller.enquiries.map(
                              (enquiry) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: EnquiryTile(
                                  enquiry: enquiry,
                                  controller: controller,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
