import 'package:flutter/material.dart';

class RegistDialog extends StatefulWidget {
  const RegistDialog({super.key});

  @override
  State<RegistDialog> createState() => _RegistDialogState();
}

class _RegistDialogState extends State<RegistDialog> {
  final a = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> actions = [
      TextButton(onPressed: null, child: Text('キャンセル')),
      TextButton(
        onPressed: () => debugPrint('clicked register'),
        child: Text('登録'),
      ),
    ];

    return AlertDialog(
      title: Text('ブックマーク登録'),
      //content: TextField(controller: a),
      content: Column(
        children: [
          TextField(controller: a),
          TextField(controller: a),
        ],
      ),
      actions: actions,
    );
  }
}
