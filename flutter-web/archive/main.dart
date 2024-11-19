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
          title: const Text('Coin Guesser'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 코인 이름과 날짜
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Coin_Name: AA_Coin',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Current_Time: 24/11/8',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
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
                          FlSpot(1, 500),
                          FlSpot(2, 700),
                          FlSpot(3, 400),
                          FlSpot(4, 600),
                          FlSpot(5, 900),
                          FlSpot(6, 1000),
                          FlSpot(7, 800),
                          FlSpot(8, 950),
                          FlSpot(9, 1100),
                        ],
                        isCurved: true,
                        colors: [Colors.blue],
                        barWidth: 3,
                      ),
                      LineChartBarData(
                        spots: [
                          FlSpot(1, 300),
                          FlSpot(2, 400),
                          FlSpot(3, 350),
                          FlSpot(4, 500),
                          FlSpot(5, 600),
                          FlSpot(6, 550),
                          FlSpot(7, 700),
                          FlSpot(8, 750),
                          FlSpot(9, 850),
                        ],
                        isCurved: true,
                        colors: [Colors.orange],
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Information 섹션
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Detail 1'),
                    Text('Detail 2'),
                    Text('Detail 3'),
                    Text('Detail 4'),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.home),
              Icon(Icons.add_chart_rounded),
              Icon(Icons.info),
            ],
          ),
        ),
      ),
    );
  }
}
