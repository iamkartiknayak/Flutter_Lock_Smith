import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './pages/home_page.dart';
import './provider/generate_password_provider.dart';

void main() => runApp(const PasswordGenerator());

class PasswordGenerator extends StatelessWidget {
  const PasswordGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneratePasswordProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),
        title: 'Password Generator',
        home: const HomePage(),
      ),
    );
  }
}
