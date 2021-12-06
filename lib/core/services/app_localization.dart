// import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_shared_preferences.dart';
import '../../ui/shared/locator_setup/locator.dart';
import '../constants/app_constants.dart';

class AppLocalizationProvider extends ChangeNotifier {
  final AppSharedPreferences _prefs = locator<AppSharedPreferences>();

  Locale? appLocale;

  AppLocalizationProvider() {
    appLocale = Locale('fr', '');
  }

  ///this method allows you to change the language
  ///of the application according to the desired locale
  void changeLanguage(BuildContext context, String? locale) {
    if (locale != null) {
      appLocale = Locale(locale, '');
    } else {
      appLocale = const Locale('fr', '');
      // locale = 'ar';
      // }
    }
    notifyListeners();

    /// the newLocale is the stored locale variable
    addLocaleToSharedPref(locale);
  }

  ///this method allows you to add your locale to locale storage using shared pref
  Future<void> addLocaleToSharedPref(String? languageCode) async {
    _prefs.setStringField(localLanguageKey, languageCode ?? '');
  }

  ///this method allows you to get your locale from locale storage using shared pref
  /// also update the locale of the app

  Future<String?> getLocaleFromSharedPref() async {
    final String? locale = _prefs.getField(localLanguageKey);
    return locale;
  }
}
