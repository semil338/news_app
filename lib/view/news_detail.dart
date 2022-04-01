import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/appbar_title.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color(0xFFFAFAFA),
        title: appBarTitle("Daily News", context),
      ),
      body: WebView(
        initialUrl: widget.description,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            _controller.complete(webViewController);
          });
        },
      ),
    );
  }
}
