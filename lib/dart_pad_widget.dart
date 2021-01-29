// Copyright (c) 2020, Tim Whiting. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library dart_pad;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/material.dart';
import 'dart_pad_parser.dart';

String _valueOr(Map<String, String> map, String value, String defaultValue) {
  if (map.containsKey(value)) {
    return map[value]!;
  }

  return defaultValue;
}

var iframePrefix = 'https://dartpad.dev/';
String iframeSrc(Map<String, String> options) {
  var prefix = 'embed-${_valueOr(options, 'mode', 'dart')}.html';
  var theme = 'theme=${_valueOr(options, 'theme', 'light')}';
  var run = 'run=${_valueOr(options, 'run', 'false')}';
  var split = 'split=${_valueOr(options, 'split', 'false')}';
  // A unique ID used to distinguish between DartPad instances in an article or
  // codelab.
  var analytics = 'ga_id=${_valueOr(options, 'ga_id', 'false')}';

  return '$iframePrefix$prefix?$theme&$run&$split&$analytics';
}

Map<String, String> _parseFiles(String snippet) {
  return InjectParser(snippet).read();
}

/// A DartPad widget
class DartPad extends StatefulWidget {
  final double width;
  final double height;
  final bool darkMode;
  final bool flutter;
  final bool runImmediately;
  final String code;
  final bool split;
  DartPad(
      {required Key key,
      this.width = 600,
      this.height = 600,
      this.darkMode = true,
      this.flutter = false,
      this.runImmediately = false,
      this.split = false,
      this.code = "void main() { print('Hello World');}"})
      : super(key: key);

  @override
  _DartPadState createState() => _DartPadState();
}

class _DartPadState extends State<DartPad> {
  Map<String, String> get options => {
        'mode': widget.flutter ? 'flutter' : 'dart',
        'theme': widget.darkMode ? 'dark' : 'light',
        'run': widget.runImmediately ? 'true' : 'false',
        'split': widget.split ? 'true' : 'false',
        'ga_id': widget.key.toString(),
      };

  late html.IFrameElement iframe = html.IFrameElement()
    ..attributes = {'src': iframeSrc(options)};

  @override
  void initState() {
    super.initState();

    iframe.style.width = widget.width.toInt().toString();
    iframe.style.height = widget.height.toInt().toString();

    // print('dartpad${widget.key}');
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory('dartpad${widget.key}', (int viewId) => iframe);
    html.window.addEventListener('message', (dynamic e) {
      if (e.data['type'] == 'ready') {
        // print(e);
        var m = {
          'sourceCode': _parseFiles(HtmlUnescape().convert(widget.code)),
          'type': 'sourceCode'
        };
        iframe.contentWindow!.postMessage(m, '*');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: HtmlElementView(viewType: 'dartpad${widget.key}'),
    );
  }
}
