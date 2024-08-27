import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class BuildGeneratedPassword extends StatelessWidget {
  const BuildGeneratedPassword({
    super.key,
    required this.password,
  });

  final String password;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<HomeProvider>().toggleCustomPassword(true),
        child: password.isEmpty
            ? const Text(
                '\$tart typing p@ssword...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              )
            : Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    for (var char in password.characters)
                      if (RegExp(r'[0-9]').hasMatch(char))
                        TextSpan(
                          text: char,
                          style: const TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
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
              ),
      ),
    );
  }
}
