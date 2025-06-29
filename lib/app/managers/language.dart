import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../translations/translations.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState.zh_CN());
  void changeLanguage(Locale locale) {
    emit(LanguageState(locale));
  }
}

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  LanguageState.en() : this(AppLocale.en.instance);
  LanguageState.zh_CN() : this(AppLocale.zh_CN.instance);
  LanguageState.zh_TW() : this(AppLocale.zh_TW.instance);

  @override
  List<Object?> get props => [locale];
}
