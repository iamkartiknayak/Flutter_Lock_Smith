import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_generator/word_generator.dart';
import 'package:zxcvbn/zxcvbn.dart';

import '../services/password_breach_check.dart';

enum PasswordType {
  random,
  memorable,
}

enum StrengthMetrics {
  icon,
  color,
  remarks,
}

class HomeProvider extends ChangeNotifier {
  // getters
  FocusNode get focusNode => _focusNode;
  TextEditingController get controller => _controller;

  String get generatedPassword => _generatedPassword;
  String get errorText => _errorText;
  String get breachStatus => _breachStatus;
  Color get breachStatusColor => _breachStatusColor;
  bool get checkingBreachState => _checkingBreachState;
  bool get customPasswordEnabled => _customPasswordEnabled;

  Map<StrengthMetrics, dynamic> get passwordStrength => _passwordStrength;
  double get sliderValue => _isRandomPassword ? _charLength : _wordLength;
  double get sliderMaxValue => _isRandomPassword ? 20 : 6;
  double get sliderMinValue => _isRandomPassword ? 8 : 1;

  String get contextLabel => _isRandomPassword
      ? 'Password characters : ${_charLength.toInt()}'
      : 'Password words : ${_wordLength.toInt()}';

  // private var
  late FocusNode _focusNode;
  late TextEditingController _controller;

  String _generatedPassword = '';
  String _errorText = '';
  String _breachStatus = 'UNKOWN';
  Color _breachStatusColor = Colors.grey.shade700;
  bool _checkingBreachState = false;
  bool _customPasswordEnabled = false;

  Map<StrengthMetrics, dynamic> _passwordStrength = {
    StrengthMetrics.icon: CupertinoIcons.checkmark_shield,
    StrengthMetrics.color: Colors.greenAccent,
    StrengthMetrics.remarks: 'Strong',
  };

  double _charLength = 12;
  double _wordLength = 2;
  bool _isRandomPassword = true;

  final _wordGenerator = WordGenerator();
  final passwordGenerator = PasswordGenerator();
  final _random = Random();
  bool _isInitialized = false;

  // public methods
  void initValues() {
    if (_isInitialized) return;

    Future(() => generateRandomPassword());
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _isInitialized = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void toggleCustomPassword(bool toggleValue) {
    _customPasswordEnabled = toggleValue;
    if (_customPasswordEnabled) {
      _controller.text = _generatedPassword;
      _focusNode.requestFocus();
    } else {
      _controller.clear();
      _focusNode.unfocus();
    }

    if (_generatedPassword.isEmpty) {
      _isRandomPassword
          ? generateRandomPassword()
          : generateMemorablePassword();
      return;
    }

    notifyListeners();
  }

  void generateRandomPassword() {
    _generatedPassword = passwordGenerator.generatePassword(_charLength);
    _isRandomPassword = true;
    _calculatePasswordStrength();
  }

  void generateMemorablePassword() {
    final randomNumber = _random.nextInt(10).toString();

    switch (_wordLength) {
      case 1:
        String noun = _wordGenerator.randomNoun();
        _generatedPassword = noun + randomNumber;
        break;

      default:
        final length = _wordLength.toInt();
        List<String> nouns = _wordGenerator.randomNouns(length);

        for (int i = 0; i < length; i++) {
          nouns[i] += randomNumber;
        }
        _generatedPassword = nouns.join('-');
    }

    _isRandomPassword = false;
    _calculatePasswordStrength();
  }

  void updateSliderValue(double value) {
    _breachStatus = 'UNKNOWN';
    _breachStatusColor = Colors.grey.shade700;

    if (_isRandomPassword) {
      _charLength = value;
      generateRandomPassword();
      return;
    }

    _wordLength = value;
    generateMemorablePassword();
  }

  void checkBreachState() async {
    _checkingBreachState = true;
    notifyListeners();

    final result = await PasswordBreachCheck.checkBreach(_generatedPassword);
    _checkingBreachState = false;

    if (result is String) {
      _errorText = result;
      _breachStatus = 'UNKNOWN';
      _breachStatusColor = Colors.grey.shade700;
      _errorText = result;
      notifyListeners();
      return;
    }

    _breachStatus = result ? 'BREACHED' : 'SECURE';
    _breachStatusColor = result ? Colors.red : const Color(0xFF269E2A);
    _errorText = '';
    notifyListeners();
  }

  void handleKeyPress(String value) {
    if (!customPasswordEnabled) return;

    _generatedPassword = value;
    _calculatePasswordStrength();
  }

  // private methods
  void _calculatePasswordStrength() {
    _breachStatus = 'UNKNOWN';
    _breachStatusColor = Colors.grey.shade700;

    if (_generatedPassword.isEmpty) {
      notifyListeners();
      return;
    }

    late IconData icon;
    late Color color;
    late String remark;

    final strength = Zxcvbn().evaluate(_generatedPassword);
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

    _passwordStrength = {
      StrengthMetrics.icon: icon,
      StrengthMetrics.color: color,
      StrengthMetrics.remarks: remark,
    };
    notifyListeners();
  }
}
