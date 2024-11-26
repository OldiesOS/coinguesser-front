import 'package:flutter/material.dart';
import 'prediction_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '5분 단위 예측 차트',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: PredictionChart(coinName: 'XRP'), // 인자를 전달
    );
  }
}
