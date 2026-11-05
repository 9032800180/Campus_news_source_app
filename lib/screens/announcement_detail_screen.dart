import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/campus_provider.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  final String id;
  const AnnouncementDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final matches = provider.items.where((e) => e.id == id);
    if (matches.isEmpty) {
      return Scaffold(appBar: AppBar(), body: const Center(child: Text('Announcement no longer exists.')));
    }
    final item = matches.first;
    final saved = provider.savedIds.contains(id);
    return Scaffold(
      appBar: AppBar(title: const Text('Announcement')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Chip(label: Text(item.category)),
        Text(item.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text('Posted by ${item.author} • ${item.createdAt.day}/${item.createdAt.month}/${item.createdAt.year}'),
        const Divider(height: 32),
        SelectableText(item.body, style: Theme.of(context).textTheme.bodyLarge),
        if (item.isDemo) ...[
          const SizedBox(height: 20),
          const Text('This is fictional demonstration content, not an official college notice.', style: TextStyle(color: Colors.deepOrange)),
        ],
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: () => provider.toggleSaved(id),
          icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border),
          label: Text(saved ? 'Remove from saved' : 'Save announcement'),
        ),
      ]),
    );
  }
}
