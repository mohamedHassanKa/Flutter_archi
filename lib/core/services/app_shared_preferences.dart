import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class AppSharedPreferences {
  AppSharedPreferences(this._sharedPreferences);

  final SharedPreferences? _sharedPreferences;

  dynamic getField(String key) {
    if (_sharedPreferences?.containsKey(key) != null)
      return _sharedPreferences?.get(key);
    else
      return null;
  }

  bool containsKey(String key) {
    if (_sharedPreferences != null) {
      return _sharedPreferences!.containsKey(key);
    }
    return false;
  }

  Future<void> setStringField(String key, String value) async {
    await _sharedPreferences?.setString(key, value);
  }

  void setIntField(String key, int value) {
    _sharedPreferences?.setInt(key, value);
  }

  void setDoubleField(String key, double value) {
    _sharedPreferences?.setDouble(key, value);
  }

  void setBoolField(String key, bool value) {
    _sharedPreferences?.setBool(key, value);
  }

  void setStringListField(String key, List<String> value) {
    _sharedPreferences?.setStringList(key, value);
  }

  void clearField(String key) {
    _sharedPreferences?.remove(key);
  }

  void clearSharedPreference() {
    _sharedPreferences?.clear();
  }

  void setObject<T>(String key, T value) {
    _sharedPreferences?.setString(key, json.encode(value));
  }

  dynamic getObject<T>(String key) {
    final String? _object = _sharedPreferences?.getString(key);
    if (_object != null) {
      return json.decode(_object);
    } else {
      return null;
    }
  }

  // String? getLanguage() {
  //   return _sharedPreferences?.getString(localLanguageKey);
  // }

  // bool getDarkModeActivation() {
  //   return _sharedPreferences?.getBool(isDarkModeActivated) ?? false;
  // }

  // void setDarkModeActivation(bool value) {
  //   _sharedPreferences?.setBool(isDarkModeActivated, value);
  // }

  // void setThemeDataEnum(AppThemeEnum value) {
  //   _sharedPreferences?.setString(themeDataEnum, value.getStringFromTheme());
  // }

  // AppThemeEnum getThemeDataEnum() {
  //   return _sharedPreferences?.getString(themeDataEnum)?.getThemeFromString() ??
  //       AppThemeEnum.LightBlue;
  // }

  // String? getAuthorisationBearerToken() {
  //   if (containsKey(authorisationToken)) {
  //     return bearerKey + getField(authorisationToken);
  //   } else {
  //     return null;
  //   }
  // }

  // String? getOfferStoredId() {
  //   return _sharedPreferences?.getString(offerStoredId);
  // }

  // void setOfferStoredId(String value) {
  //   _sharedPreferences?.setString(offerStoredId, value);
  // }
}
