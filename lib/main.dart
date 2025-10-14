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

// class TopPage extends StatefulWidget {
//   final String title;
//   const TopPage({super.key, required this.title});

//   @override
//   State<TopPage> createState() => _TopPageState();
// }

// class _TopPageState extends State<TopPage> {
//   final List<Bookmark> _list;

//   void _registBookMark(Bookmark bookmark) {
//     setState(() {
//       _list.add(bookmark);
//     });
//   }

//   void _showRegistDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return RegistDialog(onRegistApp: _registBookMark);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           widget.title,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           border: Border(top: BorderSide(color: Colors.grey)),
//         ),
//         child: ListView.builder(
//           itemCount: _list.length,
//           itemBuilder: (context, index) {
//             final Bookmark currentBookmark = _list[index];
//             return Content(bookmark: currentBookmark);
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showRegistDialog(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
