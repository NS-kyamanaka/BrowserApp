import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BottomBar extends StatelessWidget {
  final WebViewController controller;

  const BottomBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.reload(),
          ),
          TextButton(onPressed: null, child: Text("終了")),
        ],
      ),
    );
  }
}
