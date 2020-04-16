import 'utils.dart';

enum Language { UA, EN, RU }

extension Locale on Language {
  static const Map<Language, String> _mapping = {Language.UA: 'ua', Language.EN: 'en', Language.RU: 'ru'};

  static Language fromString(String value) => Locale._mapping.keyForValue(value);

  String string() => _mapping[this];

  static Map<Language, String> parseLocalizedText(String keyPrefix, Map<String, dynamic> source) {
    Map<Language, String> parsedText;
    if (source != null) {
      parsedText = {};
      Language.values.forEach((language) {
        parsedText[language] = source[keyPrefix + language.string()];
      });
    }
    return parsedText;
  }
}
