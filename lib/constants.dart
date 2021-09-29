const String kThemeKey = 'theme';
const String kRunKey = 'run';
const String kSplitKey = 'split';
const String kAnalyticsKey = 'ga_ad';

const String kDarkMode = 'dark';
const String kLightMode = 'light';



/// The embedding type to use with dart pad.
///
/// See: https://github.com/dart-lang/dart-pad/wiki/Embedding-Guide#embedding-choices
enum EmbeddingChoice {
  dart,
  inline,
  flutter,
  html,
}

String embeddingChoiceToString(EmbeddingChoice embeddingChoice) {
  late String choiceText;
  switch (embeddingChoice) {
    case EmbeddingChoice.dart:
      choiceText = 'dart';
      break;
    case EmbeddingChoice.inline:
      choiceText = 'inline';
      break;
    case EmbeddingChoice.flutter:
      choiceText = 'flutter';
      break;
    case EmbeddingChoice.html:
      choiceText = 'html';
      break;
  }
  return 'embed-$choiceText.html';
}
