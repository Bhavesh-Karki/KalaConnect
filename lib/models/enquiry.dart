/// Represents a custom craft enquiry created by a user on a product.
///
/// Stored in the local SQLite [enquiries] table via [DatabaseHelper].
class Enquiry {
  const Enquiry({
    required this.id,
    required this.productId,
    required this.customerName,
    required this.quantity,
    required this.notes,
    required this.contactPreference,
    required this.savedAt,
    this.status = 'Pending', // Pending | In Progress | Completed
  });

  final String id;
  final String productId;
  final String customerName;
  final int quantity;
  final String notes;
  final String contactPreference;
  final DateTime savedAt;

  /// Order status — tracks the enquiry lifecycle for CRUD Update demo.
  final String status;

  // ─── SQLite: Convert to/from column map ────────────────────────────────────

  /// Converts this Enquiry into a flat [Map] for SQLite INSERT / UPDATE.
  Map<String, dynamic> toMap() => {
        'id': id,
        'product_id': productId,
        'customer_name': customerName,
        'quantity': quantity,
        'notes': notes,
        'contact_preference': contactPreference,
        'status': status,
        'saved_at': savedAt.toIso8601String(),
      };

  /// Creates an [Enquiry] from a SQLite row map returned by [db.query].
  factory Enquiry.fromMap(Map<String, dynamic> map) => Enquiry(
        id: map['id'] as String,
        productId: map['product_id'] as String,
        customerName: map['customer_name'] as String,
        quantity: map['quantity'] as int,
        notes: map['notes'] as String,
        contactPreference: map['contact_preference'] as String,
        status: (map['status'] as String?) ?? 'Pending',
        savedAt: DateTime.parse(map['saved_at'] as String),
      );

  // ─── Legacy JSON helpers (kept for backward compatibility) ─────────────────

  /// Converts this Enquiry to JSON (legacy SharedPreferences format).
  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'customerName': customerName,
        'quantity': quantity,
        'notes': notes,
        'contactPreference': contactPreference,
        'status': status,
        'savedAt': savedAt.toIso8601String(),
      };

  factory Enquiry.fromJson(Map<String, dynamic> json) => Enquiry(
        id: json['id'] as String,
        productId: json['productId'] as String,
        customerName: json['customerName'] as String,
        quantity: json['quantity'] as int,
        notes: json['notes'] as String,
        contactPreference: json['contactPreference'] as String,
        status: (json['status'] as String?) ?? 'Pending',
        savedAt: DateTime.parse(json['savedAt'] as String),
      );

  /// Returns a copy with changed fields.
  Enquiry copyWith({String? status, int? quantity, String? notes}) => Enquiry(
        id: id,
        productId: productId,
        customerName: customerName,
        quantity: quantity ?? this.quantity,
        notes: notes ?? this.notes,
        contactPreference: contactPreference,
        savedAt: savedAt,
        status: status ?? this.status,
      );
}
