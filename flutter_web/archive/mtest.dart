import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('coin_guesser'),
          centerTitle: true,
          leading: const Icon(Icons.home),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.more_vert),
            ),
          ],
          backgroundColor: Colors.indigoAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 코인 이름과 날짜
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.purple[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Name: A_Coin',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Date: 2024 / 11 / 15',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 그래프 영역
              Expanded(
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(-40, 2),
                          FlSpot(-35, 3),
                          FlSpot(-30, 2.5),
                          FlSpot(-25, 4),
                          FlSpot(-20, 3.5),
                          FlSpot(-15, 5),
                          FlSpot(-10, 4.5),
                          FlSpot(-5, 5.5),
                          FlSpot(0, 4),
                          FlSpot(5, 3),
                        ],
                        isCurved: true,
                        colors: [Colors.blue],
                        barWidth: 3,
                      ),
                      LineChartBarData(
                        spots: [
                          FlSpot(-40, 1.5),
                          FlSpot(-35, 2),
                          FlSpot(-30, 1.8),
                          FlSpot(-25, 3),
                          FlSpot(-20, 2.5),
                          FlSpot(-15, 3.8),
                          FlSpot(-10, 3.5),
                          FlSpot(-5, 4),
                          FlSpot(0, 3.7),
                          FlSpot(5, 2.8),
                        ],
                        isCurved: true,
                        colors: [Colors.redAccent],
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 정보 섹션
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '종목코드: 336234',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '예측기간: 35',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '예측값: 7% 상승',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '정확도: 79%',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
