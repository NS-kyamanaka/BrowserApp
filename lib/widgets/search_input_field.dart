import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchInputField extends ConsumerStatefulWidget {
  const SearchInputField({super.key});

  @override
  ConsumerState<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends ConsumerState<SearchInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initialQuery = ref.read(searchQueryProvider);
    _controller = TextEditingController(text: initialQuery);
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    ref.read(searchQueryProvider.notifier).state = _controller.text;
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuery = ref.watch(searchQueryProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: '名前またはURLで検索',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: currentQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    FocusScope.of(context).unfocus();
                  },
                )
              : null,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
        ),
      ),
    );
  }
}
