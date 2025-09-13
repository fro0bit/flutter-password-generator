import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';

String generatePassword(int lenght, bool? includeUpper, bool? includeLower, bool? includeNums, bool? includeSpecial, context) {
    const lower = 'abcdefghijklmnopqrstuvwyuz';
    const upper = 'ABCDEFGHIJKLMNOPQRSTUVWYUZ';
    const numbers = '0123456789';
    const specialCharacters = '(){}!?[]-*/:;§.,=´+@&#°~|€<>';

    String chars = '';
    if (includeLower != null) if (includeLower) chars += lower;
    if (includeUpper != null) if (includeUpper) chars += upper;
    if (includeNums != null)  if (includeNums) chars += numbers;
    if (includeSpecial != null) if (includeSpecial) chars += specialCharacters;

    if (chars.isEmpty) {
      if (Platform.isAndroid || Platform.isIOS) {
       showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('You must have at least one box checked.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
        barrierDismissible: false,

       );
      } else {
        var snackBar = SnackBar(
          content: const Text('You must have at least one box checked.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    if (chars.isNotEmpty) {
      final random = Random.secure();
      return List.generate(lenght, (index) => chars[random.nextInt(chars.length)]).join();
    }
    return '';

}