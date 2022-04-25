import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/ci_zium.png',
            height: 300,
          ),
          const Text(
            '문의 및 피드백',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.email),
            Text('E-mail: thezium@icloud.com', style: TextStyle(fontSize: 15))
          ])
        ],
      ),
    );
  }
}
