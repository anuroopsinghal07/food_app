import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('message build');
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 22.0, color: Colors.black),
        textAlign: TextAlign.center,
      ),
    );
  }
}
