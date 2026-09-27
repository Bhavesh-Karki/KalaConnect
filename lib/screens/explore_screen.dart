import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/product.dart';
import '../widgets/common_widgets.dart';
import '../widgets/craft_carousel.dart';
import '../widgets/product_grid.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.controller});

  final AppController controller;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _searchController = TextEditingController();
  String _category = 'All';
  String _subCategory = 'All';
  String _region = 'Any region';
  String _priceBand = 'Any price';
  String _makingTime = 'Any duration';
  String _material = 'Any material';
  String _artisan = 'Any artisan';
  String _sort = 'Featured';

  List<String> get _categories => [
        'All',
        ...{for (final product in products) product.category},
      ];

  List<String> get _subCategories {
    final relevant = _category == 'All'
        ? products
        : products.where((p) => p.category == _category);
    final subs = {
      for (final p in relevant)
        if (p.subCategory.isNotEmpty) p.subCategory,
    };
    return ['All', ...subs];
  }

  List<String> get _regions {
    final set = <String>{};
    for (final artisan in artisans) {
      final parts = artisan.location.split(',');
      if (parts.length > 1) {
        set.add(parts.last.trim());
      } else {
        set.add(artisan.location.trim());
      }
    }
    final sorted = set.toList()..sort();
    return ['Any region', ...sorted];
  }

  List<String> get _materials => [
        'Any material',
        ...{
          for (final product in products)
            for (final material in product.materials) material,
        },
      ];

  bool get _hasActiveFilters =>
      _category != 'All' ||
      _subCategory != 'All' ||
      _region != 'Any region' ||
      _priceBand != 'Any price' ||
      _makingTime != 'Any duration' ||
      _material != 'Any material' ||
      _artisan != 'Any artisan' ||
      _searchController.text.trim().isNotEmpty;

  List<Product> get _filteredProducts {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = products.where((product) {
      final artisan = artisanById(product.artisanId);
      final craft = craftById(product.craftId);
      final searchable =
          '${product.name} ${product.category} ${product.subCategory} ${artisan.name} ${artisan.location} ${craft.title} ${product.materials.join(' ')} ${product.description}'
              .toLowerCase();

      final matchesCategory =
          _category == 'All' || product.category == _category;

      final matchesSubCategory =
          _subCategory == 'All' || product.subCategory == _subCategory;

      final matchesRegion = _region == 'Any region' ||
          artisan.location.toLowerCase().contains(_region.toLowerCase());

      final matchesMaterial =
          _material == 'Any material' || product.materials.contains(_material);

      final matchesArtisan =
          _artisan == 'Any artisan' || artisan.name == _artisan;

      final matchesPrice = switch (_priceBand) {
        'Under ₹1000' => product.price < 1000,
        '₹1000 - ₹1800' => product.price >= 1000 && product.price <= 1800,
        '₹1800 - ₹2500' => product.price > 1800 && product.price <= 2500,
        'Above ₹2500' => product.price > 2500,
        _ => true,
      };

      final matchesTime = switch (_makingTime) {
        'Quick (1-2 days)' =>
          product.makingTime.contains('1') || product.makingTime.contains('2'),
        'Moderate (3-4 days)' =>
          product.makingTime.contains('3') || product.makingTime.contains('4'),
        'Intricate (5+ days)' =>
          product.makingTime.contains('5') || product.makingTime.contains('6'),
        _ => true,
      };

      return matchesCategory &&
          matchesSubCategory &&
          matchesRegion &&
          matchesMaterial &&
          matchesArtisan &&
          matchesPrice &&
          matchesTime &&
          (query.isEmpty || searchable.contains(query));
    }).toList();

    if (_sort == 'Price: Low to High') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sort == 'Price: High to Low') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sort == 'Name A-Z') {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    } else if (_sort == 'Quickest to craft') {
      filtered.sort((a, b) => a.makingTime.compareTo(b.makingTime));
    }
    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _category = 'All';
      _subCategory = 'All';
      _region = 'Any region';
      _priceBand = 'Any price';
      _makingTime = 'Any duration';
      _material = 'Any material';
      _artisan = 'Any artisan';
      _sort = 'Featured';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProducts;
    final subCategories = _subCategories;

    return PageShell(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CraftCarousel(
            controller: widget.controller,
            onSelectCategory: (cat) => setState(() {
              _category = cat;
              _subCategory = 'All';
            }),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              labelText: 'Search products, types, artisans, regions, or crafts',
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      tooltip: 'Clear search',
                      icon: const Icon(Icons.close),
                      onPressed: () => setState(_searchController.clear),
                    ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 14),

          // Primary Category Chips
          Row(
            children: [
              Text('Craft Category',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
              const Spacer(),
              if (_category != 'All')
                TextButton(
                  onPressed: () => setState(() {
                    _category = 'All';
                    _subCategory = 'All';
                  }),
                  style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                  child: const Text('View All Categories'),
                ),
            ],
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                final isSelected = _category == category;
                IconData icon;
                switch (category) {
                  case 'Pottery':
                    icon = Icons.local_florist_outlined;
                    break;
                  case 'Bamboo':
                    icon = Icons.shopping_basket_outlined;
                    break;
                  case 'Textiles':
                    icon = Icons.texture_outlined;
                    break;
                  case 'Wood':
                    icon = Icons.nature_people_outlined;
                    break;
                  case 'Metal':
                    icon = Icons.brightness_high_outlined;
                    break;
                  case 'Accessories':
                    icon = Icons.diamond_outlined;
                    break;
                  default:
                    icon = Icons.all_inclusive;
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    avatar: Icon(icon, size: 16, color: isSelected ? Colors.white : teal),
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (_) => setState(() {
                      _category = category;
                      _subCategory = 'All';
                    }),
                  ),
                );
              }).toList(),
            ),
          ),

          // Sub-category Filter Chips (e.g. for Pottery, Bamboo, etc.)
          if (subCategories.length > 1) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.tune, size: 16, color: ink.withValues(alpha: .7)),
                const SizedBox(width: 6),
                Text(
                  _category == 'All' ? 'Product Types' : '$_category Types & Styles',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 6),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: subCategories.map((sub) {
                  final isSelected = _subCategory == sub;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: ChoiceChip(
                      label: Text(sub == 'All' ? 'All ${(_category == "All" ? "Types" : _category)}' : sub),
                      selected: isSelected,
                      visualDensity: VisualDensity.compact,
                      onSelected: (selected) {
                        if (selected) setState(() => _subCategory = sub);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Filter Dropdowns (2 in a row on phone, 3-6 on wider screens)
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final columns = width < 600 ? 2 : (width < 900 ? 3 : 6);
              const spacing = 10.0;
              final itemWidth = (width - (spacing * (columns - 1))) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Price Range',
                    value: _priceBand,
                    values: const [
                      'Any price',
                      'Under ₹1000',
                      '₹1000 - ₹1800',
                      '₹1800 - ₹2500',
                      'Above ₹2500',
                    ],
                    onChanged: (value) => setState(() => _priceBand = value),
                  ),
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Region / State',
                    value: _region,
                    values: _regions,
                    onChanged: (value) => setState(() => _region = value),
                  ),
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Crafting Duration',
                    value: _makingTime,
                    values: const [
                      'Any duration',
                      'Quick (1-2 days)',
                      'Moderate (3-4 days)',
                      'Intricate (5+ days)',
                    ],
                    onChanged: (value) => setState(() => _makingTime = value),
                  ),
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Material',
                    value: _material,
                    values: _materials,
                    onChanged: (value) => setState(() => _material = value),
                  ),
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Artisan',
                    value: _artisan,
                    values: [
                      'Any artisan',
                      ...artisans.map((artisan) => artisan.name),
                    ],
                    onChanged: (value) => setState(() => _artisan = value),
                  ),
                  _FilterMenu(
                    width: itemWidth,
                    label: 'Sort By',
                    value: _sort,
                    values: const [
                      'Featured',
                      'Price: Low to High',
                      'Price: High to Low',
                      'Name A-Z',
                      'Quickest to craft',
                    ],
                    onChanged: (value) => setState(() => _sort = value),
                  ),
                ],
              );
            },
          ),

          // Active filter chips indicator
          if (_hasActiveFilters) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Active:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                if (_category != 'All')
                  InputChip(
                    label: Text('Category: $_category'),
                    onDeleted: () => setState(() {
                      _category = 'All';
                      _subCategory = 'All';
                    }),
                  ),
                if (_subCategory != 'All')
                  InputChip(
                    label: Text('Type: $_subCategory'),
                    onDeleted: () => setState(() => _subCategory = 'All'),
                  ),
                if (_region != 'Any region')
                  InputChip(
                    label: Text('Region: $_region'),
                    onDeleted: () => setState(() => _region = 'Any region'),
                  ),
                if (_priceBand != 'Any price')
                  InputChip(
                    label: Text('Price: $_priceBand'),
                    onDeleted: () => setState(() => _priceBand = 'Any price'),
                  ),
                if (_makingTime != 'Any duration')
                  InputChip(
                    label: Text('Duration: $_makingTime'),
                    onDeleted: () => setState(() => _makingTime = 'Any duration'),
                  ),
                if (_material != 'Any material')
                  InputChip(
                    label: Text('Material: $_material'),
                    onDeleted: () => setState(() => _material = 'Any material'),
                  ),
                if (_artisan != 'Any artisan')
                  InputChip(
                    label: Text('Artisan: $_artisan'),
                    onDeleted: () => setState(() => _artisan = 'Any artisan'),
                  ),
                TextButton(
                  onPressed: _resetFilters,
                  style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                  child: const Text('Reset all'),
                ),
              ],
            ),
          ],

          const SizedBox(height: 14),

          // Result counter
          Row(
            children: [
              Expanded(
                child: Text(
                  '${filtered.length} product${filtered.length == 1 ? '' : 's'} found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              if (_hasActiveFilters)
                TextButton.icon(
                  onPressed: _resetFilters,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset filters'),
                ),
            ],
          ),

          const SizedBox(height: 12),

          if (filtered.isEmpty)
            EmptyState(
              icon: Icons.search_off,
              title: 'No products match your filters',
              body: 'Try choosing another craft type, price band, region, or clearing some filters.',
              actionLabel: 'Reset all filters',
              onPressed: _resetFilters,
            )
          else
            ProductGrid(products: filtered, controller: widget.controller),
        ],
      ),
    );
  }
}

class _FilterMenu extends StatelessWidget {
  const _FilterMenu({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    this.width,
  });

  final String label;
  final String value;
  final List<String> values;
  final ValueChanged<String> onChanged;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 200,
      child: DropdownButtonFormField<String>(
        key: ValueKey('$label-$value'),
        initialValue: values.contains(value) ? value : values.first,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
        items: values
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}
