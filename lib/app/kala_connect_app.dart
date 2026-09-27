import 'package:flutter/material.dart';

import '../screens/about_screen.dart';
import '../screens/artisans_screen.dart';
import '../screens/crafts_screen.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/saved_screen.dart';
import 'app_controller.dart';
import 'app_theme.dart';

/// Root widget for KalaConnect.
///
/// Demonstrates Unit 3.2 — Navigation with Named Routes:
///
/// Named routes are registered in [routes]. Screens are launched with:
///   Navigator.pushNamed(context, AppRoutes.saved)
/// and dismissed with:
///   Navigator.pop(context)
///
/// [onGenerateRoute] handles routes that require runtime arguments
/// (e.g. product id, artisan id) passed via [RouteSettings.arguments].
class KalaConnectApp extends StatelessWidget {
  const KalaConnectApp({super.key, required this.controller});

  final AppController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalaConnect',
      debugShowCheckedModeBanner: false,
      theme: buildKalaTheme(),

      // ── Named Routes (Unit 3.2) ──────────────────────────────────────────
      // Initial route — the first screen shown when the app launches.
      initialRoute: AppRoutes.home,

      // Static named-route table.
      // Navigator.pushNamed(context, '/saved') pushes SavedScreen.
      // Navigator.pop(context) pops it back to the previous screen.
      routes: {
        AppRoutes.home: (_) => HomeScreen(controller: controller),
        AppRoutes.explore: (_) => ExploreScreen(controller: controller),
        AppRoutes.artisans: (_) => ArtisansScreen(controller: controller),
        AppRoutes.crafts: (_) => CraftsScreen(controller: controller),
        AppRoutes.saved: (_) => SavedScreen(
              controller: controller,
              onBrowseProducts: () {},
            ),
        AppRoutes.about: (_) => const AboutScreen(),
      },

      // onGenerateRoute handles routes not listed in [routes] above,
      // or routes that need runtime arguments (e.g. product / artisan detail).
      onGenerateRoute: (settings) {
        // Fallback — unknown route shows a simple error screen.
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Page not found')),
            body: Center(child: Text('No route for "${settings.name}"')),
          ),
        );
      },
    );
  }
}

/// Centralised named-route constants for KalaConnect.
///
/// Use these instead of raw strings to prevent typo bugs:
///   Navigator.pushNamed(context, AppRoutes.saved);
abstract final class AppRoutes {
  static const home = '/';
  static const explore = '/explore';
  static const artisans = '/artisans';
  static const crafts = '/crafts';
  static const saved = '/saved';
  static const about = '/about';
}
