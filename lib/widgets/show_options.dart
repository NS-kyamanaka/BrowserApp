import 'package:browser_app/providers/sort_settings_notifier.dart';
import 'package:browser_app/providers/view_style_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowOptions extends ConsumerWidget {
  const ShowOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDirection = ref.watch(sortDirectionProvider);
    final currentViewStyle = ref.watch(viewStyleProvider);

    final sortDirectionNotifier = ref.read(sortDirectionProvider.notifier);
    final viewStyleNotifier = ref.read(viewStyleProvider.notifier);

    return PopupMenuButton(
      icon: const Icon(Icons.settings),
      onSelected: (String result) {
        if (result == 'desc' || result == 'asc') {
          final newDirection = result == 'desc'
              ? SortDirection.desc
              : SortDirection.asc;
          sortDirectionNotifier.state = newDirection;
        } else if (result == 'list' || result == 'grid') {
          final newStyle = result == 'list' ? ViewStyle.list : ViewStyle.grid;
          viewStyleNotifier.state = newStyle;
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _optionLabel('登録日時'),
        const PopupMenuDivider(),
        _optionItem('降順（新しい順）', 'desc', currentDirection == SortDirection.desc),
        _optionItem('昇順（古い順）', 'asc', currentDirection == SortDirection.asc),
        const PopupMenuDivider(),
        _optionLabel('表示形式'),
        const PopupMenuDivider(),
        _optionItem('リスト表示', 'list', currentViewStyle == ViewStyle.list),
        _optionItem('グリッド表示', 'grid', currentViewStyle == ViewStyle.grid),
      ],
    );
  }

  //表示オプションのラベルウィジェット
  PopupMenuEntry<String> _optionLabel(String label) {
    return PopupMenuItem<String>(
      enabled: false,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      child: Text(label),
    );
  }

  //表示オプションの選択ウィジェット
  PopupMenuEntry<String> _optionItem(String optionLabel, value, bool checked){
    return PopupMenuItem<String>(
      value: value,
      child: Visibility(
        child: Row(
          children: [
            Visibility(
              visible: checked,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: const Icon(Icons.check, size: 18),
            ),
            const SizedBox(width: 8),
            Text(optionLabel),
          ],
        ),
      ),
    );
  }
}