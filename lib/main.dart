import 'colors.dart';
import 'question_man.dart';

import 'home_page.dart';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(EasyDynamicThemeWidget(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  static Data d = getData();
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowCheckedModeBanner: false,
      title: 'Truth or Dare',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primaryColor: MyColors.primary,
        brightness: Brightness.dark,
        /*colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: MyColors.primary,
              onPrimary: MyColors.onprimary,
              secondary: MyColors.accent,
              onSecondary: MyColors.onaccent,
              error: MyColors.error,
              onError: MyColors.onerror,
              background: ShadowColors.dark,
              onBackground: ShadowColors.light,
              surface: MyColors.surface,
              onSurface: MyColors.onsurface) */
        //ColorScheme.fromSwatch().copyWith(secondary: MyColors.accent),
      ),
      themeMode: EasyDynamicTheme.of(context).themeMode,
      home: const MyHomePage(title: 'Truth or Dare'),
    );
  }
}
