import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import '../utils/platform_registry.dart';

const _iframeId = 'iframe_screen_id';

class IframeScreen extends StatefulWidget {
  const IframeScreen({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<IframeScreen> createState() => _IframeScreenState();
}

class _IframeScreenState extends State<IframeScreen> {
  final html.IFrameElement _iframeElement = html.IFrameElement();

  @override
  void initState() {
    super.initState();
    _iframeElement.src = widget.url;
    _iframeElement.style.border = 'none';
    _iframeElement.id = _iframeId;
    platformViewRegistry.registerViewFactory(
      widget.url,
      (int viewId) => _iframeElement,
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: HtmlElementView(
            key: UniqueKey(),
            viewType: widget.url,
          ),
        ),
      ],
    );
  }
}
