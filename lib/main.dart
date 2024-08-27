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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        scaffoldBackgroundColor: Colors.black,
      ),
      title: 'LockSmith',
      home: const HomePage(),
    );
  }
}
