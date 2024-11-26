import 'package:flutter/material.dart';
import 'MainPage.dart';

class Coinlist extends StatelessWidget {
  const Coinlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('종목 리스트'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: CoinList(),
    );
  }
}

class CoinList extends StatelessWidget {
  final List<String> coins = [
    'A_coin',
    'B_coin',
    'C_coin',
    'D_coin',
    'E_coin',
    'F_coin',
    'G_coin',
    'H_coin',
    'I_coin',
    'L_coin',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(coinName: coins[index], url: 'http://google.com'), // 임시로 구글사이트 해둠
                //builder: (context) => MainPage(coinName: coins[index], url: 'http://35.216.20.36:3000/${coins[index]}'),
                // http://35.216.20.36:3000 << 우리 서버주소 url 에 그래프 url ㄱㄱ 하면 됨
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '${index + 1}. ${coins[index]}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
