import 'package:bmob_plugin/bmob/bmob.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'app.dart';
import 'app/managers/notification.dart';
import 'bloc_provider_scope.dart';
import 'config/app_bloc_observer.dart';
// import 'config/app_lifecycle_listener.dart';
import 'config/bmob_config.dart';
// import 'firebase_options.dart';
import 'global_widget.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  
  await EasyLocalization.ensureInitialized();
  await NotificationService.initialize();
  
  
  // 初始化 Bmob
  if (BmobConfig.customDomain != null) {
    Bmob.resetDomain(BmobConfig.customDomain!);
  }
  Bmob.initialize(
    BmobConfig.secretKey,
    BmobConfig.apiSafe,
  );
  
  await di.setUpServiceLocator();
  
  // AppLifecycleListener(
  //   onDetach: () {
  //     FlutterSound().closePlayer();
  //   },
  // );
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      startLocale: const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
      ],
      fallbackLocale: const Locale('vi', 'VN'),
      child: const GlobalWidget(
        child: BlocProviderScope(
          child: MainApp(),
        ),
      ),
    ),
  );
}
