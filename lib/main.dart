import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app.dart';
import 'app/managers/notification.dart';
import 'bloc_provider_scope.dart';
import 'config/app_bloc_observer.dart';
import 'firebase_options.dart';
import 'global_widget.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await Supabase.initialize(
    url: 'https://mtimvoncronhadlgwlyf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im10aW12b25jcm9uaGFkbGd3bHlmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE4ODQyNDksImV4cCI6MjA2NzQ2MDI0OX0.dR_W9d_7sHnxendpf1_cPfQTRN8Br6ifm7_bBelIM8o',
  );
  await EasyLocalization.ensureInitialized();
  await NotificationService.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.setUpServiceLocator();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const GlobalWidget(child: BlocProviderScope(child: MainApp())));
}
