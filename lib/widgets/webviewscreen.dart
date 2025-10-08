import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:browser_app/widgets/bottombar.dart';

class WebViewScreen extends StatefulWidget {
  final String initialUrl;
  const WebViewScreen({super.key, required this.initialUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("WebView")),
      body: WebViewWidget(controller: _controller),
      bottomNavigationBar: BottomBar(controller: _controller),
    );
  }
}
