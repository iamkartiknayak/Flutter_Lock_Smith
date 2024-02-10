import 'package:zxcvbn/zxcvbn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:word_generator/word_generator.dart';

import 'dart:math';

import '../services/password_breach_check.dart';

enum PasswordType {
  random,
  pronounceable,
}

class GeneratePasswordProvider extends ChangeNotifier {
  String _genPassword = '';
  String get genPassword => _genPassword;

  double _charLength = 12;
  final double _minCharLength = 8;
  final double _maxCharLength = 20;
  double _wordLength = 2;
  final double _maxWordLength = 6;
  final double _minWordLength = 1;
  PasswordType _passwordType = PasswordType.random;

  Random random = Random();

  String getRandomNumber() => random.nextInt(10).toString();

  void getMemorablePassword() {
    final wordGenerator = WordGenerator();

    if (_wordLength < 2) {
      String noun = wordGenerator.randomNoun();
      _genPassword = noun + getRandomNumber();
      _passwordType = PasswordType.pronounceable;
      notifyListeners();
      return;
    }

    final length = _wordLength.toInt();
    List<String> nouns = wordGenerator.randomNouns(length);

    for (int i = 0; i < length; i++) {
      nouns[i] += getRandomNumber();
    }

    _genPassword = nouns.join('-');
    _passwordType = PasswordType.pronounceable;
    notifyListeners();
  }

  void getRandomPassword() {
    final passwordGenerator = PasswordGenerator();
    final password = passwordGenerator.generatePassword(_charLength);
    _genPassword = password;
    _passwordType = PasswordType.random;
    notifyListeners();
  }

  void updateSliderValue(double value) {
    if (_passwordType == PasswordType.random) {
      _charLength = value;
      getRandomPassword();
      return;
    }

    _wordLength = value;
    getMemorablePassword();
  }

  double getValue() =>
      _passwordType == PasswordType.random ? _charLength : _wordLength;

  double getMaxValue() =>
      _passwordType == PasswordType.random ? _maxCharLength : _maxWordLength;

  double getMinValue() =>
      _passwordType == PasswordType.random ? _minCharLength : _minWordLength;

  String getContextLabel() => _passwordType == PasswordType.random
      ? 'Password characters : ${_charLength.toStringAsFixed(0)}'
      : 'Password words : ${_wordLength.toStringAsFixed(0)}';

  Future<(IconData icon, String remark, Color color)> getPasswordStrength(
      String password) async {
    late Result strength;
    late IconData icon;
    late Color color;
    late String remark;

    strength = Zxcvbn().evaluate(password);
    switch (strength.score) {
      case 0:
      case 1:
      case 2:
        icon = CupertinoIcons.xmark_shield;
        color = Colors.red;
        remark = 'Vulnerable';
        break;

      case 3:
        icon = CupertinoIcons.exclamationmark_shield;
        color = Colors.orange;
        remark = 'Weak';
        break;

      case 4:
        icon = CupertinoIcons.checkmark_shield;
        color = const Color(0xFF269E2A);
        remark = 'Strong';
        break;
    }
    return (icon, remark, color);
  }

  dynamic _breachState;
  dynamic get breachState => _breachState;

  String _errorText = '';
  String get errorText => _errorText;

  bool _showCircularIndicator = false;
  bool get showCircularIndicator => _showCircularIndicator;

  String getBreachLabel() => _breachState != null
      ? _breachState
          ? 'BREACHED'
          : 'SECURE'
      : 'UNKNOWN';

  void checkBreachState() async {
    _showCircularIndicator = true;
    notifyListeners();

    final result = await PasswordBreachCheck.isPasswordBreached(_genPassword);

    if (result is String) {
      _errorText = result;
      _breachState = null;
      _showCircularIndicator = false;
      notifyListeners();
      return;
    }

    _breachState = result;
    _showCircularIndicator = false;
    _errorText = '';
    notifyListeners();
  }
}
