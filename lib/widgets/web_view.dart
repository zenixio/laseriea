import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:laseriea/utils/logger_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LoggerService.log(tag: 'WebViewScreen', message: 'WebViewScreen url: ${widget.url}');
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      const Factory(EagerGestureRecognizer.new),
    };
    return Column(
      children: [
        AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Expanded(
          child: WebViewWidget(
            controller: controller,
            gestureRecognizers: gestureRecognizers,
          ),
        ),
      ],
    );
  }
}
