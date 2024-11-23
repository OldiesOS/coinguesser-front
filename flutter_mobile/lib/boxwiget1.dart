import 'package:flutter/material.dart';

// CustomBox 클래스 추가
class CustomBox extends StatelessWidget {
  final String name;
  final String content;

  const CustomBox({
    Key? key,
    required this.name,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.purple, width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main Page")),
      body: Expanded(
        child: Column(
          children: [
            CustomBox(name: "Box 1", content: "Content for Box 1"),
            CustomBox(name: "Box 2", content: "Content for Box 2"),
            CustomBox(name: "Box 3", content: "Content for Box 3"),
            CustomBox(name: "Box 4", content: "Content for Box 4"),
          ],
        ),
      ),
    );
  }
}

