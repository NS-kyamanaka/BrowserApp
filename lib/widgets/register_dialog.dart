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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      TextButton(
        onPressed: Navigator.of(context).pop,
        child: const Text('キャンセル'),
      ),
      TextButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          final newBookmark = Bookmark(
            id: null,
            name: _nameController.text,
            url: _urlController.text,
            date: DateTime.now(),
          );
          await widget.onRegistApp(newBookmark);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: const Text('登録'),
      ),
    ];

    return AlertDialog(
      title: const Text('ブックマーク登録'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: '登録名',
                hintText: '登録名を入力してください',
                errorMaxLines: 2,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '登録名は必須項目です。';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              controller: _urlController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                labelText: 'URL',
                hintText: 'URLを入力してください',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'URLは必須項目です';
                }

                final uri = Uri.tryParse(value);

                if (uri == null ||!uri.hasScheme || uri.host.isEmpty) {
                  return '有効なURL形式ではありません。';
                }

                if (uri.scheme.toLowerCase() != 'https') {
                  return 'URLの入力を確認してください。';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
