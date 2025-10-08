import 'package:flutter/material.dart';
import 'package:browser_app/models/bookmark.dart';
import 'package:browser_app/widgets/content.dart';

final List<BookMark> bookmarks = [
  BookMark('Google', 'https://www.google.com/'),
  BookMark('Yahoo', 'https://yahoo.co.jp/'),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Broser App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'ブックマーク一覧'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text(title)),
      body: ListView.builder(
        itemCount: bookmarks.length,
        itemBuilder: (BuildContext context, int index) {
          final BookMark currentBookMark = bookmarks[index];
          return Content(bookmark: currentBookMark);
        },
      ),
      floatingActionButton: FloatingActionButton(
        //TODO：ブックマーク登録のダイアログを開く実装
        onPressed: () => debugPrint("ボタンのクリック"),
        child: const Icon(Icons.add),
      ),
    );
  }
}
