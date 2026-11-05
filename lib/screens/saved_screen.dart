import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/campus_provider.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final items = provider.savedItems;
    return Scaffold(
      appBar: AppBar(title: const Text('Saved announcements')),
      body: items.isEmpty
          ? const Center(child: Text('No saved announcements yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AnnouncementCard(
                  item: item, isSaved: true,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnnouncementDetailScreen(id: item.id))),
                  onSave: () => provider.toggleSaved(item.id),
                );
              },
            ),
    );
  }
}
