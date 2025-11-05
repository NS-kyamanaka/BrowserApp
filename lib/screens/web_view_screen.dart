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
  final _searchController = TextEditingController();

  void _googleSearchSubmit(String text) {
    if (text.isEmpty) {
      return;
    }

    final encodedQuery = Uri.encodeComponent(text);
    final String link = 'https://www.google.com/search?q=$encodedQuery';
    Bookmark temp = Bookmark.create(name: text, url: link);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(bookmark: temp)),
    );
  }

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Google検索',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
            ),
            onSubmitted: _googleSearchSubmit,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () {
                  showSaveDialog(context, ref, initialUrl: _currentUrl);
                },
                child: const Text('ブックマークに登録'),
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

  Widget _operateButton({
    required Icon icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _operateButton(
            icon: const Icon(Icons.arrow_back),
            label: '戻る',
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
          ),
          _operateButton(
            icon: const Icon(Icons.arrow_forward),
            label: '進む',
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              }
            },
          ),
          _operateButton(
            icon: const Icon(Icons.refresh),
            label: '更新',
            onPressed: () => controller.reload(),
          ),
          _operateButton(
            icon: const Icon(Icons.close),
            label: '終了',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
