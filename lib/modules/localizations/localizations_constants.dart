import 'package:flutter/cupertino.dart';
import 'package:social_instagram/utils/shareds/shared_preferences.dart';

import 'localization.dart';

Map<String, String> getTranslated(BuildContext context, String key) {
  return Localization.of(context)!.getTranslatedValues(key);
}

const String ENGLISH = 'en';
const String VIETNAMESE = 'vi';

const String LANGUAGE_CODE = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  await shareds.setLanguageCode(languageCode);
  shareds.getDataLanguageSharedCommon();
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'EN');
      break;
    case VIETNAMESE:
      _temp = Locale(languageCode, 'VN');
      break;
    default:
      _temp = Locale(VIETNAMESE, 'VN');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  String languageCode = await shareds.getLanguageCode() ?? VIETNAMESE;
  return _locale(languageCode);
}
