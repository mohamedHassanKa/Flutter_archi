import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'ui/shared/theme.dart';
import 'ui/router.dart';

import './core/card_list_model.dart';
import './core/hotelListModel.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness:
        Platform.isAndroid ? Brightness.dark : Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(),
      child: const MaterialAppWithTheme(),
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
    final theme = Provider.of<ThemeChanger>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CardListModelView()),
        ChangeNotifierProvider(create: (context) => HotelListModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: generateRoute,
        initialRoute: '/walkthrough',
        theme: theme.getTheme(),
        title: 'Restaurant Template',
      ),
    );
  }
}
