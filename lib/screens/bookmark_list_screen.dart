import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:browser_app/widgets/bookmark_tile.dart';
import 'package:browser_app/data/models/bookmark.dart';
import 'package:browser_app/widgets/search_input_field.dart';
import 'package:browser_app/utils/dialog_utils.dart';

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(filteredBookmarkListProvider);

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('ブックマーク一覧')),

      body: Column(
        children: [
          const SearchInputField(),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey)),
              ),
              child: ListView.builder(
                itemCount: bookmarks.length,
                itemBuilder: (context, index) {
                  final Bookmark currentBookmark = bookmarks[index];

                  return Dismissible(
                    key: ValueKey(currentBookmark.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      ref
                          .read(bookmarkListProvider.notifier)
                          .removeBookmark(currentBookmark.id!);
                    },
                    background: Container(
                      padding: EdgeInsets.only(right: 10),
                      color: Colors.red,
                      alignment: AlignmentDirectional.centerEnd,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: BookmarkTile(bookmark: currentBookmark),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showRegistDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }
}
