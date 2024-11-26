import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'boxwiget1.dart';

class MainPage extends StatefulWidget {
  final String coinName;
  final String url;  // URL을 파라미터로 받음

  MainPage({required this.coinName, required this.url});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            print("Page started loading: $url");
          },
          onPageFinished: (String url) {
            print("Page finished loading: $url");
          },
          onWebResourceError: (WebResourceError error) {
            print("Error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // URL을 widget.url에서 불러옴
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy / MM / dd').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinName),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Name and Date Section
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.purple[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name: ${widget.coinName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Date: $formattedDate",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // WebView Section for Graph
            Container(
              height: 500,
              width: double.infinity,
              child: WebViewWidget(controller: controller),
            ),

            SizedBox(height: 16.0),

            // Four Boxes Section (Vertical Layout)
            Column(
              children: [
                CustomBox(name: "Box 1", content: "Content for Box 1"),
                CustomBox(name: "Box 2", content: "Content for Box 2"),
                CustomBox(name: "Box 3", content: "Content for Box 3"),
                CustomBox(name: "Box 4", content: "Content for Box 4"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
