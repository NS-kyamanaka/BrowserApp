import 'package:browser_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:browser_app/data/models/bookmark.dart';

class ControlBookmarkButton extends ConsumerWidget {
  final Bookmark? bookmark;
  const ControlBookmarkButton({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (String result) {
        if (result == 'edit') {
          showSaveDialog(context, ref, bookmark: bookmark);
        } else if (result == 'delete') {
          showDeleteDialog(context, ref, bookmark: bookmark!);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(value: 'edit', child: Text('編集')),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('削除', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
