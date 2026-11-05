import 'package:flutter/material.dart';
import '../models/announcement.dart';

class AnnouncementCard extends StatelessWidget {
  final Announcement item;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSave;

  const AnnouncementCard({
    super.key, required this.item, required this.isSaved,
    required this.onTap, required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Chip(label: Text(item.category)),
              const Spacer(),
              IconButton(
                tooltip: isSaved ? 'Remove saved' : 'Save announcement',
                onPressed: onSave,
                icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
              ),
            ]),
            Text(item.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(item.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(children: [
              Expanded(child: Text(item.author, style: Theme.of(context).textTheme.labelMedium)),
              Text(_date(item.createdAt), style: Theme.of(context).textTheme.labelSmall),
            ]),
            if (item.isDemo)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('DEMO NOTICE — verify before use', style: TextStyle(fontSize: 10, color: Colors.deepOrange)),
              ),
          ]),
        ),
      ),
    );
  }

  String _date(DateTime date) => '${date.day}/${date.month}/${date.year}';
}
