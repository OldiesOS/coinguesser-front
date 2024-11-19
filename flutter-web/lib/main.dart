import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('5분 단위 예측 차트'),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PredictionChart(),
        ),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}

class PredictionChart extends StatefulWidget {
  @override
  _PredictionChartState createState() => _PredictionChartState();
}

class _PredictionChartState extends State<PredictionChart> {
  List<double> actualData = [1.2, 1.5, 1.8, 2.0, 1.9, 2.3, 2.7, 2.5, 3.0, 3.2, 3.1, 3.5];
  List<double> predictedData = [1.1, 1.4, 1.6, 2.1, 1.7, 2.2, 2.6, 2.4, 2.9, 3.1, 3.3, 3.6, 3.8];

  void updatePrediction() {
    setState(() {
      double newActual = actualData.last + (Random().nextBool() ? 1 : -1) * Random().nextDouble();
      double newPredicted = predictedData.last + (Random().nextBool() ? 1 : -1) * Random().nextDouble();

      actualData.add(newActual);
      predictedData.add(newPredicted);

      if (actualData.length > 12) {
        actualData.removeAt(0);
        predictedData.removeAt(0);
      }
    });
  }

  LineChartData getChartData() {
    return LineChartData(
      backgroundColor: Colors.white,
      minX: 0,
      maxX: predictedData.length.toDouble() - 1,
      minY: (actualData + predictedData).reduce(min) - 0.5,
      maxY: (actualData + predictedData).reduce(max) + 0.5,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() == actualData.length - 1) {
                return Text('현재');
              } else if (value.toInt() == predictedData.length - 1) {
                return Text('예측');
              } else {
                return Text('${(value.toInt() + 1) * 5}분');
              }
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(value.toStringAsFixed(1));
            },
          ),
        ),
      ),
      gridData: FlGridData(show: true),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.deepPurple),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: actualData
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue.withOpacity(0.2),
          ),
          dotData: FlDotData(show: true),
        ),
        LineChartBarData(
          spots: predictedData
              .asMap()
              .entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: true,
          color: Colors.orange,
          barWidth: 3,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.orange.withOpacity(0.2),
          ),
          dotData: FlDotData(show: true),
          dashArray: [5, 5],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '실제 데이터와 예측 데이터',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: LineChart(
              getChartData(),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          '파란색: 실제 데이터, 주황색: 예측 데이터',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: updatePrediction,
          icon: Icon(Icons.update),
          label: Text('5분 후 예측 업데이트'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
        ),
      ],
    );
  }
}
