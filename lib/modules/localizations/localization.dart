import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Localization {
  final Locale locale;

  Localization(this.locale);

  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  Map<String, String>? _localizedValues;

  Future load() async {
    String jsonStringValue = await rootBundle
        .loadString("assets/locales/${locale.languageCode}.json");
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValue);
    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  Map<String, String> getTranslatedValues(String key) {
    return _localizedValues!;
  }

  static const LocalizationsDelegate<Localization> delegate =
      _LocalizationDelegate();
}

class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'vi'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    Localization localization = new Localization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}
