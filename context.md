# KalaConnect — Complete Project Context (A to Z)

> **Purpose of this file:** A single reference document covering every aspect of the KalaConnect Flutter project — architecture, data, screens, widgets, packages, navigation, SQLite, and syllabus coverage — written for developers, evaluators, and viva preparation.

---

## 1. Project Overview

| Field | Details |
|:---|:---|
| **App Name** | KalaConnect |
| **Type** | Offline-first Flutter student prototype |
| **Description** | A digital marketplace and knowledge network that connects traditional Indian artisans with consumers, researchers, and learners |
| **Platform** | Flutter (Web, Android, iOS, Desktop) |
| **Dart SDK** | `^3.12.2` |
| **Flutter Version** | Material 3 |
| **State Management** | `ChangeNotifier` + `ListenableBuilder` |
| **Storage** | SQLite (`sqflite`) on native · SharedPreferences on web |
| **Package Name** | `kalaconnect` |
| **Version** | `1.0.0+1` |

### Tagline
> *"Discover artisans. Explore crafts. Preserve stories."*

---

## 2. Project Structure

```
kalaconnect/
├── lib/
│   ├── main.dart                        ← Entry point + exports
│   ├── app/
│   │   ├── app_colors.dart              ← Global color constants
│   │   ├── app_controller.dart          ← State manager (ChangeNotifier)
│   │   ├── app_theme.dart               ← Material 3 theme
│   │   ├── database_helper.dart         ← SQLite singleton (Unit 3.3)
│   │   ├── kala_connect_app.dart        ← Root widget + Named Routes
│   │   └── local_storage_service.dart   ← SharedPreferences service
│   ├── data/
│   │   └── seed_data.dart               ← All static app data (crafts, artisans, products)
│   ├── models/
│   │   ├── artisan.dart
│   │   ├── craft.dart
│   │   ├── enquiry.dart                 ← SQLite-mapped model
│   │   └── product.dart
│   ├── screens/
│   │   ├── home_screen.dart             ← Navigation shell (BottomNavigationBar)
│   │   ├── explore_screen.dart          ← Product catalogue + filters
│   │   ├── artisans_screen.dart         ← Artisan directory
│   │   ├── artisan_detail_screen.dart
│   │   ├── crafts_screen.dart           ← Craft library list
│   │   ├── craft_detail_screen.dart
│   │   ├── product_detail_screen.dart
│   │   ├── saved_screen.dart            ← Favourites + Enquiries tabs
│   │   ├── enquiry_form_screen.dart     ← Create / Edit enquiry
│   │   ├── enquiry_detail_screen.dart   ← View + Update status + Delete
│   │   └── about_screen.dart
│   ├── utils/
│   │   └── formatters.dart              ← rupees(), readableDate()
│   └── widgets/
│       ├── artisan_avatar.dart
│       ├── artisan_card.dart
│       ├── common_widgets.dart          ← PageShell, InfoCard, InfoRow, EmptyState, etc.
│       ├── craft_artwork.dart           ← Custom painted offline illustrations
│       ├── craft_carousel.dart          ← Horizontal carousel of craft cards
│       ├── enquiry_tile.dart            ← Enquiry list tile with status badge
│       ├── product_card.dart
│       ├── product_grid.dart            ← Responsive grid (2/3/4 columns)
│       └── product_image.dart           ← Network image with CraftArtwork fallback
├── assets/
│   └── images/
│       ├── KalaConnect-Applogo.png      ← App logo (favicon / web icon)
│       └── KalaConnect-transparentIcon.png ← Monogram icon (AppBar)
├── web/
│   ├── index.html                       ← Web entry point with custom favicon
│   ├── favicon.png                      ← KalaConnect-Applogo.png (overwritten)
│   └── icons/
│       ├── KalaConnect-Applogo.png
│       └── KalaConnect-transparentIcon.png
├── test/
│   └── widget_test.dart                 ← Widget test (bypasses SQLite safely)
├── pubspec.yaml
├── analysis_options.yaml
└── context.md                           ← This file
```

---

## 3. pubspec.yaml

```yaml
name: kalaconnect
description: "KalaConnect, an offline Flutter student prototype for discovering fictional artisan products and craft stories."
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.12.2

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.5.3   # Storage & Persistence package (Unit 3.2)
  sqflite: ^2.4.1               # SQLite CRUD for enquiries (Unit 3.3)
  path: ^1.9.0                  # Resolves the .db file path on device

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

### Package Types (Unit 3.2 Coverage)
| Category | Package | Usage |
|:---|:---|:---|
| **Storage & Persistence** | `shared_preferences` | Saves favourite IDs + enquiries on Web |
| **Storage & Persistence** | `sqflite` | Full SQLite CRUD for enquiries on native |
| **Storage & Persistence** | `path` | Resolves `.db` file path on device |
| **State Management** | `ChangeNotifier` (built-in) | Reactive UI state across screens |
| **UI Widgets** | `flutter/material.dart` | Material 3 design system |

---

## 4. Color Palette — `app_colors.dart`

| Name | Hex | Usage |
|:---|:---|:---|
| `terracotta` | `#A44832` | Primary brand color, card borders, headings |
| `ivory` | `#FFF9F1` | Scaffold / page background |
| `teal` | `#245C55` | Secondary accents, filter chips, artisan avatars |
| `ochre` | `#D5A640` | Tertiary accents, demo notices, enquiry icons |
| `ink` | `#2F2926` | Primary text color |
| `Color(0xFFE58E47)` | Orange-light | "Connect" text in brand title |

---

## 5. Theme — `app_theme.dart`

- **Material 3** with `ColorScheme.fromSeed(seedColor: terracotta)`
- `scaffoldBackgroundColor: ivory`
- **Cards**: white, elevation 1, 16px radius, terracotta border at 12% opacity
- **Input fields**: white fill, 16px radius `OutlineInputBorder`
- **Navigation bar**: `ochre` indicator at 35% opacity

---

## 6. Brand Title Styling

Used in both `home_screen.dart` and `about_screen.dart`:

```dart
Text.rich(
  TextSpan(
    style: const TextStyle(fontSize: 22, letterSpacing: 0.2),
    children: [
      TextSpan(
        text: 'Kala',
        style: TextStyle(fontWeight: FontWeight.w900, color: ink),
      ),
      TextSpan(
        text: 'Connect',
        style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFFE58E47)),
      ),
    ],
  ),
)
```

- **Kala** → Bold weight (w900), dark ink color
- **Connect** → Light weight (w400), warm light orange
- Both share identical `fontSize: 22` so they align at equal height

---

## 7. Data Models

### 7.1 `Artisan`
```dart
class Artisan {
  final String id;
  final String name;
  final String location;
  final String craftId;      // FK → Craft.id
  final String experience;
  final String introduction;
  final String story;
  String get initials => ...  // e.g. "AM" for Aasha Menon
}
```

### 7.2 `Craft`
```dart
class Craft {
  final String id;
  final String title;
  final String category;
  final String region;
  final String introduction;
  final String context;
  final List<String> materials;
  final List<String> process;
  final String significance;
  final String care;
  final String article;
  final String artworkKind;  // 'pottery'|'basket'|'textile'|'tray'|'lamp'|'vase'
}
```

### 7.3 `Product`
```dart
class Product {
  final String id;
  final String name;
  final String category;
  final String subCategory;   // optional, default ''
  final int price;
  final String artisanId;     // FK → Artisan.id
  final String craftId;       // FK → Craft.id
  final String description;
  final List<String> materials;
  final String dimensions;
  final String makingTime;
  final String artworkKind;   // used for CraftArtwork fallback
  final String imageUrl;      // https:// URL, empty falls back to CraftArtwork
}
```

### 7.4 `Enquiry` (SQLite-mapped)
```dart
class Enquiry {
  final String id;
  final String productId;          // FK → Product.id
  final String customerName;
  final int quantity;
  final String notes;
  final String contactPreference;  // 'Phone call' | 'Email' | 'Message'
  final DateTime savedAt;
  final String status;             // 'Pending' | 'In Progress' | 'Completed'

  Map<String, dynamic> toMap()           // → SQLite row
  factory Enquiry.fromMap(Map m)         // ← SQLite row
  Map<String, dynamic> toJson()          // → SharedPreferences JSON (web)
  factory Enquiry.fromJson(Map json)     // ← SharedPreferences JSON (web)
  Enquiry copyWith({status, quantity, notes})
}
```

---

## 8. Seed Data — `seed_data.dart`

The app uses **compile-time constant data** — no external API, works fully offline.

### 8.1 Crafts (6 categories)
| id | Title | Category | artworkKind |
|:---|:---|:---|:---|
| `terracotta` | Terracotta & Ceramic Pottery | Pottery | pottery |
| `bamboo` | Bamboo & Cane Weaving | Bamboo | basket |
| `textiles` | Handloom & Khadi Textiles | Textiles | textile |
| `wood` | Hand Wood Carving | Wood | tray |
| `metal` | Bell Metal & Brass Craft | Metal | lamp |
| `accessories` | Handcrafted Accessories & Jewelry | Accessories | textile |

### 8.2 Artisans (11 profiles)
| id | Name | Location | craftId |
|:---|:---|:---|:---|
| `aasha` | Aasha Menon | Kochi, Kerala | terracotta |
| `dev` | Dev Rathod | Bhuj, Gujarat | terracotta |
| `harish` | Harish Prajapati | Jaipur, Rajasthan | terracotta |
| `meera` | Meera Devi | Bishnupur, West Bengal | terracotta |
| `biren` | Biren Das | Silchar, Assam | bamboo |
| `ela` | Ela Soren | Ranchi, Jharkhand | bamboo |
| `kavita` | Kavita Murmu | Mayurbhanj, Odisha | bamboo |
| `charu` | Charu Iyer | Coimbatore, Tamil Nadu | textiles |
| `farah` | Farah Khan | Saharanpur, Uttar Pradesh | wood |
| `gopal` | Gopal Naik | Cuttack, Odisha | metal |
| `sunita` | Sunita Rawat | Jaipur, Rajasthan | accessories |

### 8.3 Products (30 items, p1–p30)
| Range | Category | Sub-categories |
|:---|:---|:---|
| p1–p9 | Pottery | Pots & Planters, Vases, Tableware, Lamps, Wall Decor |
| p10–p16 | Bamboo | Storage Baskets, Pendant Lamps, Breakfast Trays, Planters |
| p17–p21 | Textiles | Table Runners, Indigo Stoles, Cushion Covers, Throws |
| p22–p24 | Wood | Platters, Spice Boxes, Keepsake Chests |
| p25–p28 | Metal | Oil Diyas, Hammered Bowls, Temple Chimes, Wall Plates |
| p29–p30 | Accessories | Bangles, Pendants |

### 8.4 Seed Data Helper Functions
```dart
Product productById(String id)   // throws if not found
Artisan artisanById(String id)
Craft   craftById(String id)
```

---

## 9. Navigation Architecture (Unit 3.2)

### 9.1 Named Routes — `kala_connect_app.dart`

```dart
class AppRoutes {
  static const home     = '/';
  static const explore  = '/explore';
  static const artisans = '/artisans';
  static const crafts   = '/crafts';
  static const saved    = '/saved';
  static const about    = '/about';
}
```

**Configuration in MaterialApp:**
```dart
MaterialApp(
  initialRoute: AppRoutes.home,       // first screen
  routes: {
    '/':          (_) => HomeScreen(...),
    '/explore':   (_) => ExploreScreen(...),
    '/artisans':  (_) => ArtisansScreen(...),
    '/crafts':    (_) => CraftsScreen(...),
    '/saved':     (_) => SavedScreen(...),
    '/about':     (_) => AboutScreen(),
  },
  onGenerateRoute: (settings) => MaterialPageRoute(
    builder: (_) => Scaffold(body: Center(child: Text('No route for "${settings.name}"'))),
  ),
)
```

### 9.2 Navigator.push() — Opening Detail Screens
Used throughout the app for product, artisan, craft, and enquiry detail screens:
```dart
// ProductCard → ProductDetailScreen
Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(...)));

// ArtisanCard → ArtisanDetailScreen
Navigator.push(context, MaterialPageRoute(builder: (_) => ArtisanDetailScreen(...)));

// EnquiryTile → EnquiryDetailScreen
Navigator.push(context, MaterialPageRoute(builder: (_) => EnquiryDetailScreen(...)));
```

### 9.3 Navigator.pop() — Going Back
```dart
// After save/delete in forms:
Navigator.pop(context);

// With return value:
Navigator.pop(context, true); // e.g., after confirming delete
```

### 9.4 Difference: push() vs pop()
| `Navigator.push()` | `Navigator.pop()` |
|:---|:---|
| **Adds** a new route on top of the stack | **Removes** the current route from the top |
| Screen slides in from right | Screen slides out to right |
| The previous screen is kept in memory | Returns to the previous screen |
| Can optionally carry arguments | Can optionally return a result |

---

## 10. SQLite Implementation (Unit 3.3)

### 10.1 Advantages of SQLite in Flutter
1. **Serverless & embedded** — no MySQL server, XAMPP, or IP configuration needed
2. **Offline-first** — full CRUD works with zero internet
3. **ACID compliant** — prevents data corruption
4. **Relational power** — SQL queries, `ORDER BY`, `WHERE` filters
5. **Persistent across restarts** — data survives app close/open
6. **Superior to SharedPreferences** for structured/relational records

### 10.2 Setting Up the Environment
```yaml
# pubspec.yaml
dependencies:
  sqflite: ^2.4.1    # SQLite driver
  path: ^1.9.0        # File path resolver
```

### 10.3 Database Schema
```sql
CREATE TABLE enquiries (
  id                TEXT    PRIMARY KEY,
  product_id        TEXT    NOT NULL,
  customer_name     TEXT    NOT NULL,
  quantity          INTEGER NOT NULL,
  notes             TEXT    NOT NULL,
  contact_preference TEXT   NOT NULL,
  status            TEXT    NOT NULL DEFAULT 'Pending',
  saved_at          TEXT    NOT NULL
);
```

### 10.4 DatabaseHelper — Singleton Pattern
```dart
class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  Future<Database> get database async {
    if (kIsWeb) throw UnsupportedError('Not supported on web');
    _database ??= await _initDatabase();
    return _database!;
  }
}
```

### 10.5 Full CRUD Operations

#### CREATE — Insert Enquiry
```dart
Future<int> insertEnquiry(Enquiry enquiry) async {
  final db = await database;
  return await db.insert(
    'enquiries',
    enquiry.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace, // upsert
  );
}
```

#### READ — Fetch All Enquiries
```dart
Future<List<Enquiry>> getAllEnquiries() async {
  final db = await database;
  final rows = await db.query('enquiries', orderBy: 'saved_at DESC');
  return rows.map(Enquiry.fromMap).toList();
}

// Fetch single by ID
Future<Enquiry?> getEnquiryById(String id) async {
  final rows = await db.query('enquiries', where: 'id = ?', whereArgs: [id], limit: 1);
  return rows.isEmpty ? null : Enquiry.fromMap(rows.first);
}
```

#### UPDATE — Update Enquiry
```dart
Future<int> updateEnquiry(Enquiry enquiry) async {
  final db = await database;
  return await db.update(
    'enquiries',
    enquiry.toMap(),
    where: 'id = ?',
    whereArgs: [enquiry.id],
  );
}
```

#### DELETE — Remove Enquiry
```dart
Future<int> deleteEnquiry(String id) async {
  final db = await database;
  return await db.delete('enquiries', where: 'id = ?', whereArgs: [id]);
}
```

### 10.6 Platform-Conditional Storage (Web vs Native)
```dart
// In AppController — all CRUD methods branch on kIsWeb:

Future<void> load() async {
  if (kIsWeb) {
    enquiries.addAll(_storage.loadEnquiries()); // SharedPreferences
  } else {
    enquiries.addAll(await _db.getAllEnquiries()); // SQLite
  }
}
```

| Platform | Storage for Enquiries | Storage for Favourites |
|:---|:---|:---|
| Android / iOS / Desktop | SQLite via `DatabaseHelper` | SharedPreferences |
| Flutter Web | SharedPreferences (`local_enquiries` key) | SharedPreferences |
| Widget Tests | In-memory list via `load(testEnquiries: [])` | SharedPreferences mock |

---

## 11. AppController — State Management

```dart
class AppController extends ChangeNotifier {
  // State
  final Set<String> favoriteIds = {};
  final List<Enquiry> enquiries = [];

  // Methods
  Future<void> load({List<Enquiry>? testEnquiries}) // startup init
  bool isFavorite(String productId)
  Future<void> toggleFavorite(String productId)
  Future<void> saveEnquiry(Enquiry enquiry)          // CREATE / UPDATE
  Future<void> updateEnquiryStatus(String id, String status) // UPDATE
  Future<void> deleteEnquiry(String enquiryId)       // DELETE
}
```

**Reactive pattern:** Every mutation ends with `notifyListeners()` → all `ListenableBuilder` widgets in the tree rebuild automatically.

---

## 12. Screens Reference

### 12.1 HomeScreen (`home_screen.dart`)
- **Role:** Main navigation shell
- Hosts 4 tabs via `NavigationBar`:
  1. Explore (index 0)
  2. Artisans (index 1)
  3. Crafts (index 2)
  4. Saved (index 3)
- **AppBar** title: `Image.asset` monogram icon + `Text.rich` **Kala**Connect
- About screen accessible from AppBar action button

### 12.2 ExploreScreen (`explore_screen.dart`)
- **Role:** Product catalogue with multi-level filtering
- **Filters available:**
  - Category chips (All / Pottery / Bamboo / Textiles / Wood / Metal / Accessories) with icons
  - Sub-category chips (e.g. Pots & Planters / Vases)
  - Region dropdown (by artisan state)
  - Price band dropdown (Under ₹500 / ₹500–₹1000 / ₹1000–₹2000 / ₹2000+)
  - Making time dropdown
  - Material dropdown
  - Artisan dropdown
  - Free-text search (name, category, artisan, materials, description)
  - Sort dropdown (Featured / Price: Low to High / Price: High to Low / Name)
- **Category icons:**
  - Pottery → `Icons.local_florist_outlined`
  - Bamboo → `Icons.shopping_basket_outlined`
  - Textiles → `Icons.texture_outlined`
  - Wood → `Icons.nature_people_outlined`
  - Metal → `Icons.brightness_high_outlined`
  - Accessories → `Icons.diamond_outlined`
- **Layout:** `LayoutBuilder` → 2 columns on phone, 3 on tablet, 6 on desktop
- Shows `{n} products found` counter

### 12.3 ArtisansScreen (`artisans_screen.dart`)
- Lists all 11 artisan profiles
- Free-text search by name, location, or craft
- Each card opens `ArtisanDetailScreen` via `Navigator.push()`

### 12.4 ArtisanDetailScreen (`artisan_detail_screen.dart`)
- Shows artisan avatar (initials), name, location, experience
- Full story paragraph
- LinkedPanel → opens CraftDetailScreen
- Products by this artisan (ProductGrid)

### 12.5 CraftsScreen (`crafts_screen.dart`)
- Lists all 6 craft categories
- Each card shows `CraftArtwork` illustration + title + region + intro
- Tapping opens `CraftDetailScreen` via `Navigator.push()`

### 12.6 CraftDetailScreen (`craft_detail_screen.dart`)
- Large `CraftArtwork` illustration
- Full article text
- InfoCards: Regional context, Materials (chips), Making process (numbered steps), Cultural significance, Care guidance
- Associated artisans list → each opens ArtisanDetailScreen
- Related products (ProductGrid)

### 12.7 ProductDetailScreen (`product_detail_screen.dart`)
- Product image (280px height) with CraftArtwork fallback
- Name, category, price
- Description
- Materials chips
- Specifications InfoCard (dimensions, making time)
- LinkedPanel → Artisan detail
- LinkedPanel → Craft detail
- Favourite toggle button (animated heart icon)
- "Create custom enquiry" button → `Navigator.push()` to EnquiryFormScreen

### 12.8 SavedScreen (`saved_screen.dart`)
- 2 tabs via `DefaultTabController`:
  - **Favourites** → ProductGrid of saved products, EmptyState if empty
  - **Enquiries** → List of EnquiryTile cards, EmptyState if empty
- Reactive via `ListenableBuilder(listenable: controller)`

### 12.9 EnquiryFormScreen (`enquiry_form_screen.dart`)
- Creates a new enquiry OR edits an existing one
- Fields: Name (TextFormField), Quantity (numeric), Contact preference (dropdown), Customization notes (multiline)
- On save: calls `controller.saveEnquiry()` → SQLite INSERT or UPDATE
- Snackbar says *"Enquiry saved to SQLite database ✓"* or *"Enquiry updated in SQLite database ✓"*
- `Navigator.pop()` returns to previous screen

### 12.10 EnquiryDetailScreen (`enquiry_detail_screen.dart`)
- Shows full enquiry info
- **Status badge** with color coding:
  - Pending → grey
  - In Progress → orange
  - Completed → green
- **ChoiceChip status selector** → calls `controller.updateEnquiryStatus()` → **SQLite UPDATE**
- Edit button → `Navigator.pushReplacement()` to EnquiryFormScreen
- Delete button → confirmation AlertDialog → `controller.deleteEnquiry()` → **SQLite DELETE** → `Navigator.pop()`

### 12.11 AboutScreen (`about_screen.dart`)
- Hero header with brand logo + styled KalaConnect title
- 4 numbered step cards:
  1. Problem Statement (market invisibility, authenticity gap, knowledge erosion)
  2. How Our App Solves This (direct maker discovery, structured living archives)
  3. What This App Does (artisan profiles, craft library, filters, enquiries, gallery)
  4. Future Scope (AI storytelling, CV authenticity, AR/VR workshops, GIS mapping)

---

## 13. Widgets Reference

### `PageShell`
Constrains content to `maxWidth: 1100` and center-aligns. Used as body wrapper on every screen.

### `InfoCard`
Card with bold title + child widget. Used for specifications, materials, etc.

### `InfoRow`
Two-column row: 150px label (bold) + expanded value text.

### `DemoNotice`
Ochre-tinted notice box with info icon. Shown on product/craft detail pages.

### `EmptyState`
Centered icon + title + body + optional action button. Used in Saved screen.

### `LinkedPanel`
Card with circular avatar/icon, title + subtitle, and a text action button. Used to link artisan/craft from product detail.

### `ProductGrid`
Responsive `GridView`: 2 cols (phone) / 3 cols (tablet) / 4 cols (desktop).
Child aspect ratio: 0.56 on narrow / 0.68 on wider.

### `ProductCard`
Card with:
- `ProductImage` (network image or CraftArtwork fallback)
- Animated `favorite_border` / `favorite` icon (tonal button overlay)
- Product name (2-line truncated)
- Category • Artisan name
- Price in ₹ (teal bold)
- Opens `ProductDetailScreen` on tap via `Navigator.push()`

### `ProductImage`
- If `imageUrl` starts with `http://` or `https://` → `Image.network` with loading spinner + `CraftArtwork` error fallback
- Otherwise → `CraftArtwork` directly
- "Photo" label badge overlaid at bottom-left

### `CraftArtwork`
Custom-painted offline illustration using `CustomPainter`. Supports 6 `kind` values:
- `basket` — woven basket drawing
- `tray` — wooden tray / platter
- `textile` — woven fabric stripes
- `lamp` — terracotta lamp
- `vase` — clay vase silhouette
- default (`pottery`) — round pot with teal rim

### `ArtisanAvatar`
Circle avatar showing artisan initials on teal background.
```dart
ArtisanAvatar(artisan: artisan, radius: 24) // default
ArtisanAvatar(artisan: artisan, radius: 36) // on detail screen
```

### `ArtisanCard`
Card showing artisan avatar, name, location, craft title, experience, introduction.
Opens `ArtisanDetailScreen` on tap via `Navigator.push()`.

### `EnquiryTile`
ListTile with:
- Ochre circle avatar (edit_note icon)
- Product name, artisan, quantity, date
- Color-coded status badge (Pending/In Progress/Completed)
- Opens `EnquiryDetailScreen` via `Navigator.push()`

### `craft_carousel.dart`
Horizontal scrollable carousel widget for craft categories shown on the home/explore area.

---

## 14. Utility Functions — `formatters.dart`

```dart
String rupees(int price) => '₹$price';
// e.g. rupees(1450) → '₹1450'

String readableDate(DateTime date) => '${date.day} ${months[date.month - 1]} ${date.year}';
// e.g. '20 Sep 2026'
```

---

## 15. Assets

| File | Location | Usage |
|:---|:---|:---|
| `KalaConnect-Applogo.png` | `assets/images/` + `web/icons/` | App logo (AppBar favicon, web `<link rel="icon">`) |
| `KalaConnect-transparentIcon.png` | `assets/images/` + `web/icons/` | Monogram icon in AppBar title and About screen header |

Both loaded via `Image.asset(...)` with `errorBuilder` fallback to Material icon.

---

## 16. Testing

### Widget Test — `test/widget_test.dart`
```dart
void main() {
  testWidgets('KalaConnect shows the offline catalogue', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = LocalStorageService(await SharedPreferences.getInstance());
    final controller = AppController(storage);

    // testEnquiries: [] bypasses SQLite entirely (no native plugin in test VM)
    await controller.load(testEnquiries: []);

    await tester.pumpWidget(KalaConnectApp(controller: controller));

    expect(find.text('KalaConnect'), findsOneWidget);
    expect(find.text('Discover artisans. Explore crafts. Preserve stories.'), findsOneWidget);
    await tester.scrollUntilVisible(find.textContaining('products found'), 220, ...);
    expect(find.textContaining('products found'), findsOneWidget);
  });
}
```

**Why `testEnquiries: []`?**
sqflite requires the Android/iOS native platform channel. The Flutter test VM (headless Dart) has no platform channel, so `controller.load(testEnquiries: [])` provides an empty list directly, bypassing all SQLite calls. The real SQLite code runs correctly on a physical device.

### Verification Commands
```powershell
flutter analyze   # → No issues found
flutter test      # → All tests passed (≈5 seconds)
```

---

## 17. Platform-Specific Notes

### Flutter Web
- **sqflite** does NOT support web (no native SQLite engine in the browser)
- All enquiry CRUD operations fall back to **SharedPreferences** (localStorage under the hood)
- Guarded via `kIsWeb` check in `AppController` and `DatabaseHelper`

### Android / iOS / Desktop
- Full **SQLite** database via sqflite
- Database file: `kalaconnect.db` stored in app's private data directory
- Table created automatically on first run via `_onCreate` callback

---

## 18. Syllabus Coverage Map

### Unit 3.2 — Flutter Packages & Navigation

| Topic | Where Covered |
|:---|:---|
| **Flutter Packages — Storage & Persistence** | `sqflite`, `path`, `shared_preferences` in `pubspec.yaml` |
| **Flutter Packages — State Management** | `ChangeNotifier` + `ListenableBuilder` in `app_controller.dart` |
| **Flutter Packages — UI Widgets** | `flutter/material.dart` — Material 3 throughout |
| **Flutter Navigation & Routing** | `kala_connect_app.dart` (Named Routes) + all screens |
| **Navigator.push()** | `ProductCard`, `ArtisanCard`, `EnquiryTile`, `CraftsScreen` |
| **Navigator.pop()** | `EnquiryFormScreen`, `EnquiryDetailScreen` after save/delete |
| **Difference push() vs pop()** | push() adds to stack; pop() removes from stack (see §9.4) |
| **Navigation with Named Routes** | `initialRoute`, `routes` map, `AppRoutes` constants, `onGenerateRoute` |

### Unit 3.3 — SQLite in Flutter

| Topic | Where Covered |
|:---|:---|
| **Advantages of SQLite** | `database_helper.dart` docstring + §10.1 above |
| **Setting up the environment** | `pubspec.yaml` (sqflite + path) + `DatabaseHelper._initDatabase()` |
| **SQLite CRUD — CREATE** | `DatabaseHelper.insertEnquiry()` → `db.insert(...)` |
| **SQLite CRUD — READ** | `DatabaseHelper.getAllEnquiries()` → `db.query(... ORDER BY)` + `getEnquiryById()` |
| **SQLite CRUD — UPDATE** | `DatabaseHelper.updateEnquiry()` → `db.update(... WHERE id = ?)` + `AppController.updateEnquiryStatus()` |
| **SQLite CRUD — DELETE** | `DatabaseHelper.deleteEnquiry()` → `db.delete(... WHERE id = ?)` |

---

## 19. Key Design Decisions

1. **Singleton DatabaseHelper**: Only one DB connection opened for the app lifetime. Prevents concurrency issues and resource leaks.

2. **`kIsWeb` branching**: sqflite doesn't support web. Rather than crashing, `AppController` routes to SharedPreferences on web and SQLite on native — a professional cross-platform pattern.

3. **`testEnquiries` bypass**: Widget tests pass `load(testEnquiries: [])` to skip all native storage. No extra FFI packages needed; tests run in ≈5 seconds.

4. **`CraftArtwork` fallback**: Every product has a custom-painted offline illustration. If the network image fails or no URL is provided, users always see something meaningful.

5. **`ConflictAlgorithm.replace`**: The SQLite insert uses REPLACE, making the same method work for both CREATE (new enquiry) and UPDATE (edit existing). The form screen sends the same `saveEnquiry()` call for both flows.

6. **Compile-time seed data**: All `const` objects — zero runtime parsing overhead, instant startup.

7. **LayoutBuilder for responsive grids**: Product grid auto-adjusts column count based on screen width: 2 → 3 → 4 columns. Filter dropdowns similarly scale 2 → 3 → 6 per row.

---

## 20. How to Run

```powershell
# Install dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Run on Android device/emulator
flutter run -d android

# Run tests
flutter test

# Analyze code
flutter analyze
```

---

*Last updated: 2026-09-26 | KalaConnect v1.0.0+1*
