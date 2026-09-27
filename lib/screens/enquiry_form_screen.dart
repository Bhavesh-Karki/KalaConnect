import 'package:flutter/material.dart';

// import '../app/app_colors.dart';
import '../app/app_controller.dart';
import '../data/seed_data.dart';
import '../models/enquiry.dart';
import '../models/product.dart';
import '../utils/formatters.dart';
import '../widgets/common_widgets.dart';

class EnquiryFormScreen extends StatefulWidget {
  const EnquiryFormScreen({
    super.key,
    required this.controller,
    required this.product,
    this.existing,
  });

  final AppController controller;
  final Product product;
  final Enquiry? existing;

  @override
  State<EnquiryFormScreen> createState() => _EnquiryFormScreenState();
}

class _EnquiryFormScreenState extends State<EnquiryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _quantity;
  late final TextEditingController _notes;
  late String _contactPreference;

  @override
  void initState() {
    super.initState();
    final existing = widget.existing;
    _name = TextEditingController(text: existing?.customerName ?? '');
    _quantity = TextEditingController(text: '${existing?.quantity ?? 1}');
    _notes = TextEditingController(text: existing?.notes ?? '');
    _contactPreference = existing?.contactPreference ?? 'Phone call';
  }

  @override
  void dispose() {
    _name.dispose();
    _quantity.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final existing = widget.existing;
    final enquiry = Enquiry(
      id: existing?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      productId: widget.product.id,
      customerName: _name.text.trim(),
      quantity: int.parse(_quantity.text.trim()),
      notes: _notes.text.trim(),
      contactPreference: _contactPreference,
      // Preserve existing status on edit; default 'Pending' on new enquiry.
      status: existing?.status ?? 'Pending',
      savedAt: existing?.savedAt ?? DateTime.now(),
    );
    // SQLite CREATE (insert) or UPDATE (replace by id)
    await widget.controller.saveEnquiry(enquiry);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existing == null
              ? 'Enquiry saved to SQLite database ✓'
              : 'Enquiry updated in SQLite database ✓',
        ),
      ),
    );
    // Navigator.pop() — returns to the previous screen (Saved or Detail)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final artisan = artisanById(widget.product.artisanId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existing == null ? 'Create custom enquiry' : 'Edit enquiry',
        ),
      ),
      body: PageShell(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              InfoCard(
                title: widget.product.name,
                child: Text(
                  '${artisan.name} • ${rupees(widget.product.price)} sample price',
                ),
              ),
              const SizedBox(height: 12),
              // const DemoNotice(text: demoNotice),
              const SizedBox(height: 16),
              TextFormField(
                controller: _name,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Your name'),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a name'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _quantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (value) {
                  final parsed = int.tryParse(value?.trim() ?? '');
                  if (parsed == null || parsed < 1) {
                    return 'Enter a quantity of at least 1';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _contactPreference,
                decoration: const InputDecoration(
                  labelText: 'Preferred contact note',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Phone call',
                    child: Text('Phone call'),
                  ),
                  DropdownMenuItem(value: 'Email', child: Text('Email')),
                  DropdownMenuItem(value: 'Message', child: Text('Message')),
                ],
                onChanged: (value) => setState(
                  () => _contactPreference = value ?? _contactPreference,
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notes,
                minLines: 4,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Customization notes',
                  alignLabelWithHint: true,
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Add a short note'
                    : null,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                icon: const Icon(Icons.save_outlined),
                label: const Text('Save locally'),
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
