import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku_app/core/init/provider/intro_provider.dart';
import 'package:sudoku_app/view/auth/splash/splash_view.dart';
import 'core/constants/app/color_constants.dart';
import 'core/constants/app/app_constants.dart';
import 'core/init/provider/locale_provider.dart';
import 'core/utils/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleProvider appLanguage = LocaleProvider();
  await appLanguage.fetchLocale();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<IntroProvider>(create: (_) => IntroProvider()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.support,
          locale: provider.appLocal,
          theme: ThemeData(
            primarySwatch: ColorConstants.primaryColor,
          ),
          home: const SplashView(),
        );
      },
    );
  }
}
