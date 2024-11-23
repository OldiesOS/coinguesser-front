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
        title: const Text('CoinGuesser'),
      ),
      body: Center(
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
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
