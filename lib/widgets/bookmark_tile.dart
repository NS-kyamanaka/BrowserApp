import 'package:flutter/material.dart';
import '../models/bookmark.dart';
import 'package:browser_app/screens/web_view_screen.dart';

class Content extends StatelessWidget {
  final Bookmark bookmark;
  const Content({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(bookmark: bookmark),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bookmark.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Text(bookmark.url),
            ],
          ),
        ),
      ),
    );
  }
}
