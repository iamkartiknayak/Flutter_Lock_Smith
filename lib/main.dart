import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './providers/home_provider.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const LockSmith(),
    ));

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
