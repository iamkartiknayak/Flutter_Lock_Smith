import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/generate_password_provider.dart';

class PasswordSlider extends StatelessWidget {
  const PasswordSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final value = context.watch<GeneratePasswordProvider>();

    return Slider(
      value: value.getValue().toInt().toDouble(),
      min: value.getMinValue(),
      max: value.getMaxValue(),
      allowedInteraction: SliderInteraction.slideThumb,
      divisions: (value.getMaxValue() - value.getMinValue()).toInt(),
      onChanged: (p0) => value.updateSliderValue(p0),
      thumbColor: Colors.teal.shade600,
      activeColor: Colors.teal,
    );
  }
}
