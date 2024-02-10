import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';
import '../widgets/password_slider.dart';
import '../widgets/password_widget.dart';
import '../widgets/password_strength_widget.dart';
import '../provider/generate_password_provider.dart';
import '../widgets/password_breach_state_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future(() => context.read<GeneratePasswordProvider>().getRandomPassword());
    return Scaffold(
      body: SafeArea(
        child: Consumer<GeneratePasswordProvider>(builder: (
          context,
          value,
          _,
        ) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Password Generator',
                  style: TextStyle(fontSize: 22),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Expanded(
                      child: PasswordWIdget(),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        final isLightTheme =
                            Theme.of(context).brightness == Brightness.light;
                        _showSnackBar(context, isLightTheme);
                        Clipboard.setData(
                          ClipboardData(text: value.genPassword),
                        );
                      },
                      child: const Icon(
                        CupertinoIcons.square_on_square,
                        color: Colors.teal,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const PasswordStrengthWidget(),
                const SizedBox(height: 40),
                const PasswordBrechStateWidget(),
                const Spacer(),
                const PasswordSlider(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    bottom: 10,
                  ),
                  child: Text(
                    value.getContextLabel(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                CustomButton(
                  onTap: value.getRandomPassword,
                  label: 'Random Password',
                ),
                CustomButton(
                  onTap: value.getMemorablePassword,
                  label: 'Memorable Password',
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, bool isLightTheme) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isLightTheme ? Colors.white : Colors.black,
        content: Text(
          'Copied to clipboard',
          style: TextStyle(
            color: isLightTheme ? Colors.black : Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
      ),
    );
