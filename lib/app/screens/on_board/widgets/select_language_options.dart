import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/gen/assets.gen.dart';
import '../../../managers/language.dart';
import '../../../translations/translations.dart';
import '../../../widgets/gap.dart';
import 'language_option_tile.dart';

class SelectLanguageOptionsWidget extends StatefulWidget {
  const SelectLanguageOptionsWidget({super.key});

  @override
  State<SelectLanguageOptionsWidget> createState() =>
      _SelectLanguageOptionsWidgetState();
}

class _SelectLanguageOptionsWidgetState
    extends State<SelectLanguageOptionsWidget> {
  Future<void> setAppLanguage(AppLocale appLocale) async {
    await context.setLocale(appLocale.instance);
    if (mounted) {
      context.read<LanguageCubit>().changeLanguage(appLocale.instance);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          LanguageOptionWidget(
            onTap: () async => await setAppLanguage(AppLocale.en),
            text: LocaleKeys.app_language_english.tr(),
            icon: Assets.icons.englishRound,
            isSelected:
                context.locale.languageCode == AppLocale.en.languageCode,
          ),
          const Gap(height: 10),
          LanguageOptionWidget(
            onTap: () async => await setAppLanguage(AppLocale.zh_CN),
            text: LocaleKeys.app_language_zh_CN.tr(),
            icon: Assets.icons.vietnamRound,
            isSelected:
                context.locale.languageCode == AppLocale.zh_CN.languageCode,
          ),
          const Gap(height: 10),
          LanguageOptionWidget(
            onTap: () async => await setAppLanguage(AppLocale.zh_TW),
            text: LocaleKeys.app_language_zh_TW.tr(),
            icon: Assets.icons.vietnamRound,
            isSelected:
                context.locale.languageCode == AppLocale.zh_TW.languageCode,
          ),
        ],
      ),
    );
  }
}
