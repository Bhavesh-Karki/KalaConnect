import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/enquiry.dart';

/// Handles **device-level persistence** for KalaConnect.
///
/// Demonstrates Unit 3.2 — Storage & Persistence package type:
/// [SharedPreferences] stores simple key-value data (favourites + web enquiries).
///
/// On **Flutter Web**, SharedPreferences is also used for enquiries because
/// sqflite does not support web. On **Android / iOS / Desktop**, SQLite is
/// used instead (see [DatabaseHelper]).
class LocalStorageService {
  LocalStorageService(this._preferences);

  final SharedPreferences _preferences;

  static const _favoriteKey = 'favorite_product_ids';
  static const _enquiryKey = 'local_enquiries'; // used on Web only

  // ─── Favourites (all platforms) ───────────────────────────────────────────

  /// Loads saved favourite product IDs from SharedPreferences.
  List<String> loadFavoriteIds() =>
      _preferences.getStringList(_favoriteKey) ?? <String>[];

  /// Persists the current set of favourite product IDs.
  Future<void> saveFavoriteIds(Set<String> ids) =>
      _preferences.setStringList(_favoriteKey, ids.toList()..sort());

  // ─── Enquiries — Web fallback via SharedPreferences ───────────────────────
  // On native platforms (Android / iOS / Desktop) these methods are NOT called;
  // SQLite via DatabaseHelper is used instead.

  /// Loads enquiries from SharedPreferences (web fallback).
  List<Enquiry> loadEnquiries() {
    final rawItems = _preferences.getStringList(_enquiryKey) ?? <String>[];
    return rawItems
        .map((raw) => Enquiry.fromJson(jsonDecode(raw) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.savedAt.compareTo(a.savedAt));
  }

  /// Persists enquiries to SharedPreferences (web fallback).
  Future<void> saveEnquiries(List<Enquiry> enquiries) {
    final encoded = enquiries.map((e) => jsonEncode(e.toJson())).toList();
    return _preferences.setStringList(_enquiryKey, encoded);
  }
}
