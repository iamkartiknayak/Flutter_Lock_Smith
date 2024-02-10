import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/generate_password_provider.dart';

class PasswordStrengthWidget extends StatelessWidget {
  const PasswordStrengthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.watch<GeneratePasswordProvider>();

    return FutureBuilder(
      future: value.getPasswordStrength(value.genPassword),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                snapshot.data!.$1,
                color: snapshot.data!.$3,
                size: 24,
              ),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  color: snapshot.data!.$3,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 4),
              ),
              Text(
                snapshot.data!.$2,
                style: TextStyle(
                  color: snapshot.data!.$3,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
