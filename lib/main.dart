import 'package:flutter/material.dart';
import 'package:lock_smith/pages/home_page.dart';

void main() => runApp(const LockSmith());

class LockSmith extends StatelessWidget {
  const LockSmith({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LockSmith',
      home: HomePage(),
    );
  }
}
