import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/campus_provider.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});
  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _author = TextEditingController();
  String _category = 'General';
  bool _submitting = false;
  final _categories = const ['Events', 'Academics', 'Placements', 'Clubs', 'General'];

  @override
  void dispose() {
    _title.dispose(); _body.dispose(); _author.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _submitting) return;
    setState(() => _submitting = true);
    try {
      await context.read<CampusProvider>().addAnnouncement(
        title: _title.text, body: _body.text, category: _category, author: _author.text,
      );
      if (mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Post campus update')),
    body: Form(
      key: _formKey,
      child: ListView(padding: const EdgeInsets.all(20), children: [
        TextFormField(controller: _title, maxLength: 80,
          decoration: const InputDecoration(labelText: 'Announcement title'),
          validator: (v) => v == null || v.trim().length < 5 ? 'Enter at least 5 characters' : null),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: _category, decoration: const InputDecoration(labelText: 'Category'),
          items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
          onChanged: (v) => setState(() => _category = v ?? 'General'),
        ),
        const SizedBox(height: 12),
        TextFormField(controller: _author, maxLength: 40,
          decoration: const InputDecoration(labelText: 'Posted by'),
          validator: (v) => v == null || v.trim().isEmpty ? 'Enter a name or club' : null),
        const SizedBox(height: 12),
        TextFormField(controller: _body, minLines: 5, maxLines: 9, maxLength: 1500,
          decoration: const InputDecoration(labelText: 'Announcement details', alignLabelWithHint: true),
          validator: (v) => v == null || v.trim().length < 10 ? 'Enter at least 10 characters' : null),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: _submitting ? null : _submit,
          icon: const Icon(Icons.send),
          label: Text(_submitting ? 'Posting...' : 'Publish update'),
        ),
      ]),
    ),
  );
}
