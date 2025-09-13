import 'dart:io';
import 'package:flutter/material.dart';
import 'package:password_generator/models/password.dart';
import 'package:password_generator/shared/styled_button.dart';
import 'package:flutter/services.dart';
import 'package:password_generator/shared/styled_text.dart';
import 'package:password_generator/shared/theme.dart';

void main() {
  runApp(MaterialApp(
    theme: appTheme,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final TextEditingController _textController = TextEditingController();
  bool? _checkedLowerCharactes = true;
  bool? _checkedUpperCharacters = false;
  bool? _checkedNumbers = false;
  bool? _specialCharacters = false;
  double _currentValue = 8;
  bool _showAppBar = false;



  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      _showAppBar = true;
    }
    return Scaffold(
        appBar: _showAppBar ? AppBar(
          title: const StyledTitle('password generator'),
          centerTitle: true,
        ) : null,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            children: [
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'your password'
                ),
              ),

              const SizedBox(height: 20),
              Slider(
                min: 4,
                value: _currentValue,
                divisions: 14,
                max: 25,
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
              Row(
                children: [
                  const StyledText('4'),
                  Spacer(),
                  StyledText('Set password length is ${_currentValue.toInt()}'),
                  Spacer(),
                  const StyledText('25')
                ],
              ),
              const SizedBox(height: 20),

              CheckboxListTile(
              
                title: const StyledHeading('Include lowercase'),
                value: _checkedLowerCharactes,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _checkedLowerCharactes = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const StyledHeading('Include uppercase'),
                value: _checkedUpperCharacters,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _checkedUpperCharacters = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const StyledHeading('Include numbers'),
                value: _checkedNumbers,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _checkedNumbers = value;
                  });
                },
              ),
               CheckboxListTile(
                title: const StyledHeading('Include special characters'),
                value: _specialCharacters,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    _specialCharacters = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              StyledButton(
                onPressed: () {
                  var myPassword = generatePassword(_currentValue.toInt(), _checkedUpperCharacters, _checkedLowerCharactes, _checkedNumbers, _specialCharacters, context);
                  _textController.text = myPassword;
                },
                child: const Text('Generate password'),
              ),

              const SizedBox(height: 10),
              StyledButton(
                onPressed: () {
                  var snackBar = SnackBar(
                    content: Text('Password:  ${_textController.text} is copied to the clipboard'),
                  );
                  if (_textController.text.length == _currentValue.toInt()) {
                    Clipboard.setData(ClipboardData(text: _textController.text));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (_textController.text.length != _currentValue.toInt()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const StyledHeading('Set password length does not match current password length!\nTry pressing \'Generate password\' '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: StyledText('Ok'),
                          ),
                        ],
                      ),
                      barrierDismissible: false,
                    );
                  }
                },
                child: const Text('Copy to clipboard'), // remove this
              ),
            

            ],
          ),
        ),
      );
  }
}