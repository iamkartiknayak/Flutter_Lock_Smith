import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/generate_password_provider.dart';

class PasswordWIdget extends StatelessWidget {
  const PasswordWIdget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.watch<GeneratePasswordProvider>();

    return Text.rich(
      TextSpan(
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        children: [
          for (var char in value.genPassword.characters)
            if (RegExp(r'[0-9]').hasMatch(char))
              TextSpan(
                text: char,
                style: const TextStyle(color: Colors.deepPurpleAccent),
              )
            else if (RegExp(r'[!@#$%^&*-]').hasMatch(char))
              TextSpan(
                text: char,
                style: TextStyle(
                  color: Colors.teal.shade400,
                ),
              )
            else
              TextSpan(text: char)
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
