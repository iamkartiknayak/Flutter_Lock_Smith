import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/home_provider.dart';

class PasswordLengthSlider extends StatelessWidget {
  const PasswordLengthSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint('PasswordLengthSlider build is called');

    final (value, minValue, maxValue, contextLabel) = context.select(
      (HomeProvider p) => (
        p.sliderValue,
        p.sliderMinValue,
        p.sliderMaxValue,
        p.contextLabel,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Slider(
          value: value,
          min: minValue,
          max: maxValue,
          divisions: (maxValue - minValue).toInt(),
          onChanged: context.read<HomeProvider>().updateSliderValue,
          thumbColor: Colors.teal.shade600,
          activeColor: Colors.teal,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          child: Text(
            contextLabel,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
