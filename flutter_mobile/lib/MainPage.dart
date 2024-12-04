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
  String updown = 'Loading...'; // 올바른 타입으로 선언

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
      ..enableZoom(true) // 줌 기능 활성화
      ..loadRequest(Uri.parse(widget.url)); // URL을 widget.url에서 불러옴

    // connectToSSE 함수 호출
    connectToSSE(widget.coinName);
  }

  void connectToSSE(String coinName) async {
    try {
      final eventSource =
      await EventSource.connect('http://35.216.20.36:3000/API/stream/mobile/$coinName');

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
                  volume = decodedData.containsKey('volume')
                      ? decodedData['volume'].toString()
                      : 'Unknown';
                  time = decodedData.containsKey('_time')
                      ? decodedData['_time'].toString()
                      : 'Unknown';
                  increaseRate = decodedData.containsKey('increase_rate')
                      ? decodedData['increase_rate'].toString()
                      : 'Unknown';
                  updown = decodedData.containsKey('updown')
                      ? decodedData['updown'].toString()
                      : 'Unknown';
                });
                print(
                    "State updated with new data: volume=$volume, time=$time, increaseRate=$increaseRate, updown=$updown");
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
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Name and Date Section
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.lightBlue[100],
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
              height: 430,
              width: double.infinity,
              child: WebViewWidget(controller: controller),
            ),

            SizedBox(height: 16.0),

            // Real-Time Data Display Section
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.lightBlue[50],
              child: Table(
                border: TableBorder.all(color: Colors.blueAccent, width: 1), // 테이블 테두리 추가
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.lightBlue[100]), // 헤더 색상 지정
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "INFOMATION",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "COIN_GUESSER",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "거래량",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          volume,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "시간",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          time,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "인상률",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "$increaseRate %",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "UP/DOWN",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              updown,
                              style: TextStyle(
                                fontSize: 16,
                                color: updown == "UP"
                                    ? Colors.red
                                    : (updown == "DOWN" ? Colors.blue : Colors.black),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Icon(
                              updown == "UP"
                                  ? Icons.arrow_upward
                                  : (updown == "DOWN" ? Icons.arrow_downward : Icons.remove),
                              color: updown == "UP"
                                  ? Colors.red
                                  : (updown == "DOWN" ? Colors.blue : Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
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
