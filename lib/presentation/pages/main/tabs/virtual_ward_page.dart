import 'package:flutter/material.dart';

/// 虚拟病房页面
class VirtualWardPage extends StatelessWidget {
  const VirtualWardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_hospital, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Virtual Ward',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '虚拟病房功能待实现',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
