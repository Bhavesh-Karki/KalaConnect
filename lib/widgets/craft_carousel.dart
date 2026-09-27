import 'dart:async';

import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../screens/craft_detail_screen.dart';
import 'craft_artwork.dart';

class _CarouselSlide {
  const _CarouselSlide({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.artworkKind,
    this.craftId,
    this.productId,
  });

  final String title;
  final String subtitle;
  final String badge;
  final String artworkKind;
  final String? craftId;
  final String? productId;
}

class CraftCarousel extends StatefulWidget {
  const CraftCarousel({
    super.key,
    required this.controller,
    this.onSelectCategory,
  });

  final AppController controller;
  final ValueChanged<String>? onSelectCategory;

  @override
  State<CraftCarousel> createState() => _CraftCarouselState();
}

class _CraftCarouselState extends State<CraftCarousel> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  static const _slides = [
    _CarouselSlide(
      title: 'Discover artisans. Explore crafts. Preserve stories.',
      subtitle:
          'Browse handmade artisanal products with authentic maker profiles, craft origin stories, and favourites.',
      badge: 'Heritage Collection • KalaConnect',
      artworkKind: 'pottery',
      productId: 'p1',
      craftId: 'terracotta',
    ),
    _CarouselSlide(
      title: 'Terracotta & Ceramic Pottery',
      subtitle:
          'Hand-shaped alluvial clay vessels, vases & pierced lamps from master potters in Kochi & Bhuj.',
      badge: 'Earth & Fire • Kerala & Gujarat',
      artworkKind: 'vase',
      productId: 'p2',
      craftId: 'terracotta',
    ),
    _CarouselSlide(
      title: 'Bamboo & Cane Weaving',
      subtitle:
          'Eco-conscious storage baskets, lanterns & breakfast trays hand-split and woven in Assam & Jharkhand.',
      badge: 'Forest Weaves • Assam & Jharkhand',
      artworkKind: 'basket',
      productId: 'p9',
      craftId: 'bamboo',
    ),
    _CarouselSlide(
      title: 'Handloom & Khadi Textiles',
      subtitle:
          'Natural botanical dyes, pure cotton yarns & heirloom shuttle weaves from Coimbatore & Bishnupur.',
      badge: 'Loom Stories • Tamil Nadu & Bengal',
      artworkKind: 'textile',
      productId: 'p15',
      craftId: 'textiles',
    ),
    _CarouselSlide(
      title: 'Hand Wood Carving',
      subtitle:
          'Solid teak, sheesham & walnut platters and keepsake boxes hand-chiselled in Saharanpur.',
      badge: 'Carved Timber • Uttar Pradesh',
      artworkKind: 'tray',
      productId: 'p20',
      craftId: 'wood',
    ),
    _CarouselSlide(
      title: 'Bell Metal & Brass Foundry',
      subtitle:
          'Resonant oil diyas, hand-hammered urli bowls & temple chimes with reflective golden sheens.',
      badge: 'Acoustic Bronze • Odisha',
      artworkKind: 'lamp',
      productId: 'p24',
      craftId: 'metal',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.94);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      if (_pageController.hasClients) {
        final next = (_currentPage + 1) % _slides.length;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 550),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  String? _getImageUrlForSlide(_CarouselSlide slide) {
    if (slide.productId != null) {
      try {
        final product = productById(slide.productId!);
        if (product.imageUrl.isNotEmpty) return product.imageUrl;
      } catch (_) {}
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _startTimer();
            },
            itemBuilder: (context, index) {
              final slide = _slides[index];
              final imageUrl = _getImageUrlForSlide(slide);
              final hasValidUrl = imageUrl != null &&
                  (imageUrl.startsWith('http://') ||
                      imageUrl.startsWith('https://'));

              return GestureDetector(
                onTap: () {
                  if (slide.craftId != null) {
                    try {
                      final craft = craftById(slide.craftId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CraftDetailScreen(
                            craft: craft,
                            controller: widget.controller,
                          ),
                        ),
                      );
                    } catch (_) {}
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Background Photo with Fallback Illustration
                        if (hasValidUrl)
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                CraftArtwork(kind: slide.artworkKind),
                          )
                        else
                          CraftArtwork(kind: slide.artworkKind),

                        // Atmospheric Gradient Overlay
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.25),
                                Colors.black.withValues(alpha: 0.88),
                              ],
                            ),
                          ),
                        ),

                        // Slide Text & Content
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Badge Pill
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: ochre.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  slide.badge,
                                  style: const TextStyle(
                                    color: ink,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                slide.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black54,
                                      blurRadius: 4,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                slide.subtitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    slide.craftId != null
                                        ? 'Explore craft story'
                                        : 'Browse collection',
                                    style: const TextStyle(
                                      color: ochre,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 13,
                                    color: ochre,
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
          ),
        ),
        const SizedBox(height: 10),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (index) {
            final isActive = _currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 6,
              width: isActive ? 22 : 6,
              decoration: BoxDecoration(
                color: isActive ? teal : ochre.withValues(alpha: 0.38),
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}
