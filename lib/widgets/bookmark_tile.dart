import 'package:flutter/material.dart';
import '../data/models/bookmark.dart';
import 'package:browser_app/screens/web_view_screen.dart';

class BookmarkTile extends StatelessWidget {
  final Bookmark bookmark;
  const BookmarkTile({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1.0)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(bookmark: bookmark),
            ),
          );
        },
        title: Text(
          bookmark.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        subtitle: Text(bookmark.url),
      ),
    );
  }
}
