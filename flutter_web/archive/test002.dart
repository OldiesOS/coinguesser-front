/*
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
  final List<FlSpot> currentPriceSpots = [
    FlSpot(-40, 2),
    FlSpot(-35, 2.5),
    FlSpot(-30, 3),
    FlSpot(-25, 2.7),
    FlSpot(-20, 3.5),
    FlSpot(-15, 3.2),
    FlSpot(-10, 3.8),
    FlSpot(-5, 3.6),
    FlSpot(0, 4),
    FlSpot(5, 3.8),
  ];

  final List<FlSpot> predictedPriceSpots = [
    FlSpot(-40, 2.1),
    FlSpot(-35, 2.6),
    FlSpot(-30, 2.9),
    FlSpot(-25, 3.1),
    FlSpot(-20, 3.6),
    FlSpot(-15, 3.4),
    FlSpot(-10, 3.9),
    FlSpot(-5, 3.7),
    FlSpot(0, 4.2),
    FlSpot(5, 4),
  ];

  @override
  Widget build(BuildContext context) {
    double predictionPercentage = 7; // 예측 상승률 (%)
    double accuracyPercentage = 79; // 정확도 (%)

    return Scaffold(
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
        backgroundColor: Colors.purpleAccent,
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
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, _) {
                          switch (value.toInt()) {
                            case -40:
                              return const Text('-40m');
                            case -35:
                              return const Text('-35m');
                            case -30:
                              return const Text('-30m');
                            case -25:
                              return const Text('-25m');
                            case -20:
                              return const Text('-20m');
                            case -15:
                              return const Text('-15m');
                            case -10:
                              return const Text('-10m');
                            case -5:
                              return const Text('-5m');
                            case 0:
                              return const Text('0');
                            case 5:
                              return const Text('+5m');
                          }
                          return const Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    // 현종가 그래프 (빨간색)
                    LineChartBarData(
                      spots: currentPriceSpots,
                      isCurved: true,
                      colors: [Colors.redAccent],
                      barWidth: 3,
                    ),
                    // 예측종가 그래프 (파란색)
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

            // 정보 섹션
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  infoRow('종목코드', '336234'),
                  const SizedBox(height: 8),
                  infoRow('예측기간', '35'),
                  const SizedBox(height: 8),
                  infoRow('예측값', '$predictionPercentage% 상승'),
                  const SizedBox(height: 8),
                  infoRow('정확도', '$accuracyPercentage%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to create info rows
  Widget infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
*/
