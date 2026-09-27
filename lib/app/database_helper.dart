// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/enquiry.dart';

/// SQLite helper for KalaConnect — Singleton pattern.
///
/// Demonstrates Unit 3.3: Setting up SQLite + CRUD operations in Flutter.
///
/// ⚠️  sqflite does NOT support Flutter Web. [AppController] calls this class
/// only when [kIsWeb] is false (Android / iOS / macOS / Windows / Linux).
/// On web, [LocalStorageService] (SharedPreferences) is used instead.
class DatabaseHelper {
  DatabaseHelper._internal();

  /// The single shared instance of [DatabaseHelper].
  static final DatabaseHelper instance = DatabaseHelper._internal();

  /// The underlying SQLite connection. Opened lazily on first access.
  static Database? _database;

  // ─── Database name & version ───────────────────────────────────────────────
  static const _dbName = 'kalaconnect.db';
  static const _dbVersion = 1;

  // ─── Table & column constants ──────────────────────────────────────────────
  static const tableEnquiries = 'enquiries';
  static const colId = 'id';
  static const colProductId = 'product_id';
  static const colCustomerName = 'customer_name';
  static const colQuantity = 'quantity';
  static const colNotes = 'notes';
  static const colContactPreference = 'contact_preference';
  static const colStatus = 'status';
  static const colSavedAt = 'saved_at';

  // ─── Open / initialise ────────────────────────────────────────────────────

  /// Returns the open database, creating and initialising it if needed.
  ///
  /// Throws an [UnsupportedError] if called on web (should never happen —
  /// [AppController] guards all calls with [kIsWeb]).
  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError(
        'DatabaseHelper is not supported on Flutter Web. '
        'Use LocalStorageService (SharedPreferences) instead.',
      );
    }
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // getDatabasesPath() returns the platform-specific folder
    // (e.g. /data/data/<pkg>/databases on Android).
    final dbPath = await getDatabasesPath();
    final fullPath = p.join(dbPath, _dbName);

    return openDatabase(
      fullPath,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  /// Called once when the database file is first created.
  /// Runs the DDL that creates the [enquiries] table.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableEnquiries (
        $colId                TEXT PRIMARY KEY,
        $colProductId         TEXT    NOT NULL,
        $colCustomerName      TEXT    NOT NULL,
        $colQuantity          INTEGER NOT NULL,
        $colNotes             TEXT    NOT NULL,
        $colContactPreference TEXT    NOT NULL,
        $colStatus            TEXT    NOT NULL DEFAULT 'Pending',
        $colSavedAt           TEXT    NOT NULL
      )
    ''');
    print('[DatabaseHelper] Table "$tableEnquiries" created (v$version).');
  }

  // ─── CRUD Operations ──────────────────────────────────────────────────────

  // ── CREATE ──────────────────────────────────────────────────────────────

  /// Inserts a new [Enquiry] row into SQLite.
  ///
  /// Uses [ConflictAlgorithm.replace] so a re-insert of the same [id]
  /// acts as an upsert (safe for edit → re-save flows).
  ///
  /// Returns the new row-id assigned by SQLite.
  Future<int> insertEnquiry(Enquiry enquiry) async {
    final db = await database;
    final rowId = await db.insert(
      tableEnquiries,
      enquiry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('[DB] INSERT enquiry id=${enquiry.id}  rowId=$rowId');
    return rowId;
  }

  // ── READ ─────────────────────────────────────────────────────────────────

  /// Fetches **all** enquiries from SQLite, newest first.
  Future<List<Enquiry>> getAllEnquiries() async {
    final db = await database;
    final rows = await db.query(
      tableEnquiries,
      orderBy: '$colSavedAt DESC',
    );
    print('[DB] SELECT all enquiries → ${rows.length} rows');
    return rows.map(Enquiry.fromMap).toList();
  }

  /// Fetches a single enquiry by its [id].
  ///
  /// Returns [null] if no matching row exists.
  Future<Enquiry?> getEnquiryById(String id) async {
    final db = await database;
    final rows = await db.query(
      tableEnquiries,
      where: '$colId = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    return Enquiry.fromMap(rows.first);
  }

  // ── UPDATE ───────────────────────────────────────────────────────────────

  /// Updates an existing [Enquiry] row (matched by id).
  ///
  /// Returns the number of rows affected (1 on success, 0 if not found).
  Future<int> updateEnquiry(Enquiry enquiry) async {
    final db = await database;
    final count = await db.update(
      tableEnquiries,
      enquiry.toMap(),
      where: '$colId = ?',
      whereArgs: [enquiry.id],
    );
    print('[DB] UPDATE enquiry id=${enquiry.id}  rows=$count');
    return count;
  }

  // ── DELETE ───────────────────────────────────────────────────────────────

  /// Deletes a single enquiry row by its [id].
  ///
  /// Returns the number of rows deleted (1 on success, 0 if not found).
  Future<int> deleteEnquiry(String id) async {
    final db = await database;
    final count = await db.delete(
      tableEnquiries,
      where: '$colId = ?',
      whereArgs: [id],
    );
    print('[DB] DELETE enquiry id=$id  rows=$count');
    return count;
  }

  /// Deletes **all** enquiry rows (useful for "Clear all" feature).
  Future<int> deleteAllEnquiries() async {
    final db = await database;
    final count = await db.delete(tableEnquiries);
    print('[DB] DELETE ALL enquiries  rows=$count');
    return count;
  }

  // ─── Close ────────────────────────────────────────────────────────────────

  /// Closes the database connection. Call from tests or when app disposes.
  Future<void> close() async {
    final db = _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}
