import 'package:flutter/material.dart';

import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/enquiry.dart';
import '../utils/formatters.dart';
import '../widgets/common_widgets.dart';
import 'enquiry_form_screen.dart';

/// Detail view for a single saved enquiry.
///
/// Demonstrates:
///  - Navigator.push() → push() was called from [EnquiryTile] to arrive here
///  - Navigator.pop()  → "Delete" and back button call pop() to return
///  - SQLite UPDATE    → "Change status" demonstrates the Update CRUD operation
class EnquiryDetailScreen extends StatelessWidget {
  const EnquiryDetailScreen({
    super.key,
    required this.enquiry,
    required this.controller,
  });

  final Enquiry enquiry;
  final AppController controller;

  static const _statuses = ['Pending', 'In Progress', 'Completed'];

  Color _statusColor(String status) => switch (status) {
        'In Progress' => Colors.orange.shade700,
        'Completed' => Colors.green.shade700,
        _ => Colors.grey.shade600, // Pending
      };

  IconData _statusIcon(String status) => switch (status) {
        'In Progress' => Icons.timelapse_outlined,
        'Completed' => Icons.check_circle_outline,
        _ => Icons.hourglass_top_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final product = productById(enquiry.productId);
    final artisan = artisanById(product.artisanId);

    return Scaffold(
      appBar: AppBar(title: const Text('Enquiry Details')),
      body: PageShell(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Status Badge ─────────────────────────────────────────────
            Row(
              children: [
                Icon(_statusIcon(enquiry.status),
                    color: _statusColor(enquiry.status)),
                const SizedBox(width: 8),
                Text(
                  'Status: ${enquiry.status}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _statusColor(enquiry.status),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Enquiry info ─────────────────────────────────────────────
            InfoCard(
              title: product.name,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(label: 'Artisan', value: artisan.name),
                  InfoRow(label: 'Customer', value: enquiry.customerName),
                  InfoRow(label: 'Quantity', value: '${enquiry.quantity}'),
                  InfoRow(label: 'Contact', value: enquiry.contactPreference),
                  InfoRow(label: 'Saved', value: readableDate(enquiry.savedAt)),
                  const SizedBox(height: 8),
                  Text(
                    enquiry.notes,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── SQLite UPDATE: change status ──────────────────────────────
            Text(
              'Update Status (SQLite UPDATE)',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: teal, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _statuses.map((s) {
                final isSelected = enquiry.status == s;
                return ChoiceChip(
                  label: Text(s),
                  selected: isSelected,
                  selectedColor: teal.withValues(alpha: 0.2),
                  onSelected: isSelected
                      ? null
                      : (_) async {
                          // SQLite UPDATE via controller
                          await controller.updateEnquiryStatus(enquiry.id, s);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Status updated to "$s" in SQLite'),
                              ),
                            );
                            // Navigator.pop() — pops back to Saved screen
                            Navigator.pop(context);
                          }
                        },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // ── Edit (push to EnquiryFormScreen) ─────────────────────────
            FilledButton.icon(
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit enquiry'),
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => EnquiryFormScreen(
                    controller: controller,
                    product: product,
                    existing: enquiry,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // ── SQLite DELETE ─────────────────────────────────────────────
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete enquiry'),
              onPressed: () async {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Delete enquiry?'),
                    content: const Text(
                        'This will permanently remove it from the SQLite database.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirmed == true) {
                  await controller.deleteEnquiry(enquiry.id); // SQLite DELETE
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Enquiry deleted from SQLite')),
                    );
                    Navigator.pop(context); // Navigator.pop() back to Saved
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
