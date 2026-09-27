# KalaConnect

> *"Discover artisans. Explore crafts. Preserve stories."*

**KalaConnect** is an Application prototype that works as a digital marketplace and knowledge network connecting traditional Indian artisans with consumers, researchers, and learners. It showcases craft categories, artisan profiles, and products — all backed by compile-time seed data so the app runs fully offline, with a real SQLite-backed enquiry system for "contact the artisan" style requests.

---

## ✨ Features

- **Craft Library** — 6 craft categories (Pottery, Bamboo, Textiles, Wood, Metal, Accessories) with regional context, materials, process steps, cultural significance, and care guidance.
- **Artisan Directory** — 11 artisan profiles with location, experience, and personal story, linked to their craft and products.
- **Product Catalogue** — 30 seeded products with multi-level filtering: category, sub-category, region, price band, making time, material, artisan, free-text search, and sorting.
- **Favourites** — Save/unsave products, persisted via `SharedPreferences`.
- **Enquiries (full CRUD)** — Create, view, update status, and delete custom product enquiries, backed by **SQLite** (`sqflite`) on Android/iOS/Desktop and **SharedPreferences** on Web.
- **Responsive layout** — Product grid adapts from 2 columns (phone) to 3 (tablet) to 4 (desktop).
- **Offline illustrations** — Custom `CustomPainter` artwork (`CraftArtwork`) as a fallback whenever a product has no network image.
- **Material 3 design** — Warm terracotta/ivory/teal/ochre palette with a custom theme.

---

## 🧱 Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter (Web, Android, iOS, Desktop) — Dart SDK `^3.12.2` |
| Design system | Material 3 (`ColorScheme.fromSeed`) |
| State management | `ChangeNotifier` + `ListenableBuilder` |
| Persistent storage | `sqflite` (native) · `shared_preferences` (web & favourites) |
| Path resolution | `path` package (for the SQLite `.db` file) |

### Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.5.3
  sqflite: ^2.4.1
  path: ^1.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

---

## 📂 Project Structure

```
kalaconnect/
├── lib/
│   ├── main.dart                        # Entry point + exports
│   ├── app/
│   │   ├── app_colors.dart              # Global color constants
│   │   ├── app_controller.dart          # State manager (ChangeNotifier)
│   │   ├── app_theme.dart               # Material 3 theme
│   │   ├── database_helper.dart         # SQLite singleton
│   │   ├── kala_connect_app.dart        # Root widget + Named Routes
│   │   └── local_storage_service.dart   # SharedPreferences service
│   ├── data/
│   │   └── seed_data.dart               # All static app data (crafts, artisans, products)
│   ├── models/
│   │   ├── artisan.dart
│   │   ├── craft.dart
│   │   ├── enquiry.dart                 # SQLite-mapped model
│   │   └── product.dart
│   ├── screens/
│   │   ├── home_screen.dart             # Navigation shell (BottomNavigationBar)
│   │   ├── explore_screen.dart          # Product catalogue + filters
│   │   ├── artisans_screen.dart         # Artisan directory
│   │   ├── artisan_detail_screen.dart
│   │   ├── crafts_screen.dart           # Craft library list
│   │   ├── craft_detail_screen.dart
│   │   ├── product_detail_screen.dart
│   │   ├── saved_screen.dart            # Favourites + Enquiries tabs
│   │   ├── enquiry_form_screen.dart     # Create / Edit enquiry
│   │   ├── enquiry_detail_screen.dart   # View + Update status + Delete
│   │   └── about_screen.dart
│   ├── utils/
│   │   └── formatters.dart              # rupees(), readableDate()
│   └── widgets/
│       ├── artisan_avatar.dart
│       ├── artisan_card.dart
│       ├── common_widgets.dart          # PageShell, InfoCard, InfoRow, EmptyState, etc.
│       ├── craft_artwork.dart           # Custom painted offline illustrations
│       ├── craft_carousel.dart          # Horizontal carousel of craft cards
│       ├── enquiry_tile.dart            # Enquiry list tile with status badge
│       ├── product_card.dart
│       ├── product_grid.dart            # Responsive grid (2/3/4 columns)
│       └── product_image.dart           # Network image with CraftArtwork fallback
├── assets/images/                       # App logo + monogram icon
├── android/                             # Android platform project
├── web/                                 # Web platform project (custom favicon)
├── test/
│   └── widget_test.dart                 # Widget test (bypasses SQLite safely)
├── pubspec.yaml
├── analysis_options.yaml
└── context.md                           # Full developer/viva reference doc
```

---

## 🗃️ Data Models

- **`Craft`** — id, title, category, region, introduction, context, materials, process, significance, care, article, artworkKind.
- **`Artisan`** — id, name, location, craftId (FK → Craft), experience, introduction, story.
- **`Product`** — id, name, category, subCategory, price, artisanId (FK → Artisan), craftId (FK → Craft), description, materials, dimensions, makingTime, artworkKind, imageUrl.
- **`Enquiry`** *(SQLite-mapped)* — id, productId (FK → Product), customerName, quantity, notes, contactPreference, savedAt, status (`Pending` / `In Progress` / `Completed`). Includes `toMap`/`fromMap` (SQLite) and `toJson`/`fromJson` (web SharedPreferences).

All catalogue data (6 crafts, 11 artisans, 30 products) is **compile-time constant seed data** — no external API calls, so the app works fully offline from first launch.

---

## 🧭 Navigation

Named routes are defined in `kala_connect_app.dart`:

| Route | Screen |
|---|---|
| `/` | Home (navigation shell) |
| `/explore` | Product catalogue |
| `/artisans` | Artisan directory |
| `/crafts` | Craft library |
| `/saved` | Favourites + Enquiries |
| `/about` | About / problem statement |

Detail screens (product, artisan, craft, enquiry) are opened with `Navigator.push()` and closed with `Navigator.pop()`, optionally passing back a result (e.g. after a delete confirmation).

---

## 💾 Storage Architecture

| Platform | Enquiries | Favourites |
|---|---|---|
| Android / iOS / Desktop | **SQLite** via `DatabaseHelper` (singleton) | `SharedPreferences` |
| Flutter Web | `SharedPreferences` (`local_enquiries` key) | `SharedPreferences` |
| Widget tests | In-memory list via `load(testEnquiries: [])` | Mocked `SharedPreferences` |

The app checks `kIsWeb` at runtime and branches accordingly (`sqflite` has no web/browser support), so the same `AppController` API works everywhere without platform-specific call sites in the UI.

**SQLite schema** (`enquiries` table): `id`, `product_id`, `customer_name`, `quantity`, `notes`, `contact_preference`, `status` (default `'Pending'`), `saved_at`. Full CRUD is implemented in `DatabaseHelper` (`insertEnquiry`, `getAllEnquiries`, `getEnquiryById`, `updateEnquiry`, `deleteEnquiry`), using `ConflictAlgorithm.replace` so the same insert call handles both create and update.

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Dart `^3.12.2` or later)
- A configured target: Chrome (web), Android emulator/device, or desktop

### Setup

```bash
# 1. Clone the repo
git clone https://github.com/Bhavesh-Karki/KalaConnect.git
cd KalaConnect

# 2. Install dependencies
flutter pub get

# 3. Run on Chrome (web)
flutter run -d chrome

# 4. Run on Android device/emulator
flutter run -d android

# 5. Run tests
flutter test

# 6. Static analysis
flutter analyze
```

---

## 🎨 Design

- **Palette:** terracotta `#A44832` (primary), ivory `#FFF9F1` (background), teal `#245C55` (secondary/accents), ochre `#D5A640` (tertiary), ink `#2F2926` (text).
- **Theme:** Material 3, `ColorScheme.fromSeed(seedColor: terracotta)`, 16px-radius cards and inputs, ochre navigation indicator.
- **Brand wordmark:** "**Kala**" in bold ink + "**Connect**" in a lighter warm orange, same font size for baseline alignment.

---

## 🧪 Testing

`test/widget_test.dart` boots the app with a mocked `SharedPreferences` instance and `load(testEnquiries: [])`, which bypasses `sqflite` entirely — since the headless Flutter test VM has no native platform channel for SQLite. This keeps the test suite fast (~5s) while the real SQLite path is exercised on-device.

---

## 🔭 Future Scope

As outlined in the in-app **About** screen:

- AI-assisted artisan storytelling
- Computer-vision based authenticity verification
- AR/VR craft workshops
- GIS-based artisan mapping

