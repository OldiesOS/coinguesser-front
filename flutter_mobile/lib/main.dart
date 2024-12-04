import 'package:flutter/material.dart';
import 'CoinList.dart'; // CoinList.dart 파일을 임포트

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinGuesser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // 홈 화면을 HomePage로 설정
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CoinGuesser',
          style: TextStyle(
          color: Colors.white, // 글씨를 하얀색으로 설정
        ),
        ),
        backgroundColor: Colors.blue[800]
      ),
      body: Container(
        color: Colors.blue[100], // 파란색 배경 (밝은 톤)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
          children: [
            // 텍스트 추가
            const Text(
              'CoinGuesser 거라!!',
              style: TextStyle(
                fontSize: 24, // 텍스트 크기
                fontWeight: FontWeight.bold, // 텍스트 굵기
                color: Colors.blueAccent, // 텍스트 색상
              ),
            ),
            const SizedBox(height: 20), // 텍스트와 이미지 사이 간격
            // 중단 이미지 추가
            Image.asset(
              'assets/coin.png', // 이미지 경로
              width: 450, // 이미지 너비
              height: 450, // 이미지 높이
              fit: BoxFit.cover, // 이미지 비율 유지
            ), // 이미지 아래 공간 확보
            const Text(
              '코인 예측정보를 한눈에!.',
              style: TextStyle(
                fontSize: 23, // 텍스트 크기
                fontWeight: FontWeight.normal, // 텍스트 굵기
                color: Colors.blueAccent, // 텍스트 색상
              ),
              textAlign: TextAlign.center, // 텍스트 가운데 정렬
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue[800],

        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Coinlist()),
            );
          },
          child: const Text('코인 리스트 보기'),
        ),
      ),
    );
  }
}
