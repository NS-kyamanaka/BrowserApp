import 'package:flutter/material.dart';
import 'package:browser_app/data/models/bookmark.dart';

class RegistDialog extends StatefulWidget {
  final Future<void> Function(Bookmark bookmark) onSave;
  final String? initialUrl;
  final Bookmark? initialBookmark;

  const RegistDialog({
    super.key,
    required this.onSave,
    this.initialUrl,
    this.initialBookmark,
  });

  @override
  State<RegistDialog> createState() => _RegistDialogState();
}

class _RegistDialogState extends State<RegistDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialBookmark != null) {
      //登録済みを編集
      _nameController.text = widget.initialBookmark!.name;
      _urlController.text = widget.initialBookmark!.url;
    } else if (widget.initialUrl != null && widget.initialUrl!.isNotEmpty) {
      //WebViewからの登録
      _urlController.text = widget.initialUrl!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialBookmark != null;
    final titleText = isEditing ? 'ブックマーク編集' : 'ブックマーク登録';
    final buttonText = isEditing ? '保存' : '登録';

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
            id: isEditing ?  widget.initialBookmark!.id : null,
            name: _nameController.text,
            url: _urlController.text,
            date: isEditing ? widget.initialBookmark!.date : DateTime.now(),
          );

          await widget.onSave(newBookmark);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Text(buttonText),
      ),
    ];

    return AlertDialog(
      title:  Text(titleText),
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

                if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
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
