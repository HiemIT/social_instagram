import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_instagram/utils/constants.dart';
import 'package:social_instagram/utils/shareds/shared_key.dart';

class SharedPreferencesApp {
  SharedPreferences? prefs;

  Future<void> initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }

    Constants.languageCode = await getLanguageCode();
  }

  Future setLanguageCode(String language) async {
    prefs?.setString(SharedKey.LANGUAGE_CODE, language);
  }

  Future<String> getLanguageCode() async {
    return prefs?.getString(SharedKey.LANGUAGE_CODE) ?? 'vi';
  }

  Future getDataLanguageSharedCommon() async {
    final lang = prefs?.getString(SharedKey.LANGUAGE_CODE) ?? 'vi';
    Constants.languageCode = lang;
  }
}

final shareds = SharedPreferencesApp();
