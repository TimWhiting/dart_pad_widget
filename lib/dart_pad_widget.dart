// Copyright (c) 2020, Tim Whiting. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library dart_pad;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:html_unescape/html_unescape.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart_pad_parser.dart';

extension MapUtils<K, V> on Map<K, V> {
  V getOrElse(K key, {required V orElse}) {
    if (containsKey(key)) {
      return this[key]!;
    } else {
      this[key] = orElse;
      return orElse;
    }
  }
}

Map<String, String> _parseFiles(String snippet) {
  return InjectParser(snippet).read();
}

const _dartPadHost = 'dartpad.dev';

/// A DartPad widget
class DartPad extends StatefulWidget {
  DartPad({
    required Key key,
    this.embeddingChoice = EmbeddingChoice.dart,
    this.width = 600,
    this.height = 600,
    this.darkMode = true,
    this.runImmediately = false,
    this.split,
    this.code = "void main() { print('Hello World');}",
  })  : assert(split == null || (split <= 100 && split >= 0)),
        super(key: key);

  final double width;
  final double height;
  final EmbeddingChoice embeddingChoice;
  final bool darkMode;
  final bool runImmediately;
  final String code;
  final int? split;

  @override
  _DartPadState createState() => _DartPadState();

  String get iframeSrc {
    Uri uri = Uri.https(
      _dartPadHost,
      embeddingChoiceToString(embeddingChoice),
      <String, String>{
        kThemeKey: darkMode ? kDarkMode : kLightMode,
        kRunKey: runImmediately.toString(),
        if (split != null) kSplitKey: split.toString(),
        kAnalyticsKey: true.toString(),
      },
    );
    return uri.toString();
  }

  String get iframeStyle {
    return "width:${width}px;height:${height}px;";
  }
}

class _DartPadState extends State<DartPad> {
  late html.IFrameElement iframe = html.IFrameElement()
    ..attributes = {
      'src': widget.iframeSrc,
      'style': widget.iframeStyle,
    };

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
