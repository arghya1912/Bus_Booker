import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';


class WebViewXPage extends StatefulWidget {
  const WebViewXPage({
    Key? key,
  }) : super(key: key);

  @override
  _WebViewXPageState createState() => _WebViewXPageState();
}

class _WebViewXPageState extends State<WebViewXPage> {
  late WebViewXController webviewController;
  
  Size get screenSize => MediaQuery.of(context).size;

  @override
  void dispose() {
    webviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: _buildWebViewX(),
          ),
        );
  }

  Widget _buildWebViewX() {
    WebViewX webviewx = WebViewX(
      key: const ValueKey('webviewx'),
      initialSourceType: SourceType.html,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      /*height: screenSize.height / 2,
      width: min(screenSize.width * 0.8, 1024),*/
      onWebViewCreated: (controller) { 
        webviewController = controller;
        webviewController.loadContent(
        'https://app.vectary.com/p/0vYMezW6V0YOmEUX0A7YQw',
        SourceType.url,
      );
    },
    );
    return webviewx;
  }
}

  