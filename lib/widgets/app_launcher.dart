import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'empty_widget.dart';

class AppLauncher extends StatefulWidget {
  final String url;
  AppLauncher({@required this.url}) : assert(url != null);

  @override
  _AppLauncherState createState() => _AppLauncherState();
}

class _AppLauncherState extends State<AppLauncher> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final _key = UniqueKey();
  bool _isLoadingPage;

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              webViewController.loadUrl(widget.url);
            },
            onPageFinished: (finish) {
              setState(() {
                _isLoadingPage = false;
              });
            },
          ),
          _isLoadingPage
              ? Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : EmptyWidget(),
        ],
      ),
    );
  }
}

/*class AppLauncher extends StatelessWidget {
  final String url;
  AppLauncher({@required this.url}) : assert(url != null);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          webViewController.loadUrl(url);
        },
      ),
    );
  }
}*/
