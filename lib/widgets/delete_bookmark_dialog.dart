import 'package:browser_app/data/models/bookmark.dart';
import 'package:flutter/material.dart';

class DeleteBookmarkDialog extends StatelessWidget {
    final Bookmark bookmark;
  final Future<void> Function(Bookmark bookmark) delete;

  const DeleteBookmarkDialog({super.key, required this.delete, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('キャンセル'),
      ),
      TextButton(
        onPressed: () async{
          await delete(bookmark);
          if(context.mounted){
            Navigator.of(context).pop();
          }
        },
        child: const Text('削除', style: TextStyle(color: Colors.red)),
      ),
    ];

    return AlertDialog(
      title: const Text('ブックマーク削除'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('登録名', style: TextStyle(color: Colors.black54, fontSize: 14),),
          Text(bookmark.name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
          const SizedBox(height: 16.0,),
          const Text('URL', style: TextStyle(color: Colors.black54, fontSize: 14),),
          Text(
            bookmark.url,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),),
        ],

      ),
      actions: actions);
  }
}
