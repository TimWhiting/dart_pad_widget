# DartPad Flutter Web Plugin

A new Flutter package that allows you to easily embed DartPad into your Flutter Web application.

```
import 'package:flutter/material.dart';
import 'package:dart_pad_widget/dart_pad_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DartPad(
                  key: Key('example1'),
                  width: 500,
                  height: 400,
                  code: 'void main() => print("Hello DartPad Widget");',
                ),
              ],
            ),
          ),
        ),
      ),
    );
```

Some code was borrowed from the dart-lang/dart-pad [repository](https://github.com/dart-lang/dart-pad).
Credit for that goes to them.

It should support most of the features listed in the embedding [guide](https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide)

Contributions welcome