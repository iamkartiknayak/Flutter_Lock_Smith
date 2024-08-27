import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:convert';

class PasswordBreachCheck {
  static Future<http.Response> requestApiData(String queryChar) async {
    final url = Uri.parse('https://api.pwnedpasswords.com/range/$queryChar');
    return await http.get(url);
  }

  static int getPasswordLeakCount(String hashes, String hashToCheck) {
    final hashList = const LineSplitter().convert(hashes);

    for (final hash in hashList) {
      final splitHash = hash.split(':');
      if (splitHash[0] == hashToCheck) {
        return int.parse(splitHash[1]);
      }
    }
    return 0;
  }

  static Future<dynamic> pwnedApiCheck(String password) async {
    final sha1Password =
        sha1.convert(utf8.encode(password)).toString().toUpperCase();
    final first5Char = sha1Password.substring(0, 5);
    final tail = sha1Password.substring(5);
    final response = await requestApiData(first5Char);

    return response.statusCode == 200
        ? getPasswordLeakCount(response.body, tail) != 0
        : 'Error fetching: ${response.statusCode}, check the API and try again!';
  }

  static Future<dynamic> checkBreach(String password) async {
    if (password.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
      return 'Password cannot be empty';
    }

    try {
      final result = await pwnedApiCheck(password);
      return result;
    } on SocketException {
      return 'Network error : Couldn\'t fetch breach state';
    }
  }
}
