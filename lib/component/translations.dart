import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:schedualmoon/languages/ar.dart';
import 'package:schedualmoon/languages/en.dart';
import 'package:universal_html/html.dart';

class Translation extends Translations {
  var selectedLanguage = "ar".obs;
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };

  getLanguage() async {
    Storage _localStorage = window.localStorage;
    selectedLanguage.value = _localStorage['lang']!;
  }

  void saveLanguage() async {
    print("set string selectedlanguage");
    Storage _localStorage = window.localStorage;
    _localStorage['lang'] = selectedLanguage.value;
  }

  void changeLanguage(String _language) async {
    getLanguage();
    selectedLanguage.value = _language;
    Get.updateLocale(Locale(selectedLanguage.value));
    saveLanguage();
  }
}
