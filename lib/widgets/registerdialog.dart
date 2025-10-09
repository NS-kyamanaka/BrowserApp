import 'package:flutter/material.dart';
import 'package:browser_app/models/bookmark.dart';

class RegistDialog extends StatefulWidget {
  final void Function(BookMark bookMark) onRegistApp;
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
          final newBookMark = BookMark(
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
        children: [
          TextField(controller: _nameController),
          TextField(controller: _urlController),
        ],
      ),
      actions: actions,
    );
  }
}
