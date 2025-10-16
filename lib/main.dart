import 'package:browser_app/providers/bookmark_notifier.dart';
import 'package:browser_app/screens/bookmark_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(bookmarkListProvider.notifier).loadBookmarks();

    return MaterialApp(
      title: 'Browser App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const BookmarkListScreen(),
    );
  }
}