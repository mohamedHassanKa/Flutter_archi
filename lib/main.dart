import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'ui/shared/theme.dart';
import 'ui/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/providers/hotel_list_model.dart';
import './ui/shared/locator_setup/locator.dart';
import './core/services/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => locator<ThemeChanger>(),
      child: ChangeNotifierProvider<AppLocalizationProvider>(
        create: (context) => AppLocalizationProvider(),
        builder: (context, child) => const MaterialAppWithTheme(),
      ),
    );
  }
}

class MaterialAppWithTheme extends StatefulWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  _MaterialAppWithThemeState createState() => _MaterialAppWithThemeState();
}

class _MaterialAppWithThemeState extends State<MaterialAppWithTheme> {
  @override
  Widget build(BuildContext context) {
    final ThemeChanger theme = locator<ThemeChanger>();
    final languageChange = Provider.of<AppLocalizationProvider>(context);
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => locator<HotelListProvider>())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: generateRoute,
          initialRoute: '/walkthrough',
          theme: theme.getTheme(),
          locale: languageChange.appLocale,
          title: 'Restaurant Template',
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: const [
            Locale('fr', ''), // fr
            Locale('ar', ''), // arabic
            Locale('en', ''),
          ]),
    );
  }
}
