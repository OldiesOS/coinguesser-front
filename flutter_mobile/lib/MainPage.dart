import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:eventsource/eventsource.dart'; // SSE 패키지를 사용합니다.

class MainPage extends StatefulWidget {
  final String coinName;
  final String url; // URL을 파라미터로 받음

  MainPage({required this.coinName, required this.url});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final WebViewController controller;

  String volume = 'Loading...';
  String time = 'Loading...';
  String increaseRate = 'Loading...';

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

    // connectToSSE 함수 호출
    connectToSSE(widget.coinName);
  }

  void connectToSSE(String coinName) async {
    try {
      final eventSource = await EventSource.connect('http://35.216.20.36:3000/API/stream/mobile/$coinName');

      print("SSE connected successfully"); // SSE 연결 성공 확인 로그 추가

      eventSource.listen(
            (event) {
          try {
            if (event.data != null) {
              print("Received event data: ${event.data}"); // 수신된 데이터 로그로 출력
              final decodedData = json.decode(event.data!);

              // "ping" 이벤트 무시 처리
              if (decodedData.containsKey('event') && decodedData['event'] == 'ping') {
                print("Received ping, ignoring...");
                return; // "ping" 이벤트는 무시하고 넘어감
              }

              // 수신된 데이터 확인
              if (decodedData != null && decodedData is Map<String, dynamic>) {
                setState(() {
                  volume = decodedData.containsKey('volume') ? decodedData['volume'].toString() : 'Unknown';
                  time = decodedData.containsKey('_time') ? decodedData['_time'].toString() : 'Unknown';
                  increaseRate = decodedData.containsKey('increase_rate') ? decodedData['increase_rate'].toString() : 'Unknown';
                });
                print("State updated with new data: volume=$volume, time=$time, increaseRate=$increaseRate");
              } else {
                print("Invalid data structure: ${event.data}");
              }
            } else {
              print("Received null data from server");
            }
          } catch (e) {
            print("Data decoding failed: $e");
          }
        },
        onError: (error) {
          print('Error in SSE connection: $error');
        },
      );
    } catch (e) {
      print("SSE connection failed: $e");
    }
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

            // Real-Time Data Display Section
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.purple[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "코인명: ${widget.coinName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "거래량: $volume",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "시간: $time",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "인상률: $increaseRate %",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
