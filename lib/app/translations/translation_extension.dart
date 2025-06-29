import 'dart:ui';

enum AppLocale { en, zh_CN, zh_TW }

extension AppLocaleExtension on AppLocale {
  Locale get instance {
    switch (this) {
      case AppLocale.en:
        return const Locale('en', 'US');
      case AppLocale.zh_CN:
        return const Locale('zh', 'CN');
      case AppLocale.zh_TW:
        return const Locale('zh', 'TW');
      default:
        return const Locale('en', 'US');
    }
  }

  String get languageCode {
    switch (this) {
      case AppLocale.en:
        return 'en';
      case AppLocale.zh_CN:
        return 'zh_CN';
      case AppLocale.zh_TW:
        return 'zh_TW';
      default:
        return 'en';
    }
  }
}
