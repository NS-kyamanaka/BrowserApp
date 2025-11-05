import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:browser_app/providers/sort_settings_notifier.dart';
import 'package:browser_app/providers/view_style_provider.dart';
import 'package:browser_app/widgets/bookmark_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:browser_app/widgets/bookmark_tile.dart';
import 'package:browser_app/data/models/bookmark.dart';
import 'package:browser_app/widgets/search_input_field.dart';
import 'package:browser_app/utils/dialog_utils.dart';
import 'package:browser_app/widgets/show_options.dart';

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(sortedAndFilteredBookmarkListProvider);
    final currentViewStyle = ref.watch(viewStyleProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ブックマーク一覧'),
        actions: [ShowOptions()],
      ),
      body: Column(
        children: [
          const SearchInputField(),
          Expanded(
            child: currentViewStyle == ViewStyle.list
                ? _listBookmarks(context, bookmarks, ref)
                : _gridBookmarks(context, bookmarks),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSaveDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listBookmarks(
    BuildContext context,
    List<Bookmark> bookmarks,
    WidgetRef ref,
  ) {
    return Container(
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
    );
  }

  Widget _gridBookmarks(
    BuildContext context,
    List<Bookmark> bookmarks,
  ) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: bookmarks.length,
      itemBuilder: (BuildContext context, int index) {
        final Bookmark currentBookmark = bookmarks[index];
        return BookmarkGridItem(bookmark: currentBookmark);
      },
    );
  }
}