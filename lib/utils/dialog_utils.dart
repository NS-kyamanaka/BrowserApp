import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/bookmark.dart';
import '../providers/bookmark_notifier.dart';
import '../widgets/register_dialog.dart';

void showSaveDialog(
  BuildContext context,
  WidgetRef ref, {
  Bookmark? bookmark,
  String? initialUrl,
}) {
  final notifier = ref.read(bookmarkListProvider.notifier);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return RegistDialog(
        initialBookmark: bookmark,
        initialUrl: initialUrl,

        onSave: (Bookmark bookmark) async {
          if (bookmark.id == null) {
            await notifier.addBookmark(bookmark);
          } else {
            await notifier.editBookmark(bookmark);
          }
        },
      );
    },
  );
}
