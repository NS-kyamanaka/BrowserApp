import 'package:browser_app/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:browser_app/data/models/bookmark.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final Bookmark bookmark;
  const WebViewScreen({super.key, required this.bookmark});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  String _currentUrl = '';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            setState(() {
              _currentUrl = url;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.bookmark.url));
    _currentUrl = widget.bookmark.url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookmark.name),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  showSaveDialog(context, ref, initialUrl: _currentUrl);
                },
                child: const Text('ブックマークに追加'),
              );
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: _controller),
      bottomNavigationBar: BottomBar(controller: _controller),
    );
  }
}

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
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("終了"),
          ),
        ],
      ),
    );
  }
}
