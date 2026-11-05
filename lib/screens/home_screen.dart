import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/campus_provider.dart';
import '../widgets/announcement_card.dart';
import 'add_announcement_screen.dart';
import 'announcement_detail_screen.dart';
import 'saved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  String _category = 'All';
  final _categories = const ['All', 'Events', 'Academics', 'Placements', 'Clubs', 'General'];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CampusProvider>();
    final items = provider.filtered(_search.text, _category);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus News'),
        actions: [
          IconButton(tooltip: 'Saved', icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedScreen()))),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddAnnouncementScreen())),
        icon: const Icon(Icons.add), label: const Text('Post update'),
      ),
      body: RefreshIndicator(
        onRefresh: provider.load,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Your campus, in the loop.', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _search,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search campus updates'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            SizedBox(height: 42, child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((c) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(label: Text(c), selected: _category == c,
                  onSelected: (_) => setState(() => _category = c)),
              )).toList(),
            )),
            const SizedBox(height: 12),
            if (provider.isLoading && provider.items.isEmpty)
              const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator()))
            else if (provider.error != null && provider.items.isEmpty)
              Center(child: Column(children: [
                Text(provider.error!), TextButton(onPressed: provider.load, child: const Text('Retry')),
              ]))
            else if (items.isEmpty)
              const Padding(padding: EdgeInsets.all(36), child: Center(child: Text('No campus updates found. Try another search or category.')))
            else
              ...items.map((item) => AnnouncementCard(
                item: item, isSaved: provider.savedIds.contains(item.id),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AnnouncementDetailScreen(id: item.id))),
                onSave: () => provider.toggleSaved(item.id),
              )),
          ],
        ),
      ),
    );
  }
}
