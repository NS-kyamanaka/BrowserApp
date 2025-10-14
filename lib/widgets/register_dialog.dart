import 'package:flutter/material.dart';
import 'package:browser_app/data/models/bookmark.dart';

class RegistDialog extends StatefulWidget {
  final Future<void> Function(Bookmark bookmark) onRegistApp;
  const RegistDialog({super.key, required this.onRegistApp});

  @override
  State<RegistDialog> createState() => _RegistDialogState();
}

class _RegistDialogState extends State<RegistDialog> {
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('キャンセル'),
      ),
      TextButton(
        onPressed: () async {
          if (_nameController.text.isEmpty || _urlController.text.isEmpty) {
            //TODO バリデーションチェック
            return;
          }
          final newBookmark = Bookmark(
            id : null,
            name: _nameController.text,
            url: _urlController.text,
            date: DateTime.now(),
          );
          //await widget.onRegistApp(newBookMark);
          await widget.onRegistApp(newBookmark);
          Navigator.of(context).pop();
        },
        child: const Text('登録'),
      ),
    ];

    return AlertDialog(
      title: const Text('ブックマーク登録'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              labelText: '登録名',
              hintText: '登録名を入力してください',
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              labelText: 'URL',
              hintText: 'URLを入力してください',
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }
}
