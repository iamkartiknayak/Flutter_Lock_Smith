import 'package:flutter/material.dart';

void main() => runApp(const LockSmith());

class LockSmith extends StatelessWidget {
  const LockSmith({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LockSmith',
      home: Scaffold(
        body: Center(
          child: Text('LockSmith'),
        ),
      ),
    );
  }
}
