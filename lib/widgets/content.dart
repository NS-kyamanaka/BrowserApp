import 'package:flutter/material.dart';
import '../models/bookmark.dart';
import 'package:browser_app/widgets/webviewscreen.dart';

class Content extends StatelessWidget {
  final BookMark bookmark;
  const Content({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(initialUrl: bookmark.url),
          ),
        );
      },
      child: Column(children: [Text(bookmark.name), Text(bookmark.url)]),
    );
  }
}
