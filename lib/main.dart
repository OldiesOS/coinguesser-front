import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('종목 리스트'),
          backgroundColor: Colors.purple,
          centerTitle: true,
        ),
        body: CoinList(),
      ),
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
      padding: EdgeInsets.all(8.0),
      itemCount: coins.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmptyPage(coinName: coins[index]),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              '${index + 1}. ${coins[index]}',
              style: TextStyle(
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

class EmptyPage extends StatelessWidget {
  final String coinName;

  EmptyPage({required this.coinName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(git add .
      git rebase --continue
        title: Text(coinName),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          '$coinName 페이지',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
