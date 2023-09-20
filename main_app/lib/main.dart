import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:main_app/core/extensions/string_ext.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/locale_keys.g.dart';
import 'package:main_app/modules/boarding/app/ui/splash/splash_page.dart';
import 'package:main_app/theme/ui_color.dart';
import 'package:main_app/theme/ui_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await setupInjector();
  setupEasyLoading();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('vn')],
      path: 'resources/langs',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          transitionDuration: const Duration(milliseconds: 200),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: LocaleKeys.app_name.trans(),
          theme: uiTheme,
          navigatorObservers: [injector<RouteObserver<Route>>()],
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: FlutterEasyLoading(child: child),
            );
          },
          home: const SplashPage(),
        );
      },
    );
  }
}

void setupEasyLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..maskType = EasyLoadingMaskType.black
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = UIColor.white
    ..indicatorColor = UIColor.black
    ..progressColor = UIColor.black
    ..userInteractions = false
    ..textColor = UIColor.black;
}
