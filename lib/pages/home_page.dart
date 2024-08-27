import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_button.dart';
import '../providers/home_provider.dart';
import '../widgets/breach_status_indicator.dart';
import '../widgets/password_length_slider.dart';
import '../widgets/password_strength_widget.dart';
import '../widgets/password_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('HomePage build is called');
    final homeProvider = context.read<HomeProvider>();
    homeProvider.initValues();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LOCK \$MITH'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Spacer(),
            const PasswordWidget(),
            const SizedBox(height: 4.0),
            const PasswordStrengthWidget(),
            const SizedBox(height: 36.0),
            const BreachStatusIndicator(),
            const Spacer(),
            const PasswordLengthSlider(),
            CustomButton(
              onTap: homeProvider.generateRandomPassword,
              label: 'Random Password',
            ),
            CustomButton(
              onTap: homeProvider.generateMemorablePassword,
              label: 'Memorable Password',
            ),
          ],
        ),
      ),
    );
  }
}
