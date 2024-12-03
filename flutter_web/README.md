
HEAD
# coinguesser-front
http 1.2.2버전을 쓰고
=======
 HEAD
# coinguesser-front
http 1.2.2버전을 쓰고 

코드에 http 패키지를 추가하였습니다.


child: actualData.isEmpty || predictedData.isEmpty
    ? Center(child: CircularProgressIndicator())
    : LineChart(getChartData()),
초기 정적으로 값을 임의로 넣고 무작위 값을 넣어서 차트 바뀌게 하는걸
동적으로 바꾸고 서버에서 요청하고 데이터 받는동안 차트 대신에 로딩아이콘이 추가되게 하였습니다.



Future<void> fetchData() async {
final url = 'http://your-server-url/api/data'; // API endpoint
final response = await http.get(Uri.parse(url));

if (response.statusCode == 200) {
final data = json.decode(response.body);
setState(() {
actualData = List<double>.from(data['actual']);
predictedData = List<double>.from(data['predicted']);
});
} else {
throw Exception('Failed to load data');
}
}
실제값과 예측값을 서버에 요청하는 코드
