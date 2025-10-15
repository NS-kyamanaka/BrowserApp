import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:browser_app/widgets/bookmark_tile.dart';
import 'package:browser_app/widgets/register_dialog.dart';
import 'package:browser_app/data/models/bookmark.dart';

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  void _showRegistDialog(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(bookmarkListProvider.notifier);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RegistDialog(
          onRegistApp: (Bookmark bookmark) async {
            await notifier.addBookmark(bookmark);
            //Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(bookmarkListProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('ブックマーク一覧')),
      body: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
        ),
        child: ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final Bookmark currentBookmark = bookmarks[index];
            return BookmarkTile(bookmark: currentBookmark);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRegistDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
