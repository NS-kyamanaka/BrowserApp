import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/bookmark.dart';
import '../providers/bookmark_notifier.dart';
import '../widgets/register_dialog.dart';

void showRegistDialog(BuildContext context, WidgetRef ref,{String? initialUrl}) {
    final notifier = ref.read(bookmarkListProvider.notifier);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return RegistDialog(
          initialUrl: initialUrl,
          onRegistApp: (Bookmark bookmark) async {
            await notifier.addBookmark(bookmark);
          },
        );
      },
    );
  }