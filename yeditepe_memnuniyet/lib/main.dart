import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/constants.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/services/calculator_service.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:yeditepe_memnuniyet/services/language_service.dart';
import 'package:yeditepe_memnuniyet/services/notification_service.dart';
import 'package:yeditepe_memnuniyet/services/theme_service.dart';
import 'package:yeditepe_memnuniyet/views/user/splash_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ThemeService().createSharedPreferencesObject();
  await LanguageService().createSharedPreferencesObject();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeService>(create: (BuildContext context) => ThemeService()),
        ChangeNotifierProvider<LanguageService>(create: (BuildContext context) => LanguageService()),
        ChangeNotifierProvider<AuthService>(create: (BuildContext context) => AuthService()),
        ChangeNotifierProvider<CalculatorService>(create: (BuildContext context) => CalculatorService()),
        ChangeNotifierProvider<DatabaseService>(create: (BuildContext context) => DatabaseService()),
        ChangeNotifierProvider<NotificationService>(create: (BuildContext context) => NotificationService()),
      ],
      child: EasyLocalization(
          supportedLocales: AppConstant.SUPPORTED_LOCALE,
          path: AppConstant.LANG_PATH,
          fallbackLocale: Locale('tr', 'TR'),
          child: MyApp()
      )));
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeService>(context).loadFromSharedPreferences();
    Provider.of<LanguageService>(context).loadFromSharedPreferences();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Yeditepe',
      theme: Provider.of<ThemeService>(context).selectedTheme,
      home: SplashView(),
    );
  }
}

