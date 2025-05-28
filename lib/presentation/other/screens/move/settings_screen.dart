import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SettingsScreen')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.pop(); // 뒤로 가기
            },
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }
}
