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
      home: CoinGuesserPage(),
    );
  }
}

class CoinGuesserPage extends StatelessWidget {
  const CoinGuesserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final currentPriceSpots = [
      FlSpot(-40, 200),
      FlSpot(-35, 250),
      FlSpot(-30, 300),
      FlSpot(-25, 280),
      FlSpot(-20, 350),
      FlSpot(-15, 330),
      FlSpot(-10, 380),
      FlSpot(-5, 370),
      FlSpot(0, 400),
      FlSpot(5, 390),
    ];

    final predictedPriceSpots = [
      FlSpot(-40, 210),
      FlSpot(-35, 260),
      FlSpot(-30, 290),
      FlSpot(-25, 300),
      FlSpot(-20, 360),
      FlSpot(-15, 320),
      FlSpot(-10, 370),
      FlSpot(-5, 360),
      FlSpot(0, 390),
      FlSpot(5, 400),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Coin Guesser'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and Date section
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.blue[100],
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

            // Graph section
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitles: (value) {
                        return '${value.toInt()}';
                      },
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitles: (value) {
                        switch (value.toInt()) {
                          case -40:
                            return '-40m';
                          case -35:
                            return '-35m';
                          case -30:
                            return '-30m';
                          case -25:
                            return '-25m';
                          case -20:
                            return '-20m';
                          case -15:
                            return '-15m';
                          case -10:
                            return '-10m';
                          case -5:
                            return '-5m';
                          case 0:
                            return '0';
                          case 5:
                            return '+5m';
                        }
                        return '';
                      },
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: currentPriceSpots,
                      isCurved: true,
                      colors: [Colors.redAccent],
                      barWidth: 3,
                    ),
                    LineChartBarData(
                      spots: predictedPriceSpots,
                      isCurved: true,
                      colors: [Colors.blue],
                      barWidth: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Prediction and Accuracy Information
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '종목코드: 336234',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '예측기간: 35',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '예측값: 7% 상승',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
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
    );
  }
}
