import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:browser_app/providers/sort_settings_notifier.dart';
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
    final bookmarks = ref.watch(sortedAndFilteredBookmarkListProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ブックマーク一覧'),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              final currentDirection = ref.watch(sortDirectionProvider);
              final notifier = ref.read(sortDirectionProvider.notifier);
              return PopupMenuButton<SortDirection>(
                icon: const Icon(Icons.sort),
                onSelected: (SortDirection result) {
                  notifier.state = result;
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<SortDirection>>[
                      const PopupMenuItem<SortDirection>(
                        enabled: false,
                        child: Text(
                          '登録日時',
                          style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black54),
                        ),
                      ),

                      const PopupMenuDivider(),

                      PopupMenuItem<SortDirection>(
                        value: SortDirection.desc,
                        child: Row(
                          children: [
                            Visibility(
                              visible: currentDirection == SortDirection.desc,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: const Icon(Icons.check, size: 18),
                            ),
                            const SizedBox(width: 8),
                            const Text('降順（新しい順）'),
                          ],
                        ),
                      ),
                      PopupMenuItem<SortDirection>(
                        value: SortDirection.asc,
                        child: Row(
                          children: [
                            Visibility(
                              visible: currentDirection == SortDirection.asc,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: const Icon(Icons.check, size: 18),
                            ),
                            const SizedBox(width: 8),
                            const Text('昇順（古い順）'),
                          ],
                        ),
                      ),
                    ],
              );
            },
          ),
        ],
      ),
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
