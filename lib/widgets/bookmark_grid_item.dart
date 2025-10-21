import 'package:browser_app/widgets/control_bookmark_button.dart';
import 'package:browser_app/widgets/favicon.dart';
import 'package:flutter/material.dart';
import 'package:browser_app/data/models/bookmark.dart';
import 'package:browser_app/screens/web_view_screen.dart';

class BookmarkGridItem extends StatelessWidget {
  final Bookmark bookmark;
  const BookmarkGridItem({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
      ),

      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(bookmark: bookmark),
            ),
          );
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Favicon(url: bookmark.url)),
                  const SizedBox(height: 8),

                  Text(
                    bookmark.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    bookmark.url,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: ControlBookmarkButton(bookmark: bookmark),
            ),
          ],
        ),
      ),
    );
  }
}
