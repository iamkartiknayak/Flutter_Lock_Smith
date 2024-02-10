import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../provider/generate_password_provider.dart';

class PasswordBrechStateWidget extends StatelessWidget {
  const PasswordBrechStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.watch<GeneratePasswordProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 0.4,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BREACH STATE',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value.getBreachLabel(),
                    style: TextStyle(
                      color: value.getBreachLabel() == 'BREACHED'
                          ? Colors.red
                          : value.getBreachLabel() == 'SECURE'
                              ? Colors.green
                              : null,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              !value.showCircularIndicator
                  ? GestureDetector(
                      onTap: value.checkBreachState,
                      behavior: HitTestBehavior.translucent,
                      child: const Icon(
                        CupertinoIcons.restart,
                        color: Colors.teal,
                      ),
                    )
                  : const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.teal,
                        strokeWidth: 2.0,
                      ),
                    ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value.errorText,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
