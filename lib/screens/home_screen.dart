import 'package:flutter/material.dart';

import '../app/app_controller.dart';
import 'about_screen.dart';
import 'artisans_screen.dart';
import 'crafts_screen.dart';
import 'explore_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final AppController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ExploreScreen(controller: widget.controller),
      ArtisansScreen(controller: widget.controller),
      CraftsScreen(controller: widget.controller),
      SavedScreen(
        controller: widget.controller,
        onBrowseProducts: () => setState(() => _index = 0),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/KalaConnect-transparentIcon.png',
              height: 32,
              width: 32,
              errorBuilder: (_, _, _) => const Icon(Icons.handshake_outlined),
            ),
            const SizedBox(width: 10),
            Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 22,
                  letterSpacing: 0.2,
                ),
                children: [
                  TextSpan(
                    text: 'Kala',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const TextSpan(
                    text: 'Connect',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFE58E47),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'About KalaConnect',
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AboutScreen()),
            ),
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) => setState(() => _index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Artisans',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Crafts',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            selectedIcon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
        ],
      ),
    );
  }
}
