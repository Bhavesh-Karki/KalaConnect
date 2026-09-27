import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app_controller.dart';
import 'app/kala_connect_app.dart';
import 'app/local_storage_service.dart';

// Exports for backward compatibility and testing
export 'app/app_colors.dart';
export 'app/app_controller.dart';
export 'app/app_theme.dart';
export 'app/database_helper.dart';
export 'app/kala_connect_app.dart';
export 'app/local_storage_service.dart';
export 'data/seed_data.dart';
export 'models/artisan.dart';
export 'models/craft.dart';
export 'models/enquiry.dart';
export 'models/product.dart';
export 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalStorageService(await SharedPreferences.getInstance());
  final controller = AppController(storage);
  await controller.load();
  runApp(KalaConnectApp(controller: controller));
}
