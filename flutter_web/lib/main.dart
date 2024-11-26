import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<double> actualData = [];
  List<double> predictedData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = 'http://35.216.20.36:3000/API/xrp'; // API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);

      // Parse actual and predicted data
      setState(() {
        String coin = data['coin'];
        print(coin);
        actualData = List<double>.from(data['actual']);
        predictedData = List<double>.from(data['predicted']);
      });
    } else {
      throw Exception('Failed to load data');
    }
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
            child: actualData.isEmpty || predictedData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : LineChart(
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
          onPressed: fetchData,  // Manually trigger data refresh
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
