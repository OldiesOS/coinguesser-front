import 'package:flutter/material.dart';
import 'prediction_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> coinNames = [
    'XRP',
    'ADA',
    'BTC',
    'SOL',
    'BCH',
    'BRETT',
    'ETH',
    'ONDO',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '5분 단위 예측 차트',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/XRP', // 초기 경로 설정
      routes: {
        for (String coin in coinNames)
          '/$coin': (context) => PredictionChart(coinName: coin), // 각 코인에 대한 라우트 생성
      },
    );
  }
}