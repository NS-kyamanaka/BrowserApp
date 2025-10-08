import 'package:flutter/material.dart';
import '../models/bookmark.dart';

class Content extends StatelessWidget {
  final BookMark bookmark;
  const Content({super.key, required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Text(bookmark.name), Text(bookmark.url)]);
  }
}
