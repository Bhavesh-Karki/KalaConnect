import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/enquiry.dart';
import '../screens/enquiry_detail_screen.dart';
import '../utils/formatters.dart';

/// A card tile representing one SQLite-stored enquiry.
///
/// Tapping calls [Navigator.push()] to open [EnquiryDetailScreen].
/// Returning from that screen calls [Navigator.pop()] automatically.
class EnquiryTile extends StatelessWidget {
  const EnquiryTile({
    super.key,
    required this.enquiry,
    required this.controller,
  });

  final Enquiry enquiry;
  final AppController controller;

  Color _statusColor(String status) => switch (status) {
        'In Progress' => Colors.orange.shade700,
        'Completed' => Colors.green.shade700,
        _ => Colors.grey.shade600,
      };

  @override
  Widget build(BuildContext context) {
    final product = productById(enquiry.productId);
    final artisan = artisanById(product.artisanId);

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ochre,
          child: Icon(Icons.edit_note, color: ink),
        ),
        title: Text(product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${artisan.name} • Qty ${enquiry.quantity} • ${readableDate(enquiry.savedAt)}'),
            const SizedBox(height: 4),
            // Status chip — shows the current SQLite status field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: _statusColor(enquiry.status).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: _statusColor(enquiry.status).withValues(alpha: 0.4)),
              ),
              child: Text(
                enquiry.status,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: _statusColor(enquiry.status),
                ),
              ),
            ),
          ],
        ),
        isThreeLine: true,
        trailing: const Icon(Icons.chevron_right),
        // Navigator.push() → opens EnquiryDetailScreen on top of Saved screen
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EnquiryDetailScreen(
              enquiry: enquiry,
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
}
