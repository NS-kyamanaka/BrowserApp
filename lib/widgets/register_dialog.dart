import 'package:flutter/material.dart';
import 'package:browser_app/data/models/bookmark.dart';

class RegistDialog extends StatefulWidget {
  final void Function(Bookmark bookmark) onRegistApp;
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
      TextButton(onPressed: Navigator.of(context).pop, child: Text('キャンセル')),
      TextButton(
        onPressed: () {
          final newBookMark = Bookmark(
            _nameController.text,
            _urlController.text,
          );
          widget.onRegistApp(newBookMark);
          Navigator.of(context).pop();
        },
        child: Text('登録'),
      ),
    ];

    return AlertDialog(
      title: Text('ブックマーク登録'),
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
          SizedBox(height: 10.0),
          TextField(
            controller: _urlController,
            keyboardType: TextInputType.text,
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
