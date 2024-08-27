import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class PasswordStrengthWidget extends StatelessWidget {
  const PasswordStrengthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final strength = context.select((HomeProvider p) => p.passwordStrength);
    final color = strength[StrengthMetrics.color];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          strength[StrengthMetrics.icon],
          color: color,
          size: 24,
        ),
        Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4),
        ),
        Text(
          strength[StrengthMetrics.remarks],
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 32.0)
      ],
    );
  }
}
