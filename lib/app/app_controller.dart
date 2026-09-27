import 'package:flutter/foundation.dart';

import '../models/enquiry.dart';
import 'database_helper.dart';
import 'local_storage_service.dart';

/// Central state manager for KalaConnect.
///
/// Demonstrates Unit 3.2 — State Management via [ChangeNotifier].
///
/// Storage strategy (platform-conditional):
///  - **Flutter Web**     → SharedPreferences (sqflite is not supported on web)
///  - **Android / iOS / Desktop** → SQLite via [DatabaseHelper] (Unit 3.3)
///
/// This pattern shows how Flutter apps can adapt to platform capabilities
/// while sharing a single codebase.
class AppController extends ChangeNotifier {
  AppController(this._storage);

  final LocalStorageService _storage;

  /// SQLite helper — only accessed on non-web platforms.
  final _db = DatabaseHelper.instance;

  /// IDs of products the user has marked as favourite.
  final Set<String> favoriteIds = <String>{};

  /// All enquiry records (from SQLite on native, SharedPreferences on web).
  final List<Enquiry> enquiries = <Enquiry>[];

  // ─── Initialise ─────────────────────────────────────────────────────────

  /// Loads favourites + enquiries on startup.
  ///
  /// [testEnquiries] — pass an empty list in widget tests to skip
  /// both SQLite and SharedPreferences entirely.
  Future<void> load({List<Enquiry>? testEnquiries}) async {
    favoriteIds
      ..clear()
      ..addAll(_storage.loadFavoriteIds());

    if (testEnquiries != null) {
      // Test mode: bypass all storage.
      enquiries
        ..clear()
        ..addAll(testEnquiries);
      return;
    }

    if (kIsWeb) {
      // Web: SharedPreferences fallback (sqflite is not supported on web).
      enquiries
        ..clear()
        ..addAll(_storage.loadEnquiries());
    } else {
      // Native (Android / iOS / Desktop): SQLite READ.
      final rows = await _db.getAllEnquiries();
      enquiries
        ..clear()
        ..addAll(rows);
    }
  }

  // ─── Favourites (all platforms — SharedPreferences) ─────────────────────

  bool isFavorite(String productId) => favoriteIds.contains(productId);

  Future<void> toggleFavorite(String productId) async {
    if (!favoriteIds.add(productId)) {
      favoriteIds.remove(productId);
    }
    await _storage.saveFavoriteIds(favoriteIds);
    notifyListeners();
  }

  // ─── Enquiries CRUD ──────────────────────────────────────────────────────
  // On web  → SharedPreferences
  // On native → SQLite (Unit 3.3 — INSERT / SELECT / UPDATE / DELETE)

  /// CREATE / UPDATE — Inserts or replaces an enquiry.
  Future<void> saveEnquiry(Enquiry enquiry) async {
    if (kIsWeb) {
      // Web: upsert in in-memory list then persist to SharedPreferences.
      final index = enquiries.indexWhere((e) => e.id == enquiry.id);
      if (index == -1) {
        enquiries.insert(0, enquiry);
      } else {
        enquiries[index] = enquiry;
        enquiries.sort((a, b) => b.savedAt.compareTo(a.savedAt));
      }
      await _storage.saveEnquiries(enquiries);
    } else {
      // Native: SQLite INSERT (with REPLACE conflict algorithm).
      await _db.insertEnquiry(enquiry);
      final rows = await _db.getAllEnquiries();
      enquiries
        ..clear()
        ..addAll(rows);
    }
    notifyListeners();
  }

  /// UPDATE — Changes the status of an existing enquiry.
  Future<void> updateEnquiryStatus(String enquiryId, String newStatus) async {
    final index = enquiries.indexWhere((e) => e.id == enquiryId);
    if (index == -1) return;
    final updated = enquiries[index].copyWith(status: newStatus);

    if (kIsWeb) {
      enquiries[index] = updated;
      await _storage.saveEnquiries(enquiries);
    } else {
      // Native: SQLite UPDATE.
      await _db.updateEnquiry(updated);
      final rows = await _db.getAllEnquiries();
      enquiries
        ..clear()
        ..addAll(rows);
    }
    notifyListeners();
  }

  /// DELETE — Removes a single enquiry by id.
  Future<void> deleteEnquiry(String enquiryId) async {
    enquiries.removeWhere((e) => e.id == enquiryId);
    if (kIsWeb) {
      await _storage.saveEnquiries(enquiries);
    } else {
      // Native: SQLite DELETE.
      await _db.deleteEnquiry(enquiryId);
    }
    notifyListeners();
  }
}
