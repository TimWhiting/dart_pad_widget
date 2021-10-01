import 'package:flutter/material.dart';

import 'package:dart_pad_widget/dart_pad_widget.dart';

export 'package:dart_pad_widget/constants.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DartPad(
                  key: Key('runnable dart code'),
                  width: 500,
                  height: 400,
                  code: 'void main() => print("Hello DartPad Widget");',
                ),
                DartPad(
                  key: Key('dart with test, solution and hint'),
                  width: 800,
                  height: 400,
                  code: '''String helloDartPad() {
  return "Hello DartPad Widget";
}''',
                  hintText: 'You don\'t sound excited enough!',
                  testCode: '''main () {
  final String message = helloDartPad();
  if ((message) == "Hello DartPad Widget!") {
    return _result(true);
  };
  _result(false, ["Invalid hello message: \$message"]);
}''',
                  solutionCode: '''String helloDartPad() {
  return "Hello DartPad Widget!";
}''',
                ),
                DartPad(
                  key: Key('runnable Flutter code'),
                  width: 1000,
                  height: 400,
                  embeddingChoice: EmbeddingChoice.flutter,
                  darkMode: true,
                  code: """import 'package:flutter/material.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            child: Text('Hello, World!'),
          ),
        ),
      ),
    );
  }
}""",
                ),
                DartPad(
                  key: Key('runnable flutter code with false dark mode.'),
                  width: 800,
                  height: 400,
                  split: 60,
                  embeddingChoice: EmbeddingChoice.flutter,
                  darkMode: false,
                  runImmediately: true,
                  code: """import 'package:flutter/material.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            child: Text('Hello, World!'),
          ),
        ),
      ),
    );
  }
}""",
                ),
              ],
            ),
          )),
        ),
      ),
    ),
  );
}
