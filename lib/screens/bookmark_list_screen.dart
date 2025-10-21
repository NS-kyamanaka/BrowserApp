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

class BookmarkListScreen extends ConsumerWidget {
  const BookmarkListScreen({super.key});

  Widget _buildSortButton(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentDirection = ref.watch(sortDirectionProvider);
        final currentViewStyle = ref.watch(viewStyleProvider);

        final sortDirectionNotifier = ref.read(sortDirectionProvider.notifier);
        final viewStyleNotifier = ref.read(viewStyleProvider.notifier);

        return PopupMenuButton<String>(
          icon: const Icon(Icons.sort),
          onSelected: (String result) {
            if (result == 'desc' || result == 'asc') {
              final newDirection = result == 'desc'
                  ? SortDirection.desc
                  : SortDirection.asc;
              sortDirectionNotifier.state = newDirection;
            } else if (result == 'list' || result == 'grid') {
              final newStyle = result == 'list'
                  ? ViewStyle.list
                  : ViewStyle.grid;
              viewStyleNotifier.state = newStyle;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              enabled: false,
              child: Text(
                '登録日時',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'desc',
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
            PopupMenuItem<String>(
              value: 'asc',
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
            const PopupMenuDivider(),
            const PopupMenuItem<String>(
              enabled: false,
              child: Text(
                '表示形式',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            const PopupMenuDivider(),
            PopupMenuItem<String>(
              value: 'list',
              child: Row(
                children: [
                  Visibility(
                    visible: currentViewStyle == ViewStyle.list,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: const Icon(Icons.check, size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Text('リスト表示'),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'grid',
              child: Row(
                children: [
                  Visibility(
                    visible: currentViewStyle == ViewStyle.grid,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: const Icon(Icons.check, size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Text('グリッド表示'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarks = ref.watch(sortedAndFilteredBookmarkListProvider);
    final currentViewStyle = ref.watch(viewStyleProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ブックマーク一覧'),
        actions: [_buildSortButton(context)],
      ),
      body: Column(
        children: [
          const SearchInputField(),
          Expanded(
            child: currentViewStyle == ViewStyle.list
                ? _listSample(context, bookmarks, ref)
                : _gridSample(context, bookmarks, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSaveDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _listSample(
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

  Widget _gridSample(
    BuildContext context,
    List<Bookmark> bookmarks,
    WidgetRef ref,
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
