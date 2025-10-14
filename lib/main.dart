import 'package:browser_app/widgets/registerdialog.dart';
import 'package:flutter/material.dart';
import 'package:browser_app/models/bookmark.dart';
import 'package:browser_app/widgets/content.dart';

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
      home: const TopPage(title: 'ブックマーク一覧'),
    );
  }
}

class TopPage extends StatefulWidget {
  final String title;
  const TopPage({super.key, required this.title});

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  final List<BookMark> _list = [
    BookMark('Google', 'https://www.google.com/'),
    BookMark('Yahoo', 'https://yahoo.co.jp/'),
  ];

  void _registBookMark(BookMark bookMark) {
    setState(() {
      _list.add(bookMark);
    });
  }

  void _showRegistDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return RegistDialog(onRegistApp: _registBookMark);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey)),
        ),
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final BookMark currentBookMark = _list[index];
            return Content(bookmark: currentBookMark);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showRegistDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
