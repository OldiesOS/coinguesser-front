import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';

class PredictionChart extends StatefulWidget {
  final String coinName;

  const PredictionChart({Key? key, required this.coinName}) : super(key: key);

  @override
  _PredictionChartState createState() => _PredictionChartState();
}

class _PredictionChartState extends State<PredictionChart> {
  List<double> actualData = [];
  List<double> predictedData = [];
  List<String> timeData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void connectToSSE(String coinName) {
    final eventSource = EventSource('http://35.216.20.36:3000/API/stream/$coinName');
    // final eventSource = EventSource('http://localhost:3000/API/stream/xrp');

    eventSource.onMessage.listen((event) {
      final decodedData = json.decode(event.data);
      // print(decodedData);
      // if(decodedData['event'] == "ping") print('이것은.. 핑');
      // 조건이 맞지 않으면 데이터를 추가하지 않음

      if (decodedData['_time'] != null && // null 확인
          (timeData.isEmpty || decodedData['_time'] != timeData.last)) {
        print('Received SSE data: ${event.data}');

          setState(() {
            if (actualData.length >= 7) actualData.removeAt(0);
            if (predictedData.length >= 7) predictedData.removeAt(0);
            if (timeData.length >= 7) timeData.removeAt(0);

            actualData.insert(11, decodedData['ex_real_value'] ?? double.nan);

            // 새로운 데이터 추가
            actualData.add(double.nan);
            predictedData.add(decodedData['predicted_value'] ?? double.nan);
            timeData.add(decodedData['_time'] ?? ''); // 시간이 없는 경우 빈 문자열 추가
          });
        }

    });

    eventSource.onError.listen((error) {
      print('Error in SSE connection: $error');
    });
  }

  Future<void> fetchData() async {
    final url = 'http://35.216.20.36:3000/API/${widget.coinName}';
    // final url = 'http://localhost:3000/API/xrp';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data['data']);
      setState(() {
        actualData = List<double>.from(data['data']
            .map((item) => item['real_value'] != null ? item['real_value'] : double.nan));
        predictedData = List<double>.from(
            data['data'].map((item) => item['predicted_value'] ?? 0.0));
        timeData = List<String>.from(data['data'].map((item) => item['_time']));
      });
    } else {
      throw Exception('Failed to load data');
    }
    print(actualData.length);
    connectToSSE(widget.coinName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.coinName} 5분 단위 예측 차트'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '실제 데이터와 예측 데이터 (${widget.coinName})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: actualData.isEmpty || predictedData.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : LineChart(getChartData()),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData getChartData() {
    return LineChartData(
      minX: 0,
      maxX: timeData.length.toDouble() - 1,
      minY: (predictedData.where((value) => !value.isNaN).toList() +
          actualData.where((value) => !value.isNaN).toList())
          .reduce(min) - 0.5,
      maxY: (predictedData.where((value) => !value.isNaN).toList() +
          actualData.where((value) => !value.isNaN).toList())
          .reduce(max) + 0.5,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < timeData.length) {
                return Text(timeData[value.toInt()]);
              } else {
                return Text('');
              }
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
              .where((e) => !e.value.isNaN)
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
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
          dashArray: [5, 5],
        ),
      ],
    );
  }
}